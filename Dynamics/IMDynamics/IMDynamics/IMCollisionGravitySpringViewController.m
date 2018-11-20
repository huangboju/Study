//
//  IMCollisionGravitySpringViewController.m
//  IMDynamics
//
//  Created by Ivan on 16/9/28.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import "IMCollisionGravitySpringViewController.h"
#import "APLDecorationView.h"

@interface IMCollisionGravitySpringViewController ()

@property (nonatomic, weak) UIImageView *box;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *attachmentBehavior;
@property (nonatomic, weak) IBOutlet UIImageView *anchorpointView;
@property (nonatomic, assign) CGPoint anchorpoint;

@end

@implementation IMCollisionGravitySpringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加box的视图
    {
    UIImage *image = [[UIImage imageNamed:@"Box1"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *box = [[UIImageView alloc] initWithImage:image];
    box.frame = CGRectMake(120, CGRectGetMaxY(self.navigationController.navigationBar.frame)+120, image.size.width, image.size.height);
    [box setTintColor:[UIColor blueColor]];
    [self.view addSubview:box];
    self.box = box;
    }
    
    //添加self.attachmentView.center，并加入重力和碰撞
    {
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.box]];
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.box]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:gravityBehavior];
    [self.animator addBehavior:collisionBehavior];
    }
    
    //添加弹簧的轴心视图
    CGPoint anchorpoint = CGPointMake(self.box.center.x, self.box.center.y - 130);
    self.anchorpoint = anchorpoint;
    self.anchorpointView.center = anchorpoint;
    self.anchorpointView.tintColor = [UIColor redColor];
    self.anchorpointView.image = [self.anchorpointView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    //根据box和轴心视图
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.box attachedToAnchor:self.anchorpoint];
    attachmentBehavior.damping = 0.1;
    attachmentBehavior.frequency = 1;
    [self.animator addBehavior:attachmentBehavior];
    self.attachmentBehavior = attachmentBehavior;
    
    
    [(APLDecorationView*)self.view trackAndDrawAttachmentFromView:self.anchorpointView toView:self.box withAttachmentOffset:CGPointZero];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleSpringAttachmentGesture:(UIGestureRecognizer *)gesture{
    
    self.attachmentBehavior.anchorPoint = [gesture locationInView:self.view];
    self.anchorpointView.center = self.attachmentBehavior.anchorPoint;

}

@end
