//
//  IMPositionToBoundsMapping.m
//  IMDynamics
//
//  Created by Ivan on 16/9/29.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import "IMPositionToBoundsMapping.h"

@interface IMPositionToBoundsMapping ()
@property (nonatomic, strong) id<ResizableDynamicItem> target;
@end

@implementation IMPositionToBoundsMapping

//| ----------------------------------------------------------------------------
- (instancetype)initWithTarget:(id<ResizableDynamicItem>)target
{
    self = [super init];
    if (self)
    {
        _target = target;
    }
    return self;
}

#pragma mark -
#pragma mark UIDynamicItem

//| ----------------------------------------------------------------------------
//  Manual implementation of the getter for the bounds property required by
//  UIDynamicItem.
//
- (CGRect)bounds
{
    // Pass through
    return self.target.bounds;
}

//| ----------------------------------------------------------------------------
//  Manual implementation of the getter for the center property required by
//  UIDynamicItem.
//
- (CGPoint)center
{
    // center.x <- bounds.size.width, center.y <- bounds.size.height
    return CGPointMake(self.target.bounds.size.width, self.target.bounds.size.height);
}


//| ----------------------------------------------------------------------------
//  Manual implementation of the setter for the center property required by
//  UIDynamicItem.
//
- (void)setCenter:(CGPoint)center
{
    // center.x -> bounds.size.width, center.y -> bounds.size.height
    self.target.bounds = CGRectMake(0, 0, center.x, center.y);
}


//| ----------------------------------------------------------------------------
//  Manual implementation of the getter for the transform property required by
//  UIDynamicItem.
//
- (CGAffineTransform)transform
{
    // Pass through
    return self.target.transform;
}


//| ----------------------------------------------------------------------------
//  Manual implementation of the setter for the transform property required by
//  UIDynamicItem.
//
- (void)setTransform:(CGAffineTransform)transform
{
    // Pass through
    self.target.transform = transform;
}



@end
