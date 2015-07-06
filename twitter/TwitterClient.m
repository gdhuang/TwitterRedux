//
//  TwitterClient.m
//  twitter
//
//  Created by GD Huang on 6/29/15.
//  Copyright (c) 2015 gdhuang. All rights reserved.
//

#import "TwitterClient.h"

#import "Tweet.h"


NSString * const kTwitterConsumerKey = @"D7xgkc7IWDU7St1AFczSbnXHo";
NSString * const kTwitterConsumerSecret = @"qayCnjhCHQEdwQ0qveTVvs1bLSLTm0w1VnPULc2EdgPfXYBb3J";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@interface TwitterClient()

@property (nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);

@end

@implementation TwitterClient



+ (TwitterClient *)sharedInstance {
    static TwitterClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(instance==nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
        }
    });
    return instance;
}

- (void)loginWithCompletion:(void (^)(User *user, NSError *eror))completion {
    self.loginCompletion = completion;
    
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token"
          method:@"GET"
          callbackURL:[NSURL URLWithString:@"codepath://oauth"]
          scope:nil
          success:^(BDBOAuth1Credential *requestToken) {
              NSLog(@"got request token");
              NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
              [[UIApplication sharedApplication] openURL:authURL];
          } failure:^(NSError *error) {
              // TODO: notify UI
              NSLog(@"failed request token");
              self.loginCompletion(nil, error);
          }];
}



-(void)openURL:(NSURL *)url {
    
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
        NSLog(@"got access token");
        
        [self.requestSerializer saveAccessToken:accessToken];
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            User *user = [[User alloc] initWithDictionary:responseObject];
            [User setCurrentUser:user];
            self.loginCompletion(user, nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"fail to get current user");
            self.loginCompletion(nil, error);
        }];

        
        
    } failure:^(NSError *error) {
        NSLog(@"fail to get access token");
    }];
    
    
}




- (void)homeTimelineWithParms:(NSDictionary*)params completion:(void (^)(NSArray* tweets, NSError* error))completion {

    
    [self GET:@"1.1/statuses/home_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *tweets = [Tweet tweetWithArray:responseObject];
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"fail to get timeline");
        completion(nil, error);
    }];
    
}


- (void)mentionsTimelineWithParms:(NSDictionary*)params completion:(void (^)(NSArray* tweets, NSError* error))completion {
    [self GET:@"1.1/statuses/mentions_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *tweets = [Tweet tweetWithArray:responseObject];
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"fail to get timeline");
        completion(nil, error);
    }];
    
}


- (void)postTweet:(NSString *)tweetText success:(void (^)(Tweet *tweet))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    [self POST:@"1.1/statuses/update.json" parameters:@{@"status": tweetText} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:responseObject];
        success(tweet);
    } failure:failure];
}


- (void)reply:(NSString *)tweetText replyTo:(NSString*)tweetID success:(void (^)(Tweet *tweet))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    [self POST:@"1.1/statuses/update.json" parameters:@{@"status": tweetText, @"in_reply_to_status_id": tweetID} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:responseObject];
        success(tweet);
    } failure:failure];
}

- (void)retweet:(NSString *)tweetID success:(void (^)(Tweet *tweet))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSString *url = [NSString stringWithFormat:@"1.1/statuses/retweet/%@.json", tweetID];
    [self POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:responseObject];
        success(tweet);
    } failure:failure];
}

- (void)favorite:(NSString *)tweetID success:(void (^)(id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    [self POST:@"1.1/favorites/create.json" parameters:@{@"id": tweetID} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:failure];
}


@end
