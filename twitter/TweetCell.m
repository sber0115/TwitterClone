//
//  TweetCell.m
//  twitter
//
//  Created by sbernal0115 on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetCell


- (void) setTweet:(Tweet*)tweet
{
    
    self.tweet = tweet;
    
    NSURL *userPicURL = [NSURL URLWithString:self.tweet.user.profileImageURL];
    
    self.userPic.image = nil;
    
    [self.userPic setImageWithURL:userPicURL];
    
    self.userName.text = self.tweet.user.name;
    self.userHandle.text = self.tweet.user.screenName;
    self.tweetDate.text = self.tweet.createdAtString;
    self.tweetContent.text = self.tweet.text;
    
    

}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
