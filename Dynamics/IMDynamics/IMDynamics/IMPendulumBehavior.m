//
//  IMPendulumBehavior.m
//  IMDynamics
//
//  Created by Ivan on 16/9/29.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import "IMPendulumBehavior.h"

@interface IMPendulumBehavior()

@property (nonatomic, strong) UIAttachmentBehavior *draggingBehavior;
@property (nonatomic, strong) UIPushBehavior *pushBehavior;

@end

@implementation IMPendulumBehavior

//| ----------------------------------------------------------------------------
//! Initializes and returns a newly allocated APLPendulumBehavior which suspends
//! @a item hanging from @a p at a fixed distance (derived from the current
//! distance from @a item to @a p.).
//
- (instancetype)initWithWeight:(id<UIDynamicItem>)item suspendedFromPoint:(CGPoint)p
{
    self = [super init];
    if (self)
    {
        // The high-level pendulum behavior is built from 2 primitive behaviors.
        UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[item]];
        UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:p];
        attachmentBehavior.damping = 1;
        attachmentBehavior.frequency = 0;
        
        // These primative behaviors allow the user to drag the pendulum weight.
        UIAttachmentBehavior *draggingBehavior = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:CGPointZero];
        UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[item] mode:UIPushBehaviorModeInstantaneous];
        
        pushBehavior.active = NO;
        
        [self addChildBehavior:gravityBehavior];
        [self addChildBehavior:attachmentBehavior];
        
        [self addChildBehavior:pushBehavior];
        // The draggingBehavior is added as needed, when the user begins dragging
        // the weight.
        
        self.draggingBehavior = draggingBehavior;
        self.pushBehavior = pushBehavior;
    }
    return self;
}


//| ----------------------------------------------------------------------------
- (void)beginDraggingWeightAtPoint:(CGPoint)p
{
    self.draggingBehavior.anchorPoint = p;
    [self addChildBehavior:self.draggingBehavior];
}


//| ----------------------------------------------------------------------------
- (void)dragWeightToPoint:(CGPoint)p
{
    self.draggingBehavior.anchorPoint = p;
}


//| ----------------------------------------------------------------------------
- (void)endDraggingWeightWithVelocity:(CGPoint)v
{
    CGFloat magnitude = sqrtf(powf(v.x, 2.0)+powf(v.y, 2.0));
    CGFloat angle = atan2(v.y, v.x);
    
    // Reduce the volocity to something meaningful.  (Prevents the user from
    // flinging the pendulum weight).
    magnitude /= 500;
    
    self.pushBehavior.angle = angle;
    self.pushBehavior.magnitude = magnitude;
    self.pushBehavior.active = YES;
    
    [self removeChildBehavior:self.draggingBehavior];
}

@end
