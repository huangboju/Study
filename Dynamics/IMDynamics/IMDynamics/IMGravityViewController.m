//
//  IMGravityViewController.m
//  IMDynamics
//
//  Created by Ivan on 16/9/28.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import "IMGravityViewController.h"

@interface IMGravityViewController ()

@property (nonatomic, weak) UIImageView *box;
@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation IMGravityViewController

#pragma mark- 系统方法
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
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.box]];
    
    [self.animator addBehavior:gravityBehavior];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
