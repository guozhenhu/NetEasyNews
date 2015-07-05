//
//  networkTools.h
//  新闻
//
//  Created by 郭振虎 on 15/7/5.
//  Copyright (c) 2015年 郭振虎. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface networkTools : AFHTTPSessionManager

//创建一个网络工具类单例  全局访问入口

+(instancetype)sharedNetworkTools;



@end
