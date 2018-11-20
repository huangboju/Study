//
//  IMPendulumBehavior.h
//  IMDynamics
//
//  Created by Ivan on 16/9/29.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMPendulumBehavior : UIDynamicBehavior

- (instancetype)initWithWeight:(id<UIDynamicItem>)item suspendedFromPoint:(CGPoint)p;

- (void)beginDraggingWeightAtPoint:(CGPoint)p;
- (void)dragWeightToPoint:(CGPoint)p;
- (void)endDraggingWeightWithVelocity:(CGPoint)v;

@end
