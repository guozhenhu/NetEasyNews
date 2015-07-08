//
//  News.m
//  新闻
//
//  Created by 郭振虎 on 15/7/8.
//  Copyright (c) 2015年 郭振虎. All rights reserved.
//

#import "News.h"
#import "networkTools.h"

@implementation News

//创建模型并初始化
+(instancetype)newsWithDict:(NSDictionary *)dict{
    
    id obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}

//加载指定url的新闻数组
+(void)loadNewsListWithRULString:(NSString *)urlString{
    //发起网络请求
    [[networkTools sharedNetworkTools] GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //因为返回的是text/html类型  需给AFN添加这种类型的解析在创建单例的时候
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
