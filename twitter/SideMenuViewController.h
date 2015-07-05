//
//  SideMenuViewController.h
//  twitter
//
//  Created by GD Huang on 7/5/15.
//  Copyright (c) 2015 gdhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"

@class MenuViewController;

@interface SideMenuViewController : UIViewController


- (id)initWithMenuViewController:(MenuViewController *)mvc contentViewController:(UIViewController *)cvc;


- (void) openSideMenu;
- (void) closeSideMenu;
@end
