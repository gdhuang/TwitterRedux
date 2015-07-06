//
//  ProfileViewController.m
//  twitter
//
//  Created by GD Huang on 7/5/15.
//  Copyright (c) 2015 gdhuang. All rights reserved.
//

#import "ProfileViewController.h"
#import <UIImageView+AFNetworking.h>
#import "User.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *numTweets;
@property (weak, nonatomic) IBOutlet UILabel *numFollowing;
@property (weak, nonatomic) IBOutlet UILabel *numFollowers;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *screenName;

@end

@implementation ProfileViewController

- (id) initWithUser:(User*)user {
    self = [super init];
    self.user = user;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target: self action:@selector(onHomeButton)];
    
    [self.avatarImage setImageWithURL: [NSURL URLWithString:self.user.profileImageUrl]];
    self.name.text = self.user.name;
    self.screenName.text = self.user.screenName;
    self.numTweets.text = [NSString stringWithFormat:@"%@ \nTWEETS", self.user.numTweets];
    self.numFollowing.text = [NSString stringWithFormat:@"%@ \nFOLLOWING", self.user.numFollowing];
    self.numFollowers.text = [NSString stringWithFormat:@"%@ \nFOLLOWERS", self.user.numFollowers];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) onHomeButton {

    [self dismissViewControllerAnimated:YES completion:nil];
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
