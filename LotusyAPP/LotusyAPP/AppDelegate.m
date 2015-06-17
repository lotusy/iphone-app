//
//  AppDelegate.m
//  LotusyAPP
//
//  Created by Peng Shen on 2015-03-16.
//  Copyright (c) 2015 Foodster Club Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "DataManager.h"

#define NAVIGATIONBAR_BACKGROUND_IMAGE [UIImage imageNamed:@"nav_background"]
#define NAVIGATIONBAR_SHADOW_IMAGE [UIImage imageNamed:@"nav_shadow"]
#define NAVIGATIONBAR_TITLE_COLOR [UIColor colorWithRed:0.541 green:0.357 blue:0.122 alpha:1.000]
#define NAVIGATIONBAR_TITLE_FONT [UIFont fontWithName:@"AmaticSC-Regular" size:26]
#define BARBUTTONITEM_TITLE_COLOR [UIColor colorWithRed:0.945 green:0.631 blue:0.255 alpha:1.000]
#define BARBUTTONITEM_TITLE_FONT [UIFont fontWithName:@"Aleo-Regular" size:16]
#define BUTTON_TINT_COLOR [UIColor colorWithRed:0.541 green:0.357 blue:0.122 alpha:1.000]

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /* UINavigationBar */
    [[UINavigationBar appearance] setBackgroundImage:NAVIGATIONBAR_BACKGROUND_IMAGE
                                       forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:NAVIGATIONBAR_SHADOW_IMAGE];
    [[UINavigationBar appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : NAVIGATIONBAR_TITLE_COLOR,
                                                            NSFontAttributeName : NAVIGATIONBAR_TITLE_FONT }];
    
    /* UIBarButtonItem */
    [[UIBarButtonItem appearance] setTintColor:BARBUTTONITEM_TITLE_COLOR];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : BARBUTTONITEM_TITLE_COLOR,
                                                            NSFontAttributeName : BARBUTTONITEM_TITLE_FONT }
                                                forState:UIControlStateNormal];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [DataManager saveContextCompletionHandler:^{}];
}

@end
