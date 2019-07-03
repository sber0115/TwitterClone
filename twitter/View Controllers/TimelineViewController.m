//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong,nonatomic) NSMutableArray *tweetArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            
            
            self.tweetArray = [[NSMutableArray alloc] initWithArray:tweets];
            [self.tableView reloadData];
            
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    
    Tweet* tweet = self.tweetArray[indexPath.row];
    
    NSString *pic = tweet.user.profileImageURL;
    
    
    NSURL *userPicNSURL = [NSURL URLWithString:pic];
    
    
    cell.userPic.image = nil;
    [cell.userPic setImageWithURL:userPicNSURL];
    
    
    cell.tweetContent.text = tweet.text;
    cell.userHandle.text = tweet.user.screenName;
    cell.tweetDate.text = tweet.createdAtString;
    cell.userName.text = tweet.user.name;
    
    
    return cell;

    
}




- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetArray.count;
}


@end
