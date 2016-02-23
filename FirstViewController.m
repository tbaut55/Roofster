//
//  FirstViewController.m
//  Roofster
//
//  Created by Travis  on 2/7/16.
//  Copyright © 2016 msse650. All rights reserved.
//

#import "FirstViewController.h"
#import "ViewController.h"


@interface FirstViewController ()

@end

@implementation FirstViewController



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([_usernameTextField isFirstResponder] && [touch view] != _usernameTextField) {
        [_usernameTextField resignFirstResponder];
    }
    else if ([_passwordTextField isFirstResponder] && [touch view] != _passwordTextField) {
        [_passwordTextField resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
