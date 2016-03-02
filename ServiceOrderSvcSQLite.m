//
//  ServiceOrderSvcSQLite.m
//  Roofster
//
//  Created by Travis  on 2/28/16.
//  Copyright © 2016 msse650. All rights reserved.
//

#import "ServiceOrderSvcSQLite.h"

#import "sqlite3.h"

@implementation ServiceOrderSvcSQLite

NSString *databasePath = nil;
sqlite3 *database = nil;


- (id) init
{
    if ((self = [super init]))
    {
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documensDir = [documentPaths objectAtIndex:0];
        databasePath = [documensDir stringByAppendingPathComponent:@"roofster.sqlite3"];
        
        if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
        {
            NSLog(@"database is open");
            NSLog(@"database [file path: %@", databasePath);
        }
        else
        {
            NSLog(@"*** Failed to open database!");
            NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
        }
    }
    return nil;
}

- (ServiceOrder *) createServiceOrder: (ServiceOrder *) serviceOrder
{
    sqlite3_stmt * statement;
    NSString *insertSQL = [NSString stringWithFormat:
                           @"INSERT INTO serviceOrder (name, address, repairDetail) Values (\"%@\", \"%@\", \"%@\")",
                           serviceOrder.name, serviceOrder.address, serviceOrder.repairDetail];
    if(sqlite3_prepare_v2(database, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        if(sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"*** ServiceOrder added");
        }
        else
        {
            NSLog(@"*** ServiceOrder NOT added");
            NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
        }
        
        sqlite3_finalize(statement);
    }
    return serviceOrder;
}

- (NSMutableArray *) retrieveAllServiceOrders
{
    NSMutableArray *serviceOrders = [NSMutableArray array];
    NSString *selectSQL = [NSString stringWithFormat:@"SELECT * FROM serviceOrder ORDER BY name"];
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(database, [selectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        NSLog(@"*** ServiceOrders retrieved");
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            char *nameChars = (char * )sqlite3_column_text(statement, 1);
            char *addressChars = (char * )sqlite3_column_text(statement, 2);
            char *repairDetailChars = (char * )sqlite3_column_text(statement, 3);
            
            ServiceOrder *serviceOrder = [[ServiceOrder alloc]init];
            serviceOrder.name = [[NSString alloc] initWithUTF8String:nameChars];
            serviceOrder.address = [[NSString alloc] initWithUTF8String:addressChars];
            serviceOrder.repairDetail = [[NSString alloc] initWithUTF8String:repairDetailChars];
            [serviceOrders addObject:serviceOrder];
        }
        sqlite3_finalize(statement);
        
    }
    else
    {
        NSLog(@"*** ServiceOrders not retrieved");
        NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
    }
    return serviceOrders;
}

- (ServiceOrder *) updateServiceOrder: (ServiceOrder *) serviceOrder
{
    NSString *updateSQL = [NSString stringWithFormat:
                           @"UPDATE serviceOrder SET name =\"%@\", address =\"%@\", repairDetail =\"%@\" ",
                           serviceOrder.name, serviceOrder.address, serviceOrder.repairDetail];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [updateSQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
       if(sqlite3_step(statement) == SQLITE_DONE)
       {
           NSLog(@"*** ServiceOrder updated");
       }
       else
       {
           NSLog(@"*** ServiceOrders not updated");
           NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
       }
        sqlite3_finalize(statement);
    }
    
    return serviceOrder;
}

- (ServiceOrder *) deleteServiceOrder: (ServiceOrder *) serviceOrder
{
    return serviceOrder;
}

@end
