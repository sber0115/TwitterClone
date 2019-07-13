//
//  TweetCell.h
//  twitter
//
//  Created by sbernal0115 on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userPicImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userHandleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *tweetContentLabel;
@property (weak, nonatomic) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UILabel *numRepliesLabel;
@property (weak, nonatomic) IBOutlet UILabel *numRetweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLikesLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

- (void) configureTweetCell:(Tweet *)tweet;

@end

NS_ASSUME_NONNULL_END
