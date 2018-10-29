//
//  BannerModel.m
//  mokoo
//
//  Created by Mac on 15/9/2.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "BannerModel.h"
#import <MJExtension.h>

@implementation BannerModel
+(instancetype)initBannerWithDict:(NSDictionary *)dict
{
    BannerModel *model = [[self alloc]init];
    [model mj_setKeyValues:dict];
    return model;
}
@end
