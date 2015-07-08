//
//  News.h
//  新闻
//
//  Created by 郭振虎 on 15/7/8.
//  Copyright (c) 2015年 郭振虎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
/*
 http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html
 科技	http://c.m.163.com/nc/article/list/T1348649580692/0-20.html
 手机	http://c.m.163.com/nc/article/list/T1348649654285/0-20.html
 移动互联	http://c.m.163.com/nc/article/list/T1351233117091/0-20.html
 首页广告	http://c.m.163.com/nc/ad/headline/0-4.html
 */
//模型属性
//标题
@property(nonatomic, copy) NSString  *title;
//摘要
@property(nonatomic, copy) NSString  *digest;
//图片
@property(nonatomic, copy) NSString  *imgsrc;
//跟帖数量
@property(nonatomic, assign) NSInteger replyCount;

//新闻模型创建的类方法
+(instancetype)newsWithDict:(NSDictionary *)dict;


//加载指定url的新闻数组
+(void)loadNewsListWithRULString:(NSString *)urlString;
@end
