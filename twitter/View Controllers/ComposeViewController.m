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
}


- (IBAction)setCloseButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


- (IBAction)didTapPost:(id)sender {
    [self composeTweet];
}


- (void)composeTweet
{
    [[APIManager shared]postStatusWithText:self.tweetTextView.text completion:^(Tweet *tweet, NSError *error) {
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

@end
