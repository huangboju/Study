//
//  SYSHomeRequest.h
//  SYStickHeaderWaterFall
//
//  Created by suya on 16/4/28.
//  Copyright © 2016年 suya. All rights reserved.
//

#import "BaseRequest.h"

@interface SYSHomeRequest : BaseRequest

@property (nonatomic,assign)NSInteger pageLine;
@property (nonatomic,assign)NSInteger pageNum;
-(instancetype)initRequestWithPageLine:(NSInteger )pageLine pageNum:(NSInteger )pageNum;

@end
