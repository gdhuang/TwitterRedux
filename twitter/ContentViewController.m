//
//  ContentViewController.m
//  twitter
//
//  Created by GD Huang on 7/5/15.
//  Copyright (c) 2015 gdhuang. All rights reserved.
//

#import "ContentViewController.h"
#import "TweetsViewController.h"
#import "MentionsViewController.h"
#import "ProfileViewController.h"




@interface ContentViewController ()

@property (strong, nonatomic) TweetsViewController* tweetsViewController;
@property (strong, nonatomic) MentionsViewController* mentionsViewController;
@property (strong, nonatomic) ProfileViewController* profileViewController;
@property (strong, nonatomic) UINavigationController* nvc;

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.tweetsViewController = [[TweetsViewController alloc] initWithNibName:@"TweetsViewController" bundle:nil];
    self.mentionsViewController = [[MentionsViewController alloc] initWithNibName:@"MentionsViewController" bundle:nil];
    self.profileViewController = [[ProfileViewController alloc] initWithUser:[User currentUser]];
    self.nvc = [[UINavigationController alloc] init];
    
    self.nvc.view.frame = self.view.frame;
    [self addChildViewController:self.nvc];
    [self.view addSubview:self.nvc.view];
    
    [self showTimeline];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didSelectMenuItem:(id)selectedItem {
    UIButton *btn = (UIButton*) selectedItem;
    
    if([btn.titleLabel.text isEqualToString:@"Profile"]) {
        [self showProfile];
    } else if([btn.titleLabel.text isEqualToString:@"Timeline"]) {
        [self showTimeline];
    } else if([btn.titleLabel.text isEqualToString:@"Mentions"]) {
        [self showMentions];
    }
    
    
    
}

- (void)showTimeline {
    [self.nvc setViewControllers:@[self.tweetsViewController]];
}

- (void)showMentions {
    [self.nvc setViewControllers:@[self.mentionsViewController]];
}

- (void)showProfile {
    [self.nvc setViewControllers:@[self.profileViewController]];
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
