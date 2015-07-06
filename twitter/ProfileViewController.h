//
//  ProfileViewController.h
//  twitter
//
//  Created by GD Huang on 7/5/15.
//  Copyright (c) 2015 gdhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface ProfileViewController : UIViewController

@property (nonatomic, weak) User* user;

- (id)initWithUser:(User*)user;
@end
