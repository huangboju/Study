//
//  AppDelegate.m
//  SYStickHeaderWaterFall
//
//  Created by Mac on 16/3/4.
//  Copyright © 2016年 suya. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeThreeViewController.h"
#import "SYRootViewController.h"
#import "NetWorkConfig.h"
#import "SYSURLMacro.h"
/// Fix the navigation bar height when hide status bar.
@interface SYExampleNavBar : UINavigationBar
@end

@implementation SYExampleNavBar {
    CGSize _previousSize;
}

- (CGSize)sizeThatFits:(CGSize)size {
    size = [super sizeThatFits:size];
    if ([UIApplication sharedApplication].statusBarHidden) {
        size.height = 64;
    }
    return size;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!CGSizeEqualToSize(self.bounds.size, _previousSize)) {
        _previousSize = self.bounds.size;
        [self.layer removeAllAnimations];
        [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer *layer, NSUInteger idx, BOOL *stop) {
            [layer removeAllAnimations];
        }];
    }
}

@end
@interface SYExampleNavController : UINavigationController
@end

@implementation SYExampleNavController
- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
@interface AppDelegate ()

@end
@implementation AppDelegate

- (void)setupRequestFilters {
    //    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NetWorkConfig *config = [NetWorkConfig shareInstance];
    config.baseUrl = URL_MAIN;
    
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupRequestFilters];
    
    SYRootViewController *root = [SYRootViewController new];
    SYExampleNavController *nav = [[SYExampleNavController alloc] initWithNavigationBarClass:[SYExampleNavBar class] toolbarClass:[UIToolbar class]];
    if ([nav respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        nav.automaticallyAdjustsScrollViewInsets = NO;
    }
    [nav pushViewController:root animated:NO];
    
    self.rootViewController = nav;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.rootViewController;
    self.window.backgroundColor = [UIColor grayColor];
    [self.window makeKeyAndVisible];
    
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
}

@end
