//
//  NetWorkAgent.h
//  YZPro
//
//  Created by suya on 16/4/26.
//  Copyright © 2016年 Panda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"
@interface NetWorkAgent : NSObject
+(NetWorkAgent *)sharedInstance;

- (void)addRequest:(BaseRequest *)request;

- (void)cancelRequest:(BaseRequest *)request;

- (void)cancelAllRequests;

/// 根据request和networkConfig构建url
- (NSString *)buildRequestUrl:(BaseRequest *)request;
@end
