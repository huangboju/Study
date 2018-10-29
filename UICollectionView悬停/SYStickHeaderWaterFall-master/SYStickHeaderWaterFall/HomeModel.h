//
//  shopModel.h
//  瀑布流demo
//
//  Created by yuxin on 15/6/6.
//  Copyright (c) 2015年 yuxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HomeModel : NSObject
@property (nonatomic,copy)NSString *user_id;
@property (nonatomic,copy)NSString *user_name;
@property (nonatomic,copy)NSString *nick_name;
@property (nonatomic,copy)NSString *user_img;
@property (nonatomic,copy)NSString *card_id;
@property (nonatomic,copy)NSString *model_img;
@property (nonatomic,assign)CGFloat width;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,copy)NSString *city;
@property (nonatomic,copy)NSString *is_verify;
+(instancetype)initHomeModelWithDict:(NSDictionary *)dict;

//"user_id":"用户ID",
//"user_name":"用户名",
//"nick_name":"用户昵称",
//"user_img":"用户头像",
//"model_id":"模特卡ID",
//"model_img":"图片链接",
//"width":"图片宽度",
//"height":"图片高度",
//"city":"城市",
//"is_verify":"是否实名认证",  0.否   1.是

@end
