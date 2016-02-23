//
//  ServiceOrderSvcCoreData.m
//  Roofster
//
//  Created by Travis  on 2/21/16.
//  Copyright © 2016 msse650. All rights reserved.
//

#import "ServiceOrderSvcCoreData.h"

@implementation ServiceOrderSvcCoreData

NSManagedObjectModel *model = nil;

NSPersistentStoreCoordinator *psc = nil;

NSManagedObjectContext *moc = nil;

- (id) init
{
    if (self = [super init])
    {
        [self initializeCoreData];
        return self;
    }
    return nil;
}

- (ServiceOrder *) createManagedServiceOrder {
    
    ServiceOrder *serviceOrder =
    [NSEntityDescription insertNewObjectForEntityForName:@"ServiceOrder" inManagedObjectContext:moc];
    
    return serviceOrder;
}

- (ServiceOrder *) createServiceOrder: (ServiceOrder *) serviceOrder {
    ServiceOrder *managedServiceOrder = [self createManagedServiceOrder];
    managedServiceOrder.name = serviceOrder.name;
    managedServiceOrder.address = serviceOrder.address;
    managedServiceOrder.repairDetail = serviceOrder.repairDetail;
    NSError *error;
    if (![moc save:&error]) {
        NSLog(@"createServiceOrder ERROR: %@", [error localizedDescription]);
    }

    
    return serviceOrder;
}

- (NSArray *) retrieveAllServiceOrders {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ServiceOrder" inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"name"ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSError *error;
    NSArray *fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
    
    
    return fetchedObjects;
}


- (ServiceOrder *) updateServiceOrder: (ServiceOrder *) serviceOrder {
    
    NSError *error;
    if(![moc save:&error]){
        NSLog(@"updateServiceOrderERROR: %@", [error localizedDescription]);
    }
    return serviceOrder;
}

- (ServiceOrder *) deleteServiceOrder: (ServiceOrder *) serviceOrder {
    [moc deleteObject:serviceOrder]; 
    return serviceOrder; }


-(void) initializeCoreData
{
    // initialize (load) the schema model
    NSURL *modelURL = [[NSBundle mainBundle]URLForResource:@"Model" withExtension:@"momd"];
    model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    // initialize the persistent store coordinator with the model
    NSURL *applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    NSURL *storeURL = [applicationDocumentsDirectory URLByAppendingPathComponent:@"Roofster.sqlite"];
    NSError *error = nil;
    psc = [[NSPersistentStoreCoordinator alloc]
           initWithManagedObjectModel:model];
    
    if ([psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil
         URL:storeURL options:nil error:&error])
    { // initialize the managed object context
        moc = [[NSManagedObjectContext alloc]
               initWithConcurrencyType:NSMainQueueConcurrencyType];
        [moc setPersistentStoreCoordinator:psc];
    }
    else
    {
        NSLog(@"initializeCoreData FAILED with error: %@", error);
    }
    

}

@end
