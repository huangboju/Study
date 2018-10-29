//
//  YZPBaseRequest.m
//  YZPro
//
//  Created by suya on 16/4/27.
//  Copyright © 2016年 Panda. All rights reserved.
//

#import "YZPBaseRequest.h"

@implementation YZPBaseRequest

- (id)requestArgument {
    NSMutableDictionary *postDict = [NSMutableDictionary dictionary];
    [postDict setObject:@"1" forKey:@"channel"];
    [postDict setObject:@"1.0" forKey:@"version"];
    return [self generateData:postDict];
}

- (id)generateData:(NSDictionary *)dict{
    
    return dict;
}

- (NetWorkRequestMethod)requestMethod {
    return NetWorkRequestMethodPost;
}

@end
