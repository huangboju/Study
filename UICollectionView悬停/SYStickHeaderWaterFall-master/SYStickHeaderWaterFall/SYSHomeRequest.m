//
//  SYSHomeRequest.m
//  SYStickHeaderWaterFall
//
//  Created by suya on 16/4/28.
//  Copyright © 2016年 suya. All rights reserved.
//

#import "SYSHomeRequest.h"
#import "SYSURLMacro.h"

@implementation SYSHomeRequest

-(instancetype)initRequestWithPageLine:(NSInteger)pageLine pageNum:(NSInteger)pageNum
{
    if (self = [super init]) {
        self.pageLine = pageLine;
        self.pageNum = pageNum;
    }
    return self;
}

- (NSString *)requestUrl {
    return HOME_API;
}
- (id)requestArgument {
    return @{
             @"page_num": [NSString stringWithFormat:@"%@",@(_pageNum)],
             @"page_line": [NSString stringWithFormat:@"%@",@(_pageLine)]
             };
}

//- (id)jsonValidator {
//    return @{
//             @"page_num": [NSNumber class],
//             @"page_line": [NSString class],
//             @"level": [NSNumber class]
//             };
//}

@end
