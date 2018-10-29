//
//  RequestCustom.h
//  SYStickHeaderWaterFall
//
//  Created by Mac on 16/3/8.
//  Copyright © 2016年 suya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define WARN_NETWORK_FAILE            @"请检查您的网络"
#define WARN_UNKNOW_FAILE               @"未知错误"
#define URL_MAIN                        @"http://test.mokooapp.com/"

#define RESULT_DATAS                    @"data"
typedef void(^requestComplete) (BOOL succed, id obj);
@interface RequestCustom : NSObject

+(void)requestFlowWater:(NSMutableDictionary *)optionalParam pageNUM:(NSString *)page_num pageLINE:(NSString *)page_line complete:(requestComplete)_complete ;
+(void) requestBanner:(NSString *)userID complete:(requestComplete)_complete;
@end
