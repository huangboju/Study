//
//  NetWorkConfig.m
//  YZPro
//
//  Created by suya on 16/4/26.
//  Copyright © 2016年 Panda. All rights reserved.
//

#import "NetWorkConfig.h"

@implementation NetWorkConfig
{
    NSMutableArray *_urlFilters;
}

+(NetWorkConfig *)shareInstance
{
    static id shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        _securityPolicy = [AFSecurityPolicy defaultPolicy];
        _urlFilters = [NSMutableArray array];
    }
    return self;
}

- (void)addUrlFilter:(id<YTKUrlFilterProtocol>)filter
{
    [_urlFilters addObject:filter];
}

-(NSArray *)urlFilters
{
    return [_urlFilters copy];
}
@end

