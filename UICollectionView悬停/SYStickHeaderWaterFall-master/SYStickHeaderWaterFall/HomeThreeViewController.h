//
//  HomeThreeViewController.h
//  mokoo
//
//  Created by Mac on 15/12/14.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  HomeThreeViewControllerDelegate for SlidingMenuViewController, show menu
 */
@protocol HomeThreeViewControllerDelegate <NSObject>
@optional
- (void)leftBtnClicked;

@end
/**
 *  HomeThreeViewController use one collectionview to implement cover flow  and sticky head
 */
@interface HomeThreeViewController : UIViewController
@property (strong, nonatomic) UIButton *leftBtn;
@property (nonatomic,strong) UIImageView *titleImageView;
//@property (nonatomic, strong) NSArray *scrollADImageURLStringsArray;
@property (nonatomic,weak) id<HomeThreeViewControllerDelegate>delegate;
@property (nonatomic,strong)UIButton *goToTopBtn;

@end
