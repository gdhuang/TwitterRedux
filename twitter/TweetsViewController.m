//
//  TweetsViewController.m
//  twitter
//
//  Created by GD Huang on 6/29/15.
//  Copyright (c) 2015 gdhuang. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "Tweet.h"
#import "TwitterClient.h"
#import "TweetsTableViewCell.h"
#import "NewTweetViewController.h"
#import "TweetDetailsViewController.h"

@interface TweetsViewController ()

@property (nonatomic,strong) NSArray *tweets;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (weak, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation TweetsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"TweetsTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"TweetsTableViewCell"];
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    
    self.navigationItem.title = @"Home";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(onNewTweet)];
    [self setupRefreshControl];
    [self updateTimeline];

}

- (void) setupRefreshControl {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self
                       action:@selector(updateTimeline)
             forControlEvents:UIControlEventValueChanged];
    refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Pull To Refresh"];

    self.refreshControl = refreshControl;
    [self.tableview insertSubview:refreshControl atIndex:0];
    
}

- (void) updateTimeline {
    
    [[TwitterClient sharedInstance] homeTimelineWithParms:nil completion:^(NSArray *tweets, NSError *error) {
        NSLog(@"%@", tweets);
        [self.refreshControl endRefreshing];
        
        self.tweets = tweets;
        [self.tableview reloadData];
    }];
    
}

- (void) onNewTweet {
    NewTweetViewController *vc = [[NewTweetViewController alloc
                                  ] init];

    vc.delegate = self;
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLogout:(id)sender {
    [User logout];
}

- (void)logout {
    [User logout];
}

#pragma mark - table view

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetsTableViewCell" forIndexPath:indexPath];
    cell.tweet = self.tweets[indexPath.row];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;//workaround: UITableView layout messing up on push segue and return
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetDetailsViewController *vc = [[TweetDetailsViewController alloc] init];
    vc.tweet = self.tweets[indexPath.row];
    
    vc.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
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
