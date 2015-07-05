//
//  networkTools.m
//  新闻
//
//  Created by 郭振虎 on 15/7/5.
//  Copyright (c) 2015年 郭振虎. All rights reserved.
//

#import "networkTools.h"

@implementation networkTools

+(instancetype)sharedNetworkTools{
    //创建网络工具类单例
    static networkTools *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //网页前面的相同url
        NSURL *baseURL = [NSURL URLWithString:@"http://c.m.163.com/nc/article/"];
        instance = [[self alloc] initWithBaseURL:baseURL];
    });
    return instance;
}

@end
