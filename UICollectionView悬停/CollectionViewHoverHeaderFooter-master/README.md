# CollectionViewHoverHeaderFooter
like tableview plain style

a demo for [my blog 17_02_24](https://redtwowolf.github.io/2017/02/24/UICollectionView-Section-Header-Or-Footer-Pin.html)

iOS9 之后只需要设置两个属性便可以实现 `UICollectionView` section header 或 footer 悬停效果。
```
let layout = UICollectionViewFlowLayout()
layout.sectionHeadersPinToVisibleBounds = true
layout.sectionFootersPinToVisibleBounds = true
// ...

```

![collectionview](https://github.com/redtwowolf/CollectionViewHoverHeaderFooter/blob/master/CollectionViewHoverHeaderFooter.gif) 
