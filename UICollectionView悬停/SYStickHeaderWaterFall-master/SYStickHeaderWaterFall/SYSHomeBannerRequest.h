//
//  SYSHomeBannerRequest.h
//  SYStickHeaderWaterFall
//
//  Created by suya on 16/4/28.
//  Copyright © 2016年 suya. All rights reserved.
//

#import "BaseRequest.h"

@interface SYSHomeBannerRequest : BaseRequest
@property (nonatomic,copy)NSString *userId;

-(instancetype)initRequestWithUserId:(NSString *)userId;

@end
