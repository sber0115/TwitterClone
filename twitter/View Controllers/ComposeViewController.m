//
//  ComposeViewController.m
//  twitter
//
//  Created by sbernal0115 on 7/3/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "TimelineViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)setCloseButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


- (IBAction)didTapPost:(id)sender {
    
    [self composeTweet];
}



- (void)composeTweet
{
    [[APIManager shared]postStatusWithText:self.tweetTextField.text completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"Composed tweet sucessfully!");
        }
    }];
    [self dismissViewControllerAnimated:true completion:nil];
    
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
