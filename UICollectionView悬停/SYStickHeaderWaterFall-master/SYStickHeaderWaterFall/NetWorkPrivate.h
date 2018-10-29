//
//  NetWorkPrivate.h
//  YZPro
//
//  Created by suya on 16/4/26.
//  Copyright © 2016年 Panda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"

@interface NetWorkPrivate : NSObject
+ (BOOL)checkJson:(id)json withValidator:(id)validatorJson;

+ (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString
                          appendParameters:(NSDictionary *)parameters;

+ (void)addDoNotBackupAttribute:(NSString *)path;

+ (NSString *)md5StringFromString:(NSString *)string;

+ (NSString *)appVersionString;
@end


@interface BaseRequest (RequestAccessory)

- (void)toggleAccessoriesWillStartCallBack;
- (void)toggleAccessoriesWillStopCallBack;
- (void)toggleAccessoriesDidStopCallBack;

@end