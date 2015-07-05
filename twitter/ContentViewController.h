//
//  ContentViewController.h
//  twitter
//
//  Created by GD Huang on 7/5/15.
//  Copyright (c) 2015 gdhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMenuViewController.h"


@interface ContentViewController : UIViewController<MenuViewContentControllerDelegate>


- (void)didSelectMenuItem:(id)selectedItem;

@end
