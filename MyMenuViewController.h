//
//  MenuViewController.h
//  twitter
//
//  Created by GD Huang on 7/5/15.
//  Copyright (c) 2015 gdhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SideMenuViewController.h"

@protocol MenuViewContentControllerDelegate <NSObject>

- (void)didSelectMenuItem:(id)selectedItem;

@end



@interface MyMenuViewController : MenuViewController


@property (nonatomic, weak) id<MenuViewContentControllerDelegate> delegate;


@end
