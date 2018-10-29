SYStickHeaderWaterFall 中文介绍
==============

[![license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/zhangsuya/SYStickHeaderWaterFall) [![pod](https://img.shields.io/badge/pod-0.0.7-yellow.svg)](https://github.com/zhangsuya/SYStickHeaderWaterFall) [![platform](https://img.shields.io/badge/platform-iOS-ff69b4.svg)](https://github.com/zhangsuya/SYStickHeaderWaterFall) [![aboutme](https://img.shields.io/badge/about%20me-zhangsuya-blue.svg)](http://www.jianshu.com/u/f2503bba4cfa)


More flexible support various types of waterfalls flow .（更加灵活支持各种类型的瀑布流结构。）

![image](https://github.com/zhangsuya/SYStickHeaderWaterFall/blob/master/SYStickHeaderWaterFall/2.gif)

以后封装任务：
1.装饰视图的增加。


安装
==============

### CocoaPods

1. 将 cocoapods 更新至最新版本.
2. 在 Podfile 中添加 `pod "SYStickHeaderWaterFall"`。
3. 执行 `pod install` 或 `pod update`。

(usage) 用法
==============
### (init and set delegate) 初始化并设置delegate：

    SYStickHeaderWaterFallLayout *cvLayout = [[SYStickHeaderWaterFallLayout alloc] init];

    cvLayout.delegate = self;


### (set property) 设置属性：

 //是否设置sectionHeader停留,默认YES
 
    cvLayout.isStickyHeader = YES;
    
//是否设置Footer停留,默认NO

    cvLayout.isStickyFooter = NO;
    
//section停留的位置是否包括原来设置的top，默认NO

    cvLayout.isTopForHeader = YES;
    
//当你用UINavigationController和UITabbarViewController并设置一些属性时，collectionview的展示视图的坐标y会变得很奇怪，那就在此修正,默认64

    cvLayout.fixTop = 64.0f;
  
### (implement delegate method) 实现代理方法：

// 返回所在section的每个item的width（一个section只有一个width）

    - (CGFloat)collectionView:(nonnull UICollectionView *)collectionView
                   layout:(nonnull SYStickHeaderWaterFallLayout *)collectionViewLayout
    widthForItemInSection:( NSInteger )section;

// 返回所在indexPath的每个item的height（每个item有一个height，要不然怎么是瀑布流😄）

    - (CGFloat)collectionView:(nonnull UICollectionView *)collectionView
                   layout:(nonnull SYStickHeaderWaterFallLayout *)collectionViewLayout
    heightForItemAtIndexPath:(nonnull NSIndexPath *)indexPath;

@optional

// 返回所在indexPath的header的height

    - (CGFloat) collectionView:(nonnull UICollectionView *)collectionView
                    layout:(nonnull SYStickHeaderWaterFallLayout *)collectionViewLayout
    heightForHeaderAtIndexPath:(nonnull NSIndexPath *)indexPath;


// 返回所在indexPath的footer的height

    - (CGFloat) collectionView:(nonnull UICollectionView *)collectionView
                    layout:(nonnull SYStickHeaderWaterFallLayout *)collectionViewLayout
    heightForFooterAtIndexPath:(nonnull NSIndexPath *)indexPath;


//  返回所在section与上一个section的间距(表达的可能不够准确，但是你们都懂的)

    - (CGFloat) collectionView:(nonnull UICollectionView *)collectionView
                    layout:(nonnull SYStickHeaderWaterFallLayout *)collectionViewLayout
    topInSection:(NSInteger )section;

//  返回所在section与下一个section的间距(表达的可能不够准确，但是你们都懂的)

    - (CGFloat) collectionView:(nonnull UICollectionView *)collectionView
                    layout:(nonnull SYStickHeaderWaterFallLayout *)collectionViewLayout
            bottomInSection:( NSInteger)section;

// 返回所在section的header停留时与顶部的距离（如果设置isTopForHeader ＝ yes ，则距离会叠加）

    - (CGFloat) collectionView:(nonnull UICollectionView *)collectionView
                    layout:(nonnull SYStickHeaderWaterFallLayout *)collectionViewLayout
           headerToTopInSection:( NSInteger)section;

另
==============
有什么问题可以邮箱联系我，或者issue我。也可以加交流群：436043199
