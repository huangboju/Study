//
//  ViewController.m
//  AVPlayerCacheSupportStudy
//
//  Created by 黄伯驹 on 2017/8/2.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "ViewController.h"
#import "AVPlayerItem+MCCacheSupport.h"

#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *urlStr = @"http://sc1.111ttt.com/2017/1/05/10/298101048365.mp3";
    NSURL *url = [NSURL URLWithString:urlStr];
    AVPlayerItem *item = [AVPlayerItem mc_playerItemWithRemoteURL:url];
//    self.player = [[AVPlayer alloc] initWithPlayerItem:playerItem];

}

@end
