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
@property (strong, nonatomic) UIRefreshControl *refreshControl;



@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    [self fetchTweets];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    
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



- (void) fetchTweets
{
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
    
    
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
    
}






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
    cell.numLikes.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    cell.numRetweets.text = [NSString stringWithFormat:@"%d",tweet.retweetCount];
    cell.numReplies.text = [NSString stringWithFormat:@"%d",tweet.retweetCount];
    
    
    return cell;

    
}




- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetArray.count;
}


@end
