//
//  AppDelegate.m
//  蓝牙_ MultipeerConnectivity
//
//  Created by 徐杰 on 16/2/23.
//  Copyright © 2016年 Cer. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [window setBackgroundColor:[UIColor whiteColor]];
    [self setWindow:window];
    
    RootViewController *root = [[RootViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:root];
    [window setRootViewController:navigation];
    [window makeKeyAndVisible];
    
    return YES;
}

@end
