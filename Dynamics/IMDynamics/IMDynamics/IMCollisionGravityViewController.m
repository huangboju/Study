//
//  IMCollisionGravityViewController.m
//  IMDynamics
//
//  Created by Ivan on 16/9/28.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import "IMCollisionGravityViewController.h"

@interface IMCollisionGravityViewController ()<UIDynamicAnimatorDelegate,UICollisionBehaviorDelegate>

@property (nonatomic, weak) UIImageView *box;
@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation IMCollisionGravityViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage *image = [[UIImage imageNamed:@"Box1"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *box = [[UIImageView alloc] initWithImage:image];
    
    box.frame = CGRectMake(120, CGRectGetMaxY(self.navigationController.navigationBar.frame), image.size.width, image.size.height);
    [box setTintColor:[UIColor blueColor]];
    [self.view addSubview:box];
    self.box = box;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator.delegate = self;
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.box]];
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.box]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    collisionBehavior.collisionDelegate = self;
    
    [self.animator addBehavior:gravityBehavior];
    [self.animator addBehavior:collisionBehavior];
    
}

// The identifier of a boundary created with translatesReferenceBoundsIntoBoundary or setTranslatesReferenceBoundsIntoBoundaryWithInsets is nil
- (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(nullable id <NSCopying>)identifier atPoint:(CGPoint)p{
    [(UIView *)item setTintColor:[UIColor yellowColor]];
//    NSLog(@"2222----%s",__func__);

}
- (void)collisionBehavior:(UICollisionBehavior*)behavior endedContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(nullable id <NSCopying>)identifier{
    [(UIView *)item setTintColor:[UIColor redColor]];
//    NSLog(@"2222----%s",__func__);

}


@end
