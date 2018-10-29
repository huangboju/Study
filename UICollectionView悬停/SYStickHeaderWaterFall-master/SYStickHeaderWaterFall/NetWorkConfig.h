//
//  NetWorkConfig.h
//  YZPro
//
//  Created by suya on 16/4/26.
//  Copyright © 2016年 Panda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "BaseRequest.h"
/**
 *  Url采集器
 */
@protocol YTKUrlFilterProtocol <NSObject>
- (NSString *)filterUrl:(NSString *)originUrl withRequest:(BaseRequest *)request;
@end


@interface NetWorkConfig : NSObject
//单例
+(NetWorkConfig *)shareInstance;

@property (strong, nonatomic) NSString *baseUrl;
//@property (strong, nonatomic) NSString *cdnUrl;
@property (strong, nonatomic, readonly) NSArray *urlFilters;
//@property (strong, nonatomic, readonly) NSArray *cacheDirPathFilters;
@property (strong, nonatomic) AFSecurityPolicy *securityPolicy;

//填充采集器
- (void)addUrlFilter:(id<YTKUrlFilterProtocol>)filter;

@end
