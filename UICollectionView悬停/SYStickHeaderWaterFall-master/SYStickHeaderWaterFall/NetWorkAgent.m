//
//  NetWorkAgent.m
//  YZPro
//
//  Created by suya on 16/4/26.
//  Copyright © 2016年 Panda. All rights reserved.
//

#import "NetWorkAgent.h"
#import "AFNetworking.h"
#import "BaseRequest.h"
#import "NetWorkConfig.h"
#import "NetWorkPrivate.h"
@implementation NetWorkAgent
{
    AFHTTPSessionManager *_manager;
    NetWorkConfig *_config;
    NSMutableDictionary *_requestsRecord;
}
+(NetWorkAgent *)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
-(instancetype )init
{
    self = [super init];
    if (self) {
        _config = [NetWorkConfig shareInstance];
        _requestsRecord = [NSMutableDictionary dictionary];
        _manager = [AFHTTPSessionManager manager];
        _manager.operationQueue.maxConcurrentOperationCount = 4;
//        _manager.requestSerializer.timeoutInterval = 15;
        _manager.securityPolicy = _config.securityPolicy;
    }
    return self;
}
-(void)addRequest:(BaseRequest *)request
{
    NetWorkRequestMethod method = [request requestMethod];
    NSString *url = [self buildRequestUrl:request];
    id param = request.requestArgument;
    AFConstructingBlock constructingBlock = [request constructingBodyBlock];
    
    if (request.requestSerializerType == NetWorkSerializerTypeHttp) {
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    } else if (request.requestSerializerType == NetWorkSerializerTypeJson) {
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    _manager.requestSerializer.timeoutInterval = [request requestTimeoutInterval];
    
    // if api need server username and password
    NSArray *authorizationHeaderFieldArray = [request requestAuthorizationHeaderFieldArray];
    if (authorizationHeaderFieldArray != nil) {
        [_manager.requestSerializer setAuthorizationHeaderFieldWithUsername:(NSString *)authorizationHeaderFieldArray.firstObject
                                                                   password:(NSString *)authorizationHeaderFieldArray.lastObject];
    }
    
    // if api need add custom value to HTTPHeaderField
    NSDictionary *headerFieldValueDictionary = [request requestHeaderFieldValueDictionary];
    if (headerFieldValueDictionary != nil) {
        for (id httpHeaderField in headerFieldValueDictionary.allKeys) {
            id value = headerFieldValueDictionary[httpHeaderField];
            if ([httpHeaderField isKindOfClass:[NSString class]] && [value isKindOfClass:[NSString class]]) {
                [_manager.requestSerializer setValue:(NSString *)value forHTTPHeaderField:(NSString *)httpHeaderField];
            } else {
//                YTKLog(@"Error, class of key/value in headerFieldValueDictionary should be NSString.");
            }
        }
    }
    
    // if api build custom url request
    NSURLRequest *customUrlRequest= [request buildCustomUrlRequest];
    if (customUrlRequest) {
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:customUrlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            [self handleRequestResult:task responseObject:response];
        }];
        request.requestDataTask = task;
//        [_manager.tasks ]
//        [task ]
//        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:customUrlRequest];
//        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//            [self handleRequestResult:operation];
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            [self handleRequestResult:operation];
//        }];
//        request.requestOperation = operation;
//        operation.responseSerializer = _manager.responseSerializer;
//        [_manager.operationQueue addOperation:operation];
    } else {
        if (method == NetWorkRequestMethodGet) {
//            if (request.resumableDownloadPath) {
//                // add parameters to URL;
//                NSString *filteredUrl = [YTKNetworkPrivate urlStringWithOriginUrlString:url appendParameters:param];
//                
//                NSURLRequest *requestUrl = [NSURLRequest requestWithURL:[NSURL URLWithString:filteredUrl]];
//                AFDownloadRequestOperation *operation = [[AFDownloadRequestOperation alloc] initWithRequest:requestUrl
//                                                                                                 targetPath:request.resumableDownloadPath shouldResume:YES];
//                [operation setProgressiveDownloadProgressBlock:request.resumableDownloadProgressBlock];
//                [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//                    [self handleRequestResult:operation];
//                }                                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                    [self handleRequestResult:operation];
//                }];
//                request.requestOperation = operation;
//                [_manager.operationQueue addOperation:operation];
//            } else {
            request.requestDataTask = [_manager GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleRequestResult:task responseObject:responseObject];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestResult:task responseObject:error];
            }];

//            }
        } else if (method == NetWorkRequestMethodPost) {
            if (constructingBlock != nil) {
                request.requestDataTask =[_manager POST:url parameters:param constructingBodyWithBlock:constructingBlock progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [self handleRequestResult:task responseObject:responseObject];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [self handleRequestResult:task responseObject:error];
                }];
                
            } else {
                request.requestDataTask =[_manager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [self handleRequestResult:task responseObject:responseObject];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [self handleRequestResult:task responseObject:error];
                }];
            }
            
        } else if (method == NetWorkRequestMethodHead) {
            request.requestDataTask = [_manager HEAD:url parameters:param success:^(NSURLSessionDataTask * _Nonnull task) {
                [self handleRequestResult:task responseObject:nil];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestResult:task responseObject:error];
            }];
            
        } else if (method == NetWorkRequestMethodPut) {
            request.requestDataTask = [_manager PUT:url parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleRequestResult:task responseObject:responseObject];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestResult:task responseObject:error];
            }];
            
        } else if (method == NetWorkRequestMethodDelete) {
            request.requestDataTask = [_manager DELETE:url parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleRequestResult:task responseObject:responseObject];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestResult:task responseObject:error];
            }];
            
        } else if (method == NetWorkRequestMethodPatch) {
            request.requestDataTask = [_manager PATCH:url parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleRequestResult:task responseObject:responseObject];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestResult:task responseObject:error];
            }];
            
        } else {
//            YTKLog(@"Error, unsupport method type");
            return;
        }
    }
    [self addOperation:request];
}


-(NSString *)buildRequestUrl:(BaseRequest *)request
{
    NSString *detailUrl = [request requestUrl];
    if ([detailUrl hasPrefix:@"http"]) {
        return detailUrl;
    }
    // filter url
    NSArray *filters = [_config urlFilters];
    for (id<YTKUrlFilterProtocol> f in filters) {
        detailUrl = [f filterUrl:detailUrl withRequest:request];
    }
    
    NSString *baseUrl;
    if ([request baseUrl].length > 0) {
        baseUrl = [request baseUrl];
    } else {
        baseUrl = [_config baseUrl];
    }
    
    
    return [NSString stringWithFormat:@"%@%@", baseUrl, detailUrl];

}
- (void)cancelRequest:(BaseRequest *)request {
    [request.requestDataTask cancel];
    [self removeOperation:request.requestDataTask];
    [request clearCompletionBlock];
}

- (void)cancelAllRequests {
    NSDictionary *copyRecord = [_requestsRecord copy];
    for (NSString *key in copyRecord) {
        BaseRequest *request = copyRecord[key];
        [request stop];
    }
}

- (BOOL)checkResult:(BaseRequest *)request {
    BOOL result = [request statusCodeValidator];
    if (!result) {
        return result;
    }
    id validator = [request jsonValidator];
    if (validator != nil) {
        id json = [request responseJSONObject];
        result = [NetWorkPrivate checkJson:json withValidator:validator];
    }
    return result;
}

- (void)handleRequestResult:(NSURLSessionDataTask *)task responseObject:(id  _Nullable )responseObject {
    NSString *key = [self requestHashKey:task];
    BaseRequest *request = _requestsRecord[key];
//    YTKLog(@"Finished Request: %@", NSStringFromClass([request class]));
    if (request) {
        BOOL succeed = [self checkResult:request];
        if (succeed &&![responseObject isKindOfClass:[NSError class]]) {
            [request toggleAccessoriesWillStopCallBack];
            [request requestCompleteFilter];
            if (request.delegate != nil) {
                [request.delegate requestFinished:request];
            }
            if (request.successCompletionBlock) {
                request.successCompletionBlock(request,responseObject);
            }
            [request toggleAccessoriesDidStopCallBack];
        } else {
//            YTKLog(@"Request %@ failed, status code = %ld",
//                   NSStringFromClass([request class]), (long)request.responseStatusCode);
            [request toggleAccessoriesWillStopCallBack];
            [request requestFailedFilter];
            if (request.delegate != nil) {
                [request.delegate requestFailed:request];
            }
            if (request.failureCompletionBlock) {
                request.failureCompletionBlock(request,responseObject);
            }
            [request toggleAccessoriesDidStopCallBack];
        }
    }
    [self removeOperation:task];
    [request clearCompletionBlock];
}

- (NSString *)requestHashKey:(NSURLSessionTask *)task {
    NSString *key = [NSString stringWithFormat:@"%lu", (unsigned long)[task taskIdentifier]];
    return key;
}

- (void)addOperation:(BaseRequest *)request {
    if (request.requestDataTask != nil) {
        NSString *key = [self requestHashKey:request.requestDataTask];
        @synchronized(self) {
            _requestsRecord[key] = request;
        }
    }
}

- (void)removeOperation:(NSURLSessionTask *)task {
    NSString *key = [self requestHashKey:task];
    @synchronized(self) {
        [_requestsRecord removeObjectForKey:key];
    }
//    YTKLog(@"Request queue size = %lu", (unsigned long)[_requestsRecord count]);
}
@end
