//
//  IMCompositeBehaviorViewController.m
//  IMDynamics
//
//  Created by Ivan on 16/9/28.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import "IMCompositeBehaviorViewController.h"
#import "APLDecorationView.h"
#import "IMPendulumBehavior.h"

@interface IMCompositeBehaviorViewController ()

@property (nonatomic, weak) UIImageView *box;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, weak) IBOutlet UIImageView *anchorpointView;
@property (nonatomic, weak) IMPendulumBehavior *pendulumBehavior;

@end

@implementation IMCompositeBehaviorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加box的视图
    {
        UIImage *image = [[UIImage imageNamed:@"Box1"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *box = [[UIImageView alloc] initWithImage:image];
        box.frame = CGRectMake(self.view.frame.size.width*0.5-box.frame.size.width*0.5, CGRectGetMaxY(self.navigationController.navigationBar.frame) + 250, image.size.width, image.size.height);
        [box setTintColor:[UIColor blueColor]];
        [self.view addSubview:box];
        self.box = box;
    }
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    //添加钟摆的轴心视图
    self.anchorpointView.tintColor = [UIColor redColor];
    self.anchorpointView.image = [self.anchorpointView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [(APLDecorationView*)self.view trackAndDrawAttachmentFromView:self.anchorpointView toView:self.box withAttachmentOffset:CGPointZero];
    
    IMPendulumBehavior *pendulumBehavior = [[IMPendulumBehavior alloc] initWithWeight:self.box suspendedFromPoint:self.anchorpointView.center];
//    [self.animator addBehavior:pendulumBehavior];
    self.pendulumBehavior = pendulumBehavior;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)dragWeight:(UIPanGestureRecognizer*)gesture
//{
//    if (gesture.state == UIGestureRecognizerStateBegan)
//        [self.pendulumBehavior beginDraggingWeightAtPoint:[gesture locationInView:self.view]];
//    else if (gesture.state == UIGestureRecognizerStateEnded)
//        [self.pendulumBehavior endDraggingWeightWithVelocity:[gesture velocityInView:self.view]];
//    else if (gesture.state == UIGestureRecognizerStateCancelled)
//    {
//        gesture.enabled = YES;
//        [self.pendulumBehavior endDraggingWeightWithVelocity:[gesture velocityInView:self.view]];
//    }
//    else if (!CGRectContainsPoint(self.box.bounds, [gesture locationInView:self.box]))
//        // End the gesture if the user's finger moved outside square1's bounds.
//        // This causes the gesture to transition to the cencelled state.
//        gesture.enabled = NO;
//    else
//        [self.pendulumBehavior dragWeightToPoint:[gesture locationInView:self.view]];
//}


@end
