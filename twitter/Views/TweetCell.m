//
//  TweetCell.m
//  twitter
//
//  Created by sbernal0115 on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"



//Step 2: Defining a custom table view cell and setting a reuse identifier

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void) refreshData
{
    self.numLikesLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.numRetweetsLabel.text = [NSString stringWithFormat:@"%d",self.tweet.retweetCount];
}


- (IBAction)didTapRetweet:(id)sender {
    
    if (self.tweet.retweeted)
        
    {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        [self.retweetButton setSelected:NO];
        
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
    
    }
    
    else
    {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        [self.retweetButton setSelected:YES];
        
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
        
    }
    
    [self refreshData];
        
}


- (IBAction)didTapLike:(id)sender {
    NSLog(@"Like button was clicked");

    if (self.tweet.favorited)
        
    {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        
        NSLog(@"Printing number of likes: %d", self.tweet.favoriteCount);
        
        [self.likeButton setSelected:NO];
        
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    
    else
    {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
         NSLog(@"Printing number of likes: %d", self.tweet.favoriteCount);
        [self.likeButton setSelected:YES];
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
        
    }
    [self refreshData];

}



- (void) configureTweetCell:(Tweet *)tweet
{
    NSString *pic = tweet.user.profileImageURL;
    NSURL *userPicNSURL = [NSURL URLWithString:pic];
    
    self.userPicImageView.image = nil;
    [self.userPicImageView setImageWithURL:userPicNSURL];
    
    self.tweet = tweet;
    self.tweetContentLabel.text = tweet.text;

    self.userHandleLabel.text = [NSString stringWithFormat:@"@%@",tweet.user.screenName];
    
    self.tweetDateLabel.text = tweet.timeAgoString;
    self.usernameLabel.text = tweet.user.name;
    self.numLikesLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    self.numRetweetsLabel.text = [NSString stringWithFormat:@"%d",tweet.retweetCount];
    self.numRepliesLabel.text = [NSString stringWithFormat:@"%d",tweet.reply_count];
    
}


@end
