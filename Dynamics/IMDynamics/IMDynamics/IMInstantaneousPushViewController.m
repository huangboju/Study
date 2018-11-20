//
//  IMInstantaneousPushViewController.m
//  IMDynamics
//
//  Created by Ivan on 16/9/28.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import "IMInstantaneousPushViewController.h"
#import "APLDecorationView.h"

@interface IMInstantaneousPushViewController ()

@property (nonatomic, weak) UIImageView *box;
@property (nonatomic, weak) UIImageView *origin;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIPushBehavior *pushBehavior;

@end

@implementation IMInstantaneousPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"Box1"];
    UIImageView *box = [[UIImageView alloc] initWithImage:image];
    box.frame = CGRectMake(self.view.frame.size.width*0.5-box.frame.size.width*0.5, CGRectGetMaxY(self.navigationController.navigationBar.frame), image.size.width, image.size.height);
    [self.view addSubview:box];
    self.box = box;
    
    UIImageView *origin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Origin"]];
    origin.frame = CGRectMake(self.view.frame.size.width*0.5, self.view.frame.size.height*0.5, origin.frame.size.width, origin.frame.size.height);
    [self.view addSubview:origin];
    self.origin = origin;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator = animator;
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.box]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collisionBehavior];
    
//    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.box]];
//    [self.animator addBehavior:gravityBehavior];
    
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.box] mode:UIPushBehaviorModeInstantaneous];
    self.pushBehavior = pushBehavior;
    [self.animator addBehavior:pushBehavior];
    

}

- (IBAction)hanglePushGesture:(UIGestureRecognizer *)gesture{
    
    CGPoint tapPoint = [gesture locationInView:self.view];
    CGVector pushDirection = CGVectorMake((tapPoint.x-self.origin.center.x)*10/self.view.frame.size.width, (tapPoint.y-self.origin.center.y)*10/self.view.frame.size.height);
    self.pushBehavior.pushDirection = pushDirection;
    self.pushBehavior.active = YES;
    
    
}
@end
























