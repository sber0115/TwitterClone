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
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "DetailedView.h"


static NSString * const TWEET_CELL_ID = @"TweetCell";
static NSString * const DETAILED_VIEW_SEGUE = @"Details";
static NSString * const COMPOSE_VIEW_SEGUE = @"MakeTweet";
static NSString * const LOGIN_VIEW_ID = @"LoginViewController";



@interface TimelineViewController () <ComposeViewControllerDelegate,UITableViewDataSource, UITableViewDelegate>

@property (strong,nonatomic) NSMutableArray <Tweet *> *tweetArray;



//Step 1: View controller has a tableView as a subview
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end



@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //Step 3: Here we are making the view controller the datasource and delegate
    //for the table view
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    [self fetchTweets];
    
    self.refreshControl = [[UIRefreshControl alloc] init];

    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    
}


- (IBAction)logoutClick:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:LOGIN_VIEW_ID];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:DETAILED_VIEW_SEGUE]) {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Tweet *tweet = self.tweetArray[indexPath.row];
        DetailedView *detailedView = [segue destinationViewController];
        detailedView.tweet = tweet;
    }
    else if ([segue.identifier isEqualToString:COMPOSE_VIEW_SEGUE]) {
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    }
}



- (void) fetchTweets
{
    // Get timeline
    //Step 5: Here the API manager is using a completion handler to hand back data
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            
            //Step 6: Here the view controller is storing the data passed
            //into the completion handler
            self.tweetArray = [[NSMutableArray alloc] initWithArray:tweets];
            [self.tableView reloadData];
            //Step 7: here after successfully retrieving the data we are
            //refreshing the tableview
            ///Step 8: this method also invokes numberOfRows and cellForRowAt
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
    
    [self.refreshControl endRefreshing];
    
}



- (void)didTweet:(Tweet *)tweet
{
    [self.tweetArray insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}


//Step 10: here we are returning a cell with the properties we modified according
//to stored data
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:TWEET_CELL_ID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Tweet* tweet = self.tweetArray[indexPath.row];
    
    [cell configureTweetCell:tweet];
    
    return cell;

}

//Step 8: returning the number of rows we need
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetArray.count;
}


@end
