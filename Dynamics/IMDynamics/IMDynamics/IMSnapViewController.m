//
//  IMSnapViewController.m
//  IMDynamics
//
//  Created by Ivan on 16/9/28.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import "IMSnapViewController.h"

@interface IMSnapViewController ()

@property (nonatomic, weak) UIImageView *box;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UISnapBehavior *snapBehavior;

@end

@implementation IMSnapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"Box1"];
    UIImageView *box = [[UIImageView alloc] initWithImage:image];
    box.frame = CGRectMake(120, CGRectGetMaxY(self.navigationController.navigationBar.frame), image.size.width, image.size.height);
    [self.view addSubview:box];
    self.box = box;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator = animator;
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.box]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collisionBehavior];
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.box]];
    [self.animator addBehavior:gravityBehavior];
}

- (IBAction)handleSnapGesture:(UIGestureRecognizer *)gesture{
    
    [self.animator removeBehavior:self.snapBehavior];
    
    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:self.box snapToPoint:[gesture locationInView:self.view]];
    snapBehavior.damping = 0;
    [self.animator addBehavior:snapBehavior];
    self.snapBehavior = snapBehavior;
    
    
}

@end
