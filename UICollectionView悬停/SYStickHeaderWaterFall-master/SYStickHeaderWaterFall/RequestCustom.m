//
//  RequestCustom.m
//  SYStickHeaderWaterFall
//
//  Created by Mac on 16/3/8.
//  Copyright © 2016年 suya. All rights reserved.
//

#import "RequestCustom.h"
#import "AFNetworking.h"
#import <CommonCrypto/CommonDigest.h>
@implementation RequestCustom
#pragma mark - 首页

//FlowWater
+(void)requestFlowWater:(NSMutableDictionary *)optionalParam pageNUM:(NSString *)page_num pageLINE:(NSString *)page_line complete:(requestComplete)_complete {
    
    
    if (page_num == nil) {
    } else {
        [optionalParam setObject:page_num forKey:@"page_num"];
    }
    if (page_line == nil) {
    } else {
        [optionalParam setObject:page_line forKey:@"page_line"];
    }
    
    [RequestCustom postRequestParameters:optionalParam api:@"HomeApi" andlastInterFace:@"modellist" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
        
        NSLog(@"FlowWater>>>>>>%@",obj);
    }];
}
#pragma mark - banner图片
+(void) requestBanner:(NSString *)userID complete:(requestComplete)_complete
{
    NSMutableDictionary *dicParaments   = [RequestCustom baseOption];
    if (userID ==nil) {
        
    }else
    {
        //        [dicParaments setObject:userID forKey:@"user_id"];
    }
    
    [RequestCustom postRequestParameters:dicParaments api:@"HomeApi" andlastInterFace:@"banner" analysisDataComplete:^(BOOL succed, id obj) {
        _complete(succed,obj);
        NSLog(@"晒扒——晒友圈>>>>>>%@",obj);
    }];
    
}
+(void)postRequestParameters:(NSDictionary *)dicParameters api:(NSString *)_typeApi andlastInterFace:(NSString *)_interface analysisDataComplete:(requestComplete)complete {
    AFHTTPSessionManager   *manager    = [RequestCustom managerCustom];
    NSMutableString *strURl = [[NSMutableString alloc] initWithString:URL_MAIN];
    if ([_typeApi isEqualToString:@"Api"]) {
        [strURl appendString:@"Api/"];
    }else if ([_typeApi isEqualToString:@"HomeApi"])
    {
        [strURl appendString:@"HomeApi/"];
    }
    [strURl appendString:[NSString stringWithFormat:@"%@/",_interface]];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [manager POST:strURl parameters:dicParameters progress:^(NSProgress *uploadProgress)
     {
         
     }
          success:^(NSURLSessionDataTask *task, id responseObject) {
              BOOL succed = [RequestCustom errorSolution:responseObject];
              //        SLog(@"关于succed>>>>>>>%@",@(succed));
              complete(succed,responseObject);
              
          } failure:^(NSURLSessionDataTask *task, NSError *error) {
              
              complete(NO,WARN_NETWORK_FAILE);
          }];
    
    
}
+(BOOL)errorSolution:(id)responseObject {
    //数据data中没有 error 参数
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    BOOL succed = YES;
    //    if ([dicdatas isKindOfClass:[NSDictionary class]]) {
    //        NSString    *strError   = [dicdatas drObjectForKey:@"error"];
    //        if (![NSString isEmptyString:strError]) {
    //            succed = NO;
    //        }
    //    }
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
        //                NSInteger status = [[responseObject objectForKey:@"status"] integerValue];
        //                NSString    *status = [responseObject objectForKey:@"status"];
        //                if (![status isEqualToString:@"1"]) {
        //                    succed = NO;
        //                }
    }
    
    return succed;
}
+(AFHTTPSessionManager *)managerCustom {
    
    AFHTTPSessionManager   *manager    = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval   = 6;
    
    return manager;
}

+(NSMutableDictionary *)baseOption {
    
    NSMutableDictionary *dicbase    = [[NSMutableDictionary alloc] init];
    
    return dicbase;
}

+(NSMutableDictionary *)userIdOption {
    
    NSMutableDictionary *dicbase    = [[NSMutableDictionary alloc] init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [dicbase setObject:[userDefaults objectForKey:@"user_id"] forKey:@"user_id"];
    //    if (![NSString isEmptyString:[UserInfo shareUserInfo].strToken]) {
    //        [dicbase setObject:[UserInfo shareUserInfo].strToken forKey:@"key"];
    //    }
    
    return dicbase;
}

+ (NSString *)md5HexDigest:(NSString *)str
{
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
    
}

@end
