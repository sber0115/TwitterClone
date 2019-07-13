//
//  DetailedView.m
//  twitter
//
//  Created by sbernal0115 on 7/5/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "DetailedView.h"
#import "UIImageView+AFNetworking.h"

@interface DetailedView ()

@end

@implementation DetailedView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureDetailedView];
}


- (void)configureDetailedView
{
    
    if (self.tweet.retweeted)
    {
        [self.retweetButton setSelected:YES];
    }
    else
    {
        [self.retweetButton setSelected:NO];
    }
    
    if (self.tweet.favorited)
    {
        [self.likeButton setSelected:YES];
    }
    else
    {
        [self.likeButton setSelected:NO];
    }
    
    NSString *pic = self.tweet.user.profileImageURL;

    NSURL *userPicNSURL = [NSURL URLWithString:pic];
    
    self.userPicImageView.image = nil;
    [self.userPicImageView setImageWithURL:userPicNSURL];
    
    self.tweetContentLabel.text = self.tweet.text;
    
    self.userHandleLabel.text = [NSString stringWithFormat:@"@%@",self.tweet.user.screenName];
    
    self.tweetDateLabel.text = self.tweet.timeAgoString;
    self.userNameLabel.text = self.tweet.user.name;
    self.numLikesLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.numRetweetsLabel.text = [NSString stringWithFormat:@"%d",self.tweet.retweetCount];
    self.numRepliesLabel.text = [NSString stringWithFormat:@"%d",self.tweet.reply_count];
                                
}


@end
