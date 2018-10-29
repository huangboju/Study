//
//  shopModel.m
//  
//
//  Created by sy on 15/6/6.
//  Copyright (c) 2015年 sy. All rights reserved.
//

#import "HomeModel.h"
#import <MJExtension.h>

@implementation HomeModel
+(instancetype)initHomeModelWithDict:(NSDictionary *)dict
{
    HomeModel *model = [[self alloc]init];
    [model mj_setKeyValues:dict];
    return model;
}
@end
