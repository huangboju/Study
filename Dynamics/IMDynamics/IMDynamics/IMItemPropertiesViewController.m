//
//  IMItemPropertiesViewController.m
//  IMDynamics
//
//  Created by Ivan on 16/9/28.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import "IMItemPropertiesViewController.h"

@interface IMItemPropertiesViewController ()<UIDynamicAnimatorDelegate,UICollisionBehaviorDelegate>

@property (nonatomic, weak) UIImageView *box;
@property (nonatomic, weak) UIImageView *box01;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIDynamicItemBehavior *boxBehavior;
@property (nonatomic, strong) UIDynamicItemBehavior *box01Behavior;


@end

@implementation IMItemPropertiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [[UIImage imageNamed:@"Box1"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *box = [[UIImageView alloc] initWithImage:image];
    box.frame = CGRectMake(80, CGRectGetMaxY(self.navigationController.navigationBar.frame), image.size.width, image.size.height);
    [box setTintColor:[UIColor blueColor]];
    [self.view addSubview:box];
    self.box = box;
    
    UIImage *image01 = [[UIImage imageNamed:@"Box1"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *box01 = [[UIImageView alloc] initWithImage:image01];
    box01.frame = CGRectMake(200, CGRectGetMaxY(self.navigationController.navigationBar.frame), image01.size.width, image01.size.height);
    [box01 setTintColor:[UIColor redColor]];
    [self.view addSubview:box01];
    self.box01 = box01;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator.delegate = self;
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.box,self.box01]];
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.box,self.box01]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    collisionBehavior.collisionDelegate = self;
    
    self.boxBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.box]];
    self.boxBehavior.elasticity = 0.5;
    
    self.box01Behavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.box01]];

    
    [self.animator addBehavior:gravityBehavior];
    [self.animator addBehavior:collisionBehavior];
    [self.animator addBehavior:self.boxBehavior];
    [self.animator addBehavior:self.box01Behavior];
}

- (IBAction)DidClickedReplayBtn:(UIButton *)sender {
    
    sender.enabled = NO;
    
    self.box.frame = CGRectMake(80, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.box.frame.size.width, self.box.frame.size.height);
   
    self.box01.frame = CGRectMake(200, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.box.frame.size.width, self.box.frame.size.height);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.animator updateItemUsingCurrentState:self.box];
        [self.animator updateItemUsingCurrentState:self.box01];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.enabled = YES;
    });

    
    
}



@end
