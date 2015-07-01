//
//  TweetsViewController.h
//  twitter
//
//  Created by GD Huang on 6/29/15.
//  Copyright (c) 2015 gdhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewTweetViewController.h"
#import "TweetDetailsViewController.h"


@interface TweetsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,NewTweetViewControllerDelegate,TweetDetailsViewControllerDelegate>

@end
