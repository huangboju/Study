//
//  IMCustomDynamicItemViewController.m
//  IMDynamics
//
//  Created by Ivan on 16/9/28.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import "IMCustomDynamicItemViewController.h"
#import "IMPositionToBoundsMapping.h"

@interface IMCustomDynamicItemViewController ()
@property (weak, nonatomic) IBOutlet UIButton *TapMeBtn;

@property (nonatomic, readwrite) CGRect button1Bounds;
@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation IMCustomDynamicItemViewController


//| ----------------------------------------------------------------------------
- (void)viewDidLoad
{
    // Save the button's initial bounds.  This is necessary so that the bounds
    // can be reset to their initial state before starting a new simulation.
    // Otherwise, the new simulation will continue from the bounds set in the
    // final step of the previous simulation which may have been interrupted
    // before it came to rest (e.g. the user tapped the button twice in quick
    // succession).  Without reverting to the initial bounds, this would cause
    // the button to grow uncontrollably in size.
    self.button1Bounds = self.TapMeBtn.bounds;
    
    // Force the button image to scale with its bounds.
    self.TapMeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    self.TapMeBtn.contentVerticalAlignment = UIControlContentHorizontalAlignmentFill;
}


//| ----------------------------------------------------------------------------
//  IBAction for tapping the button in this demo.
//
- (IBAction)buttonAction:(id)sender
{
    // Reset the buttons bounds to their initial state.  See the comment in
    // -viewDidLoad.
    self.TapMeBtn.bounds = self.button1Bounds;
    
    // UIDynamicAnimator instances are relatively cheap to create.
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // APLPositionToBoundsMapping maps the center of an id<ResizableDynamicItem>
    // (UIDynamicItem with mutable bounds) to its bounds.  As dynamics modifies
    // the center.x, the changes are forwarded to the bounds.size.width.
    // Similarly, as dynamics modifies the center.y, the changes are forwarded
    // to bounds.size.height.
    IMPositionToBoundsMapping *buttonBoundsDynamicItem = [[IMPositionToBoundsMapping alloc] initWithTarget:sender];
    
    // Create an attachment between the buttonBoundsDynamicItem and the initial
    // value of the button's bounds.
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:buttonBoundsDynamicItem attachedToAnchor:buttonBoundsDynamicItem.center];
    [attachmentBehavior setFrequency:2.0];
    [attachmentBehavior setDamping:0.3];
    [animator addBehavior:attachmentBehavior];
    
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[buttonBoundsDynamicItem] mode:UIPushBehaviorModeInstantaneous];
    pushBehavior.angle = M_PI_4;
    pushBehavior.magnitude = 2.0;
    [animator addBehavior:pushBehavior];
    
    [pushBehavior setActive:TRUE];
    
    self.animator = animator;
}


@end
