//
//  MyObject.m
//  BlockStudy
//
//  Created by 黄伯驹 on 2018/12/30.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "MyObject.h"

@implementation MyObject

- (void)dealloc {
    NSLog(@"aaaaaaa");
}

- (instancetype)init {
    if (self = [super init]) {
        _blk = ^{ NSLog(@"%@", self); };
    }
    return self;
}

@end
