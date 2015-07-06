//
//  User.h
//  twitter
//
//  Created by GD Huang on 6/29/15.
//  Copyright (c) 2015 gdhuang. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString* const UserDidLoginNotification;
extern NSString* const UserDidLogoutNotification;



@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *tagline;

@property (nonatomic, strong) NSString *numTweets;
@property (nonatomic, strong) NSString *numFollowing;
@property (nonatomic, strong) NSString *numFollowers;

- (id) initWithDictionary:(NSDictionary *)dictionary;

+ (User *)currentUser;
+ (void)setCurrentUser:(User*)currentUser;

+ (void)logout;

@end
