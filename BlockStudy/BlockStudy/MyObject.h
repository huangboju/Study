//
//  MyObject.h
//  BlockStudy
//
//  Created by 黄伯驹 on 2018/12/30.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyObject : NSObject {
    int val0;
    int val1;
}

@property (nonatomic, copy) dispatch_block_t blk;

@end

NS_ASSUME_NONNULL_END
