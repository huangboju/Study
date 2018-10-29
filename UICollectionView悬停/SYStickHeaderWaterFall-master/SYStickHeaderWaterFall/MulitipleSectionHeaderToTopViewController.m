//
//  MulitipleSectionHeaderToTopViewController.m
//  SYStickHeaderWaterFall
//
//  Created by Mac on 16/3/22.
//  Copyright © 2016年 suya. All rights reserved.
//

#import "MulitipleSectionHeaderToTopViewController.h"
#import "Classes/SYStickHeaderWaterFallLayout.h"
#import "HomeModel.h"
#import "MJExtension.h"
#import "SDCycleScrollView.h"
#import "HomePageHeadView.h"
#import "MJRefresh.h"
//#import "RequestCustom.h"
#import "BannerModel.h"
#import "MBProgressHUD.h"
#import "HPCollectionViewCell.h"
#import "UIView+SDExtension.h"
#import "SYSHomeRequest.h"
#import "SYSHomeBannerRequest.h"
#import "SYSMAINMacro.h"

#define kFileName @"MulitipleSectionNoTopHeightVC.plist"

@interface MulitipleSectionHeaderToTopViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,SDCycleScrollViewDelegate,SYStickHeaderWaterFallDelegate>
{
    NSInteger showPage;
    //    notiNilView *_notinilView;
    
    UICollectionReusableView *reusableView;
}
@property (nonatomic,strong)UIScrollView *baseScrollView;
@property (nonatomic,strong )SDCycleScrollView *cycleScrollADView;
@property(nonatomic,strong)UICollectionView * collectView;
@property(nonatomic,strong)NSMutableArray * shops;
@property (nonatomic,strong)NSMutableArray *shopForThree;
@property (nonatomic,strong)NSMutableArray *banners;
@property (nonatomic,strong)NSMutableDictionary *optionalParam;

@end

@implementation MulitipleSectionHeaderToTopViewController

-(NSMutableArray *)banners
{
    if (_banners ==nil) {
        self.banners = [NSMutableArray array];
    }
    return _banners;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (_shops==nil) {
        self.shops = [NSMutableArray array];
    }
    if (_shopForThree==nil) {
        self.shopForThree = [NSMutableArray array];
    }
    if (_optionalParam ==nil) {
        self.optionalParam = [[NSMutableDictionary alloc]init];
    }
    // Do any additional setup after loading the view.
    [self initCollectionView];
    [self initNavigationItem];
    [self initRefresh];
    [self initData];
    
    // Do any additional setup after loading the view.
}
-(void)initCollectionView
{
    SYStickHeaderWaterFallLayout *cvLayout = [[SYStickHeaderWaterFallLayout alloc] init];
    cvLayout.delegate = self;
    cvLayout.isStickyHeader = YES;
    
    self.collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight ) collectionViewLayout:cvLayout];
    self.collectView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.collectView];
    [self.view insertSubview:self.goToTopBtn aboveSubview:self.collectView];
    
    [self.collectView registerNib:[UINib nibWithNibName:@"HPCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:WaterfallCellIdentifier];
    
    [self.collectView registerClass:[HomePageHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:WaterfallHeaderIdentifier];
    [self.collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    
    self.collectView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        showPage += 1;
        NSString *page = [NSString stringWithFormat:@"%ld",(long)showPage];
        [self requestHomePageList:page refreshType:@"footer"];
    }];
}
-(void)initNavigationItem
{
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(16, 16, 14, 13);
    [self.leftBtn addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setImage:[UIImage imageNamed:@"top_sidebar.pdf"]  forState:UIControlStateNormal];
    //    [self.leftBtn setEnlargeEdgeWithTop:10 right:20 bottom:10 left:20];
    UIBarButtonItem *barLeftBtn = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    UIImageView *titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 34, 20)];
    titleImageView.image = [UIImage imageNamed:@"home_logo.pdf"];
    _titleImageView = titleImageView;
    self.navigationItem.titleView = _titleImageView;
    [self.navigationItem setLeftBarButtonItem:barLeftBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    [collectionView.collectionViewLayout invalidateLayout];
    
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger itemCount;
    if (section ==1) {
        if (self.shops.count ==0) {
            itemCount = 1;
        }else
        {
            itemCount = self.shops.count;
        }
        
        
    }
    else if(section ==0)
    {
        itemCount = 1;
    }else if (section ==2)
    {
        if (self.shopForThree.count ==0) {
            itemCount = 1;
        }else
        {
            itemCount = self.shopForThree.count;
        }
    }
    return itemCount;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    reusableView = nil;
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        HomePageHeadView *headView= (HomePageHeadView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:WaterfallHeaderIdentifier forIndexPath:indexPath];
        //            headView = [[HomePageHeadView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 30)];
        headView.tag = 1001 +indexPath.section;
        reusableView = headView;
        return reusableView;
    }
    
    return nil;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==1) {
        HPCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:WaterfallCellIdentifier forIndexPath:indexPath];
        //            cell.backgroundColor = listBgColor;
        cell.shop = self.shops[indexPath.item];
        //            personalGesture.cancelsTouchesInView = NO;
        cell.markImageView.userInteractionEnabled = YES;
        return cell;
        
    }else if (indexPath.section ==0)
    {
        SDCycleScrollView *cycleView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 18, kDeviceWidth, 180)];
        cycleView.autoScroll = true;
        cycleView.autoScrollTimeInterval = 4.0;
        cycleView.delegate = self;
        cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        
        SYSHomeBannerRequest *bannerRequest = [[SYSHomeBannerRequest alloc] initRequestWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]];
        [bannerRequest startWithCompletionBlockWithSuccess:^(__kindof BaseRequest *request, id obj) {
            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
            if ([status isEqual:@"1"]) {
                NSArray *dataArray = [obj objectForKey:@"data"];
                //                    NSDictionary *dataDict = (NSDictionary *)[obj objectForKey:@"data"];
                NSMutableArray *imageArray = [NSMutableArray array];
                _banners = [NSMutableArray array];
                if ([status isEqual:@"1"]) {
                    for (int i =0; i<[dataArray count]; i++) {
                        [_banners addObject:[BannerModel initBannerWithDict:dataArray[i]]];
                        [imageArray addObject:[dataArray[i] objectForKey:@"img_url"]];
                    }
                    cycleView.imageURLStringsGroup = imageArray;
                    
                }
            }
        } failure:^(__kindof BaseRequest *request, id obj) {
            
        }];
        //    [self.baseScrollView addSubview:cycleView];
        _cycleScrollADView = cycleView;
        
        
        
        UICollectionViewCell *cycleCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath ];
        cycleCollectionViewCell.frame = cycleView.frame;
        //        cycleCollectionViewCell.mj_y =38;
        //            [[UICollectionViewCell alloc]initWithFrame:cycleView.frame];
        [cycleCollectionViewCell addSubview:cycleView];
        return cycleCollectionViewCell;
        
    }else if (indexPath.section ==2)
    {
        HPCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:WaterfallCellIdentifier forIndexPath:indexPath];
        //            cell.backgroundColor = listBgColor;
        cell.shop = self.shopForThree[indexPath.item];
        //            personalGesture.cancelsTouchesInView = NO;
        cell.markImageView.userInteractionEnabled = YES;
        return cell;
    }
    
    return nil;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
//代理方法

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(SYStickHeaderWaterFallLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellHeight;
    if (indexPath.section ==1) {
        if (self.shops.count ==0) {
            cellHeight = kDeviceHeight - 64;
        }else
        {
            HomeModel * shop;
            
            //        if (indexPach.item ==nil) {
            //            shop = self.shops[0];
            //
            //        }else
            //        {
            shop = self.shops[indexPath.item];
            
            //        }
            
            //        cell.s
            
            cellHeight =  shop.height/shop.width*(kDeviceWidth/2-7.5);
        }
        
        
        
    }else if (indexPath.section ==0)
    {
        cellHeight =  180;
    }else if (indexPath.section ==2)
    {
        if (self.shopForThree.count ==0) {
            cellHeight = kDeviceHeight - 64;
        }else
        {
            HomeModel * shop;
            
            //        if (indexPach.item ==nil) {
            //            shop = self.shops[0];
            //
            //        }else
            //        {
            shop = self.shopForThree[indexPath.item];
            
            //        }
            
            //        cell.s
            
            cellHeight =  shop.height/shop.width*(kDeviceWidth/2-7.5);
        }
        
    }
    return cellHeight;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(SYStickHeaderWaterFallLayout *)collectionViewLayout
heightForHeaderAtIndexPath:(NSIndexPath *)indexPath {
    return 38.0f;
}
- (CGFloat)collectionView:(nonnull UICollectionView *)collectionView
                   layout:(nonnull SYStickHeaderWaterFallLayout *)collectionViewLayout
    widthForItemInSection:( NSInteger )section
{
    if (section ==0) {
        return kDeviceWidth;
    }else if (section ==1)
    {
        return (kDeviceWidth-15)/2;
    }else if (section ==2)
    {
        return (kDeviceWidth-15)/3;
    }
    return 0;
}


- (CGFloat) collectionView:(nonnull UICollectionView *)collectionView
                    layout:(nonnull SYStickHeaderWaterFallLayout *)collectionViewLayout
      headerToTopInSection:( NSInteger)section
{
    if (section ==0) {
        return 10;
    }else if (section == 1)
    {
        return 20;
    }
    return 0;
}
//SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    //广告页跳转
    //广告页跳转
}

-(void)requestHomePageList:(NSString *)page refreshType:(NSString *)type
{
//    SYSHomeRequest *homeRequest = [[SYSHomeRequest alloc] initRequestWithPageLine:10 pageNum:[page integerValue]];
    
    __weak typeof(self) weakSelf = self;
    
    NSData *data =  [self dataNamed:@"HomeData.json"];
    
    NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([obj objectForKey:@"data"]== [NSNull null]) {
            if ([page isEqualToString:@"1"]) {
                [weakSelf.shopForThree removeAllObjects];
                [weakSelf.shops removeAllObjects];
                [weakSelf.collectView.header endRefreshing];
                [weakSelf.collectView reloadData];
                
                return;
                
            }else
            {
                MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"内容看光了 刷新也白搭";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
                [weakSelf.collectView.footer endRefreshing];
                return ;
            }
            
        }
        NSArray *dataArray = [obj objectForKey:@"data"];
        NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
        if ([status isEqual:@"1"]) {
            weakSelf.collectView.delegate =self;
            weakSelf.collectView.dataSource =self;
            if ([status isEqual:@"1"]) {
                if ([page isEqualToString:@"1"]) {
                    [weakSelf.shopForThree removeAllObjects];
                    [weakSelf.shops removeAllObjects];
                    showPage = 1;
                }
                for (int i =0; i<[dataArray count]; i++) {
                    [weakSelf.shopForThree addObject:[HomeModel initHomeModelWithDict:dataArray[i]]];
                    //                    [_shops addObject:[HomeModel initHomeModelWithDict:dataArray[i]]];
                }
                if (showPage ==1) {
                    weakSelf.shops=[weakSelf.shopForThree mutableCopy];
                }
            }
            if ([type isEqualToString:@"header"]) {
                [weakSelf.collectView.header endRefreshing];
            }else if([type isEqualToString:@"footer"])
            {
                [weakSelf.collectView.footer endRefreshing];
            }
            
            [weakSelf.collectView reloadData];
        }
        
        
    });

//    [homeRequest startWithCompletionBlockWithSuccess:^(__kindof BaseRequest *request, id obj) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            if ([obj objectForKey:@"data"]== [NSNull null]) {
//                if ([page isEqualToString:@"1"]) {
//                    [weakSelf.shopForThree removeAllObjects];
//                    [weakSelf.shops removeAllObjects];
//                    [weakSelf.collectView.header endRefreshing];
//                    [weakSelf.collectView reloadData];
//                    
//                    return;
//                    
//                }else
//                {
//                    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
//                    hud.mode = MBProgressHUDModeText;
//                    hud.labelText = @"内容看光了 刷新也白搭";
//                    hud.margin = 10.f;
//                    hud.removeFromSuperViewOnHide = YES;
//                    [hud hide:YES afterDelay:1];
//                    [weakSelf.collectView.footer endRefreshing];
//                    return ;
//                }
//                
//            }
//            NSArray *dataArray = [obj objectForKey:@"data"];
//            NSString *status = [NSString stringWithFormat:@"%@",[obj objectForKey:@"status"]];
//            if ([status isEqual:@"1"]) {
//                weakSelf.collectView.delegate =self;
//                weakSelf.collectView.dataSource =self;
//                if ([status isEqual:@"1"]) {
//                    if ([page isEqualToString:@"1"]) {
//                        [weakSelf.shopForThree removeAllObjects];
//                        [weakSelf.shops removeAllObjects];
//                        showPage = 1;
//                    }
//                    for (int i =0; i<[dataArray count]; i++) {
//                        [weakSelf.shopForThree addObject:[HomeModel initHomeModelWithDict:dataArray[i]]];
//                        //                    [_shops addObject:[HomeModel initHomeModelWithDict:dataArray[i]]];
//                    }
//                    if (showPage ==1) {
//                        weakSelf.shops=[weakSelf.shopForThree mutableCopy];
//                    }
//                }
//                if ([type isEqualToString:@"header"]) {
//                    [weakSelf.collectView.header endRefreshing];
//                }else if([type isEqualToString:@"footer"])
//                {
//                    [weakSelf.collectView.footer endRefreshing];
//                }
//                
//                [weakSelf.collectView reloadData];
//            }
//            
//            
//        });
    
        
//    } failure:^(__kindof BaseRequest *request, id obj) {
//        if (weakSelf.view.superview) {
//            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.superview animated:YES];
//            hud.mode = MBProgressHUDModeText;
//            hud.labelText = @"网络不给力 挥泪重连中";
//            hud.margin = 10.f;
//            hud.removeFromSuperViewOnHide = YES;
//            [hud hide:YES afterDelay:1];
//        }
//        
//        if ([type isEqualToString:@"header"]) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [weakSelf.collectView.header endRefreshing];
//            });
//            
//            
//        }else if([type isEqualToString:@"footer"])
//        {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [weakSelf.collectView.footer endRefreshing];
//                
//            });
//            
//        }
//    }];
    
}
//

-(void)doAfter
{
    
}





//- (void)setScrollADImageURLStringsArray:(NSArray *)scrollADImageURLStringsArray
//{
//    _scrollADImageURLStringsArray = scrollADImageURLStringsArray;
//
//    _cycleScrollADView.imageURLStringsGroup = scrollADImageURLStringsArray;
//}
-(void)initRefresh
{
    UIImage *imgR1 = [UIImage imageNamed:@"shuaxin1"];
    
    UIImage *imgR2 = [UIImage imageNamed:@"shuaxin2"];
    
    //    UIImage *imgR3 = [UIImage imageNamed:@"cameras_3"];
    
    NSArray *reFreshone = [NSArray arrayWithObjects:imgR1, nil];
    
    NSArray *reFreshtwo = [NSArray arrayWithObjects:imgR2, nil];
    
    NSArray *reFreshthree = [NSArray arrayWithObjects:imgR1,imgR2, nil];
    
    
    
    
    
    
    MJRefreshGifHeader  *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [self requestHomePageList:@"1" refreshType:@"header"];
        
    }];
    
    [header setImages:reFreshone forState:MJRefreshStateIdle];
    
    [header setImages:reFreshtwo forState:MJRefreshStatePulling];
    [header setImages:reFreshthree duration:0.5 forState:MJRefreshStateRefreshing];
    //    [header setImages:reFreshthree forState:MJRefreshStateRefreshing];
    
    header.lastUpdatedTimeLabel.hidden  = YES;
    
    //    header.stateLabel.hidden            = YES;
    
    self.collectView.header   = header;
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ( self.collectView.contentOffset.y > 800) {
        self.goToTopBtn.alpha = 1;
        //        [self.view bringSubviewToFront:_goToTopBtn];
    } else {
        self.goToTopBtn.alpha = 0;
    }
}
-(UIButton *)goToTopBtn
{
    if(!_goToTopBtn)
    {
        _goToTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _goToTopBtn.backgroundColor = [UIColor clearColor];
        _goToTopBtn.frame = CGRectMake(kDeviceWidth-52, kDeviceHeight-52, 39, 39);
        _goToTopBtn.alpha = 0;
        [_goToTopBtn setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
        [_goToTopBtn addTarget:self action:@selector(goToTop) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goToTopBtn;
}
//回到顶部
- (void)goToTop
{
    [UIView animateWithDuration:0.5 animations:^{
        
        
        
    }completion:^(BOOL finished){
        
    }];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.collectView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:YES];
    
    
    
}
//获得文件路径
-(NSString *)dataFilePath{
    //检索Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES);//备注1
    NSString *documentsDirectory = [paths objectAtIndex:0];//备注2
    return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",kFileName]];
}

-(void)initData{
    NSString *filePath = [self dataFilePath];
    NSLog(@"filePath=%@",filePath);
    
    //从文件中读取数据，首先判断文件是否存在
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        //        NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
        //因为直接写入不成功，所以序列化一下,这里反序列化取出
        NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        for (int i =0; i<[array count]; i++) {
            [_shops addObject:[HomeModel initHomeModelWithDict:array[i]]];
            //                        ShowCell *cell = [[ShowCell alloc]initShowCell];
            //                        [_allCells addObject:cell];
        }
        //                    }if (showPage%2 ==0) {
        //                        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
        //                    }
        
        //先加载缓存数据
        [self.collectView reloadData];
    }
    //后加载新数据
    [self.collectView.header performSelector:@selector(beginRefreshing) withObject:nil];
}
-(void)clicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (NSData *)dataNamed:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    if (!path) return nil;
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}



@end
