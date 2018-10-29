//
//  YZPBaseRequest.h
//  YZPro
//
//  Created by suya on 16/4/27.
//  Copyright © 2016年 Panda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"
@interface YZPBaseRequest : BaseRequest
- (id)generateData:(NSDictionary *)dict;
@end
