//
//  IMPositionToBoundsMapping.h
//  IMDynamics
//
//  Created by Ivan on 16/9/29.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//! A derivative of the UIDynamicItem protocol that requires objects adopting it
//! to expose a mutable bounds property.
@protocol ResizableDynamicItem <UIDynamicItem>
@property (nonatomic, readwrite) CGRect bounds;
@end

@interface IMPositionToBoundsMapping : NSObject<UIDynamicItem>

- (instancetype)initWithTarget:(id<ResizableDynamicItem>)target;

@end
