//
//  AppDelegate.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "AppDelegate.h"
#import "APIManager.h"

static NSString * const NAVIGATION_CONTROLLER_ID = @"LoggedInNavigationController";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if ([[APIManager shared] isAuthorized]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:NAVIGATION_CONTROLLER_ID];
        self.window.rootViewController = navigationController;
    }
    
    return YES;
}


@end
