//
//  HomeFooterCollectionReusableView.m
//  SYStickHeaderWaterFall
//
//  Created by 张苏亚 on 16/4/30.
//  Copyright © 2016年 suya. All rights reserved.
//
#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#import "HomeFooterCollectionReusableView.h"

@implementation HomeFooterCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 50)];
        [self addSubview:self.footerView];
    }
    return self;
}
@end
