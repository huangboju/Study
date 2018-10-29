//
//  BaseRequest.m
//  YZPro
//
//  Created by suya on 16/4/26.
//  Copyright © 2016年 Panda. All rights reserved.
//

#import "BaseRequest.h"
#import "AFNetworking.h"
#import "NetWorkPrivate.h"
#import "NetWorkAgent.h"
#import <CommonCrypto/CommonDigest.h>
@implementation BaseRequest

/// for subclasses to overwrite
- (void)requestCompleteFilter {
}

- (void)requestFailedFilter {
}

- (NSString *)requestUrl {
    return @"";
}

- (NSString *)cdnUrl {
    return @"";
}

- (NSString *)baseUrl {
    return @"";
}

- (NSTimeInterval)requestTimeoutInterval {
    return 15;
}

- (id)requestArgument {
    return nil;
}

- (id)cacheFileNameFilterForRequestArgument:(id)argument {
    return argument;
}

- (NetWorkRequestMethod)requestMethod {
    return NetWorkRequestMethodPost;
}

- (NetWorkSerializerType)requestSerializerType {
    return NetWorkSerializerTypeHttp;
}

- (NSArray *)requestAuthorizationHeaderFieldArray {
    return nil;
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    return nil;
}

- (NSURLRequest *)buildCustomUrlRequest {
    return nil;
}

- (BOOL)useCDN {
    return NO;
}

- (id)jsonValidator {
    return nil;
}

- (BOOL)statusCodeValidator {
//    NSInteger statusCode = [self responseStatusCode];
    return YES;
//    if (statusCode >= 200 && statusCode <=299) {
//        return YES;
//    } else {
//        return NO;
//    }
}

- (AFConstructingBlock)constructingBodyBlock {
    return nil;
}

- (NSString *)resumableDownloadPath {
    return nil;
}

//- (AFDownloadProgressBlock)resumableDownloadProgressBlock {
//    return nil;
//}

/// append self to request queue
- (void)start {
    [self toggleAccessoriesWillStartCallBack];
    [[NetWorkAgent sharedInstance] addRequest:self];
}

/// remove self from request queue
- (void)stop {
    [self toggleAccessoriesWillStopCallBack];
    self.delegate = nil;
    [[NetWorkAgent sharedInstance] cancelRequest:self];
    [self toggleAccessoriesDidStopCallBack];
}

//- (BOOL)isExecuting {
//    return self.requestDataTask.isExecuting;
//}

- (void)clearCompletionBlock {
    // nil out to break the retain cycle.
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}

- (void)startWithCompletionBlockWithSuccess:(RequestCompletionBlock)success
                                    failure:(RequestCompletionBlock)failure {
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

- (void)setCompletionBlockWithSuccess:(RequestCompletionBlock)success
                              failure:(RequestCompletionBlock)failure {
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

- (id)responseJSONObject {
    return self.requestDataTask.response;
}


//- (NSData *)responseData {
//    return self.requestOperation.responseData;
//}
//
//- (NSString *)responseString {
//    return self.requestDataTask.response.responseString;
//}
//
//- (NSInteger)responseStatusCode {
//    return self.requestDataTask.response.;
//}
//
//- (NSDictionary *)responseHeaders {
//    return self.requestOperation.response.allHeaderFields;
//}
//
//- (NSError *)requestOperationError {
//    return self.requestOperation.error;
//}


#pragma mark - Request Accessoies

- (void)addAccessory:(id<RequestAccescory>)accessory {
    if (!self.requestAccessories) {
        self.requestAccessories = [NSMutableArray array];
    }
    [self.requestAccessories addObject:accessory];
}

//+(void)postRequestParameters:(NSDictionary *)dicParameters api:(NSString *)_typeApi andlastInterFace:(NSString *)_interface analysisDataComplete:(requestComplete)complete {
//    AFHTTPSessionManager   *manager    = [BaseRequest managerCustom];
//    
//    NSMutableString *strURl = [[NSMutableString alloc] initWithString:URL_MAIN];
//    if ([_typeApi isEqualToString:@"Api"]) {
//        [strURl appendString:@"Api/"];
//    } else if([_typeApi isEqualToString:@"UserApi"]){
//        [strURl appendString:@"UserApi/"];
//    }else if ([_typeApi isEqualToString:@"FilmApi"])
//    {
//        [strURl appendString:@"FilmApi/"];
//    }else if ([_typeApi isEqualToString:@"GoodsApi"])
//    {
//        [strURl appendString:@"GoodsApi/"];
//        
//    }else if ([_typeApi isEqualToString:@"OrderApi"])
//    {
//        [strURl appendString:@"OrderApi/"];
//        
//    }else if ([_typeApi isEqualToString:@"CartApi"])
//    {
//        [strURl appendString:@"CartApi/"];
//    }else if ([_typeApi isEqualToString:@"AddressApi"])
//    {
//        [strURl appendString:@"AddressApi/"];
//    }else if ([_typeApi isEqualToString:@"SetApi"])
//    {
//        [strURl appendString:@"SetApi/"];
//    }
//    [strURl appendString:[NSString stringWithFormat:@"%@/",_interface]];
//    
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    
//    //        NSLog(@"requstURLandDic%@::%@\n>>>>>>>>",strURl,dicParameters);
//    [manager POST:strURl parameters:dicParameters progress:^(NSProgress *uploadProgress)
//     {
//         
//     }
//          success:^(NSURLSessionDataTask *task, id responseObject) {
//              BOOL succed = [BaseRequest errorSolution:responseObject];
//              //        SLog(@"关于succed>>>>>>>%@",@(succed));
//              complete(succed,responseObject);
//              
//          } failure:^(NSURLSessionDataTask *task, NSError *error) {
//              
//              complete(NO,WARN_NETWORK_FAILE);
//          }];
//    
//    
//}
//
//+(BOOL)errorSolution:(id)responseObject {
//    //数据data中没有 error 参数
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//    BOOL succed = YES;
//    //    if ([dicdatas isKindOfClass:[NSDictionary class]]) {
//    //        NSString    *strError   = [dicdatas drObjectForKey:@"error"];
//    //        if (![NSString isEmptyString:strError]) {
//    //            succed = NO;
//    //        }
//    //    }
//    if ([responseObject isKindOfClass:[NSDictionary class]]) {
//        
//        //                NSInteger status = [[responseObject objectForKey:@"status"] integerValue];
//        //                NSString    *status = [responseObject objectForKey:@"status"];
//        //                if (![status isEqualToString:@"1"]) {
//        //                    succed = NO;
//        //                }
//    }
//    
//    return succed;
//}
//
//+(AFHTTPSessionManager *)managerCustom {
//    
//    AFHTTPSessionManager   *manager    = [AFHTTPSessionManager manager];
//    manager.requestSerializer.timeoutInterval   = 6;
//    
//    return manager;
//}
//
//+(NSMutableDictionary *)baseOption {
//    
//    NSMutableDictionary *dicbase    = [[NSMutableDictionary alloc] init];
//    
//    return dicbase;
//}
//
//+(NSMutableDictionary *)userIdOption {
//    
//    NSMutableDictionary *dicbase    = [[NSMutableDictionary alloc] init];
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [dicbase setObject:[userDefaults objectForKey:@"user_id"] forKey:@"user_id"];
//    //    if (![NSString isEmptyString:[UserInfo shareUserInfo].strToken]) {
//    //        [dicbase setObject:[UserInfo shareUserInfo].strToken forKey:@"key"];
//    //    }
//    
//    return dicbase;
//}
//
//+ (NSString *)md5HexDigest:(NSString *)str
//{
//    const char *original_str = [str UTF8String];
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
//    NSMutableString *hash = [NSMutableString string];
//    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
//        [hash appendFormat:@"%02X", result[i]];
//    return [hash lowercaseString];
//    
//}
@end
