//
//  BaseRequest.h
//  YZPro
//
//  Created by suya on 16/4/26.
//  Copyright © 2016年 Panda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef NS_ENUM(NSInteger, NetWorkRequestMethod)
{
    NetWorkRequestMethodGet = 0,
    NetWorkRequestMethodPost,
    NetWorkRequestMethodHead,
    NetWorkRequestMethodPut,
    NetWorkRequestMethodDelete,
    NetWorkRequestMethodPatch
};

typedef NS_ENUM(NSInteger,NetWorkRequestState)
{
    NetWorkRequestStateOn = 0,
    NetWorkRequestStateOff,
    NetWorkRequestStateSucced,
    NetWorkRequestStateError
};

typedef NS_ENUM(NSInteger, NetWorkSerializerType)
{
    NetWorkSerializerTypeHttp = 0,
    NetWorkSerializerTypeJson
};

typedef void (^AFConstructingBlock)(id<AFMultipartFormData> formData);
//typedef void (^AFDownloadProgressBlock)(AFDownloadRequestOperation *operation, NSInteger bytesRead, long long totalBytesRead, long long totalBytesExpected, long long totalBytesReadForFile, long long totalBytesExpectedToReadForFile);

@class BaseRequest;

typedef void(^requestComplete) (BOOL succed, id obj);

typedef void (^RequestCompletionBlock)(__kindof  BaseRequest *request, id obj);

@protocol BaseRequestDelegate <NSObject>

@optional
- (void)requestFinished:(BaseRequest *)request;
- (void)requestFailed:(BaseRequest *)request;
- (void)clearRequest;

@end

@protocol RequestAccescory <NSObject>
@optional
-(void)requestWillStart:(id)request;
-(void)requestWillStop:(id)request;
-(void)requestDidStop:(id)request;

@end

//#define WARN_NETWORK_FAILE            @"请检查您的网络"
//#define WARN_UNKNOW_FAILE               @"未知错误"
//#define URL_MAIN                        @"http://121.40.147.31/xgou/"
//#define RESULT_DATAS                    @"data"
@interface BaseRequest : NSObject

/// Tag
@property (nonatomic) NSInteger tag;

/// User info
@property (nonatomic, strong) NSDictionary *userInfo;

@property (nonatomic, strong) NSURLSessionDataTask *requestDataTask;

/// request delegate object
@property (nonatomic, weak) id<BaseRequestDelegate> delegate;

@property (nonatomic, strong, readonly) NSDictionary *responseHeaders;

@property (nonatomic, strong, readonly) NSData *responseData;

@property (nonatomic, strong, readonly) NSString *responseString;

@property (nonatomic, strong, readonly) id responseJSONObject;

@property (nonatomic, readonly) NSInteger responseStatusCode;

@property (nonatomic, strong, readonly) NSError *requestOperationError;

@property (nonatomic, copy) RequestCompletionBlock successCompletionBlock;

@property (nonatomic, copy) RequestCompletionBlock failureCompletionBlock;

@property (nonatomic, strong) NSMutableArray *requestAccessories;

/// 请求的优先级, 优先级高的请求会从请求队列中优先出列
//@property (nonatomic) YTKRequestPriority requestPriority;

/// append self to request queue
- (void)start;

/// remove self from request queue
- (void)stop;

//- (BOOL)isExecuting;

/// block回调
- (void)startWithCompletionBlockWithSuccess:(RequestCompletionBlock)success
                                    failure:(RequestCompletionBlock)failure;

- (void)setCompletionBlockWithSuccess:(RequestCompletionBlock)success
                              failure:(RequestCompletionBlock)failure;

/// 把block置nil来打破循环引用
- (void)clearCompletionBlock;

/// Request Accessory，可以hook Request的start和stop
- (void)addAccessory:(id<RequestAccescory>)accessory;

/// 以下方法由子类继承来覆盖默认值

/// 请求成功的回调
- (void)requestCompleteFilter;

/// 请求失败的回调
- (void)requestFailedFilter;

/// 请求的URL
- (NSString *)requestUrl;

/// 请求的CdnURL
- (NSString *)cdnUrl;

/// 请求的BaseURL
- (NSString *)baseUrl;

/// 请求的连接超时时间，默认为60秒
- (NSTimeInterval)requestTimeoutInterval;

/// 请求的参数列表
- (id)requestArgument;

/// 用于在cache结果，计算cache文件名时，忽略掉一些指定的参数
- (id)cacheFileNameFilterForRequestArgument:(id)argument;

/// Http请求的方法
- (NetWorkRequestMethod)requestMethod;

/// 请求的SerializerType
- (NetWorkSerializerType)requestSerializerType;

/// 请求的Server用户名和密码
- (NSArray *)requestAuthorizationHeaderFieldArray;

/// 在HTTP报头添加的自定义参数
- (NSDictionary *)requestHeaderFieldValueDictionary;

/// 构建自定义的UrlRequest，
/// 若这个方法返回非nil对象，会忽略requestUrl, requestArgument, requestMethod, requestSerializerType
- (NSURLRequest *)buildCustomUrlRequest;

/// 是否使用CDN的host地址
- (BOOL)useCDN;

/// 用于检查JSON是否合法的对象
- (id)jsonValidator;

/// 用于检查Status Code是否正常的方法
- (BOOL)statusCodeValidator;

/// 当POST的内容带有文件等富文本时使用
- (AFConstructingBlock)constructingBodyBlock;
@end
