//
//  Tweet.h
//  twitter
//
//  Created by GD Huang on 6/29/15.
//  Copyright (c) 2015 gdhuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *tweetID;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSNumber *retweetCount;
@property (nonatomic, strong) NSNumber *favoriteCount;
@property BOOL retweeted;
@property BOOL favorited;

- (id) initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)tweetWithArray:(NSArray *)array;
@end
