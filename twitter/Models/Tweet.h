//
//  Tweet.h
//  twitter
//
//  Created by sbernal0115 on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tweet : NSObject

// MARK: Properties
@property (nonatomic, strong) NSString *idStr; // For favoriting, retweeting & replying
@property (strong, nonatomic) NSString *text; // Text content of tweet
@property (nonatomic) int favoriteCount; // Update favorite count label
@property (nonatomic) BOOL favorited; // Configure favorite button
@property (nonatomic) int retweetCount; // Update favorite count label
@property (nonatomic) BOOL retweeted; // Configure retweet button
@property (strong, nonatomic) User *user; // Contains name, screenname, etc. of tweet author

@property (nonatomic) int reply_count;
@property (strong, nonatomic) NSString *createdAtString; // Display date
@property (strong, nonatomic) NSString *timeAgoString; //Display how long it's been since tweet creation
@property (strong,nonatomic) NSDictionary *tweet;

// For Retweets
@property (strong, nonatomic) User *retweetedByUser;  // user who retweeted if tweet is retweet

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
//had to add this during API for during the API Augmentation

@end

NS_ASSUME_NONNULL_END
