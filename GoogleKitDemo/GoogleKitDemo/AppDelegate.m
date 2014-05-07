//
//  AppDelegate.m
//  GoogleKitDemo
//
//  Created by Max Sokolov on 29/04/14.
//  Copyright (c) 2014 Max Sokolov. All rights reserved.
//

#import "AppDelegate.h"
#import "UIRootViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[UIRootViewController alloc] init]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.rootViewController = navigationController;
    self.window.backgroundColor = [UIColor whiteColor];

    [self.window makeKeyAndVisible];

    return YES;
}

@end