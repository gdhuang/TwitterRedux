//
//  TweetsTableViewCell.m
//  twitter
//
//  Created by GD Huang on 6/30/15.
//  Copyright (c) 2015 gdhuang. All rights reserved.
//

#import "TweetsTableViewCell.h"
#import <UIImageView+AFNetworking.h>



@implementation TweetsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
    self.text.text = _tweet.text;
    self.name.text = _tweet.user.name;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    self.timestamp.text = [dateFormatter stringFromDate:_tweet.createdAt] ;
    [self.avatarImage setImageWithURL: [NSURL URLWithString:_tweet.user.profileImageUrl]];
    
    
    if(_tweet.retweeted) {
        [self.retweetBtn setImage:[UIImage imageNamed:@"retweet_on.png"] forState:UIControlStateNormal];
    }
    if(_tweet.favorited) {
        [self.favoriteBtn setImage:[UIImage imageNamed:@"favorite_on.png"] forState:UIControlStateNormal];
    }
}

- (void)prepareForReuse {
    [self.retweetBtn setImage:[UIImage imageNamed:@"retweet.png"] forState:UIControlStateNormal];
    [self.favoriteBtn setImage:[UIImage imageNamed:@"favorite.png"] forState:UIControlStateNormal];
}

@end
