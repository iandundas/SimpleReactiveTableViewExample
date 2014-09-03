//
//  IDAppDelegate.m
//  SimpleReactivePullToRefreshExample
//
//  Created by Ian Dundas on 03/09/2014.
//  Copyright (c) 2014 Ian Dundas. All rights reserved.
//

#import "IDAppDelegate.h"
#import "BBCScheduleTableViewController.h"

@implementation IDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    BBCScheduleTableViewController *viewController= [[BBCScheduleTableViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *navigationController= [[UINavigationController alloc] initWithRootViewController:viewController];
    [self.window setRootViewController:navigationController];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end