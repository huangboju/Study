//
//  main.m
//  BlockStudy
//
//  Created by 黄伯驹 on 2018/12/30.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyObject.h"

typedef void (^blk_t)(id);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        blk_t blk;
        {
            id array = [[NSMutableArray alloc] init];
            id __weak array2 = array;
            blk = ^(id obj) {
                [array2 addObject:obj];
                NSLog(@"array coubt = %ld", [array2 count]);
            };
        }
        
        blk([[NSObject alloc] init]);
        blk([[NSObject alloc] init]);
        blk([[NSObject alloc] init]);
        
        id o = [[MyObject alloc] init];
        NSLog(@"%@", o);
    }
    return 0;
}
