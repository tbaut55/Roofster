//
//  ViewController.m
//  Roofster
//
//  Created by Travis  on 1/31/16.
//  Copyright © 2016 msse650. All rights reserved.
//

#import "ViewController.h"

#import "ServiceOrder.h"
#import "ServiceOrderSvcSQLite.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([_name isFirstResponder] && [touch view] != _name) {
        [_name resignFirstResponder];
    }
    
    else if ([_address isFirstResponder] && [touch view] != _address) {
        [_address resignFirstResponder];
    }
    
    else if ([_repairDetail isFirstResponder] && [touch view] != _repairDetail) {
        [_repairDetail resignFirstResponder];
    }
    
    [super touchesBegan:touches withEvent:event];
}


 ServiceOrderSvcSQLite *serviceOrderSvc = nil;


- (void)viewDidLoad {
    [super viewDidLoad];
    serviceOrderSvc = [[ServiceOrderSvcSQLite alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButton:(id)sender
{
    NSLog(@"saveServiceOrder: entering");
    
    [self.view endEditing:YES];
    
    ServiceOrder *serviceOrder = [[ServiceOrder alloc] init];
    serviceOrder.name = _name.text;
    serviceOrder.address = _address.text;
    serviceOrder.repairDetail = _repairDetail.text;
    [serviceOrderSvc createServiceOrder:serviceOrder];
    
    [self.tableView reloadData];
    NSLog(@"saveServiceOrder: serviceOrder saved");
}

- (IBAction)deleteServiceOrder:(id)sender {
    NSLog(@"deleteServiceOrder");
    
    [self.view endEditing:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[serviceOrderSvc retrieveAllServiceOrders] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:simpleTableIdentifier]; if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    ServiceOrder *serviceOrder = [[serviceOrderSvc retrieveAllServiceOrders]
                        objectAtIndex:indexPath.row];
    cell.textLabel.text = [serviceOrder description];
    return cell;
}


- (IBAction)deleteButton:(id)sender {
}
@end


































