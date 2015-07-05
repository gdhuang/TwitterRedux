//
//  MenuViewController.m
//  twitter
//
//  Created by GD Huang on 7/5/15.
//  Copyright (c) 2015 gdhuang. All rights reserved.
//

#import "MyMenuViewController.h"



@interface MyMenuViewController ()


@end

@implementation MyMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSelect:(id)sender {
    [self.delegate didSelectMenuItem:sender];
    [self.sideMenuViewController closeSideMenu];
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
