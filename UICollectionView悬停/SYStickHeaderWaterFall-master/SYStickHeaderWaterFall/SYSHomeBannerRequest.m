//
//  SYSHomeBannerRequest.m
//  SYStickHeaderWaterFall
//
//  Created by suya on 16/4/28.
//  Copyright © 2016年 suya. All rights reserved.
//

#import "SYSHomeBannerRequest.h"
#import "SYSURLMacro.h"
@implementation SYSHomeBannerRequest

-(instancetype)initRequestWithUserId:(NSString *)userId
{
    if (self = [super init]) {
        self.userId = userId;
    }
    return self;
}

- (NSString *)requestUrl {
    return HOME_BANNER_API;
}

@end
