//
//  ViewController.h
//  Roofster
//
//  Created by Travis  on 1/31/16.
//  Copyright © 2016 msse650. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"



@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextView *repairDetail;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


- (IBAction)saveButton:(id)sender;

- (IBAction)deleteButton:(id)sender;

@end

