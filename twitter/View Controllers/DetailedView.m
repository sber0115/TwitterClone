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

    NSString *pic = self.tweet.user.profileImageURL;
    
    
    NSURL *userPicNSURL = [NSURL URLWithString:pic];
    
    
    self.userPic.image = nil;
    [self.userPic setImageWithURL:userPicNSURL];
    
    self.tweetContent.text = self.tweet.text;
    
    
    self.userHandle.text = @"@";
    self.userHandle.text = [self.userHandle.text stringByAppendingString:self.tweet.user.screenName];
    
    self.tweetDate.text = self.tweet.timeAgoString;
    self.userName.text = self.tweet.user.name;
    self.numLikes.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.numRetweets.text = [NSString stringWithFormat:@"%d",self.tweet.retweetCount];
    self.numReplies.text = [NSString stringWithFormat:@"%d",self.tweet.reply_count];
    
    
    
    
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
