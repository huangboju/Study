//
//  ViewController.m
//  FreeStreamerStudy
//
//  Created by 黄伯驹 on 2017/8/2.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "ViewController.h"
#import "PersistentStreamPlayer.h"
#import "AVPlayerItem+MCCacheSupport.h"
#import <FreeStreamer/FreeStreamer-umbrella.h>

#import <AVFoundation/AVFoundation.h>

@interface ViewController () {
    FSAudioStream *_audioStream;
}

@end

// http://www.111ttt.com/up/

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self initAudioStream];

    //播放网络流媒体音频
//    [_audioStream play];
    
//    [self initStreamPlayer];
    
    [self initPlayerLayer];
}

- (void)initPlayerLayer {
    NSString *urlStr = @"https://raw.githubusercontent.com/huangboju/Moots/master/Voyeur_Sting.wav";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSError *error;
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"OralPracticeAudioData"];
    NSLog(@"%@=====", path);
    AVPlayerItem *item = [AVPlayerItem mc_playerItemWithRemoteURL:url options:nil cacheFilePath:path error:&error];
    AVPlayer *player = [[AVPlayer alloc] initWithPlayerItem:item];

    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    [self.view.layer addSublayer:playerLayer];
    
    [player play];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_audioStream playFromURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"BillieJean" ofType:@"mp3"]]];
}

- (NSString *)localPath {
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"OralPracticeAudioData"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if (!(isDirExist && isDir)) {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if (!bCreateDir) {
            NSLog(@"创建文件夹失败！");
        }
    }
    return path;
}

- (void)initStreamPlayer {
    NSString *urlStr = @"https://raw.githubusercontent.com/huangboju/Moots/master/Voyeur_Sting.wav";
    NSURL *url = [NSURL URLWithString:urlStr];
    PersistentStreamPlayer *remoteAudioPlayer = [[PersistentStreamPlayer alloc] initWithRemoteURL:url
                                                                                         localURL:[NSURL fileURLWithPath:[self localPath]]];
//    remoteAudioPlayer.delegate = self;
    [remoteAudioPlayer play];
}

- (void)initAudioStream {
    NSString *urlStr = @"https://raw.githubusercontent.com/huangboju/Moots/master/Voyeur_Sting.wav";
    NSURL *url = [NSURL URLWithString:urlStr];
    //创建FSAudioStream对象
    FSStreamConfiguration *configuration = [[FSStreamConfiguration alloc] init];
    configuration.cacheDirectory = [self localPath];
    _audioStream = [[FSAudioStream alloc] initWithConfiguration:configuration];
    [_audioStream playFromURL:url];

    //设置播放错误回调Block
    _audioStream.onFailure = ^(FSAudioStreamError error, NSString *description){
        NSLog(@"播放过程中发生错误，错误信息：%@",description);
    };
    //设置播放完成回调Block
    _audioStream.onCompletion = ^(){
        NSLog(@"播放完成!");
    };
    [_audioStream setVolume:0.5];//设置声音大小
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
