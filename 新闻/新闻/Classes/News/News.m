//
//  News.m
//  新闻
//
//  Created by 郭振虎 on 15/7/8.
//  Copyright (c) 2015年 郭振虎. All rights reserved.
//

#import "News.h"
#import "networkTools.h"
#import <objc/runtime.h>

@implementation News

//创建模型并初始化
+(instancetype)newsWithDict:(NSDictionary *)dict{
    
    id obj = [[self alloc] init];
    
    //拿到我们想要的模型的属性key 字典转模型
    NSArray *properties = [self loadProperties];
    for (NSString *key in properties) {
        //先判断dict是否存在对应的key  如果不上就什么都不做
        if (dict[key] != nil) {
            [obj setValue:dict[key] forKey:key];
        }
        
    }
    //    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}

//运用运行时 类方法  动态的获取、添加类的属性
+(NSArray *)loadProperties{
    //参数1：要copy的类名
    //参数2：属性计数指针（属性的数量）
    unsigned int count = 0;
    //找源文件  看接收类型 是C语言数组 count是属性的个数
    objc_property_t *list = class_copyPropertyList([self class], &count);
    
    //遍历数组  获得每个属性
    //创建可变字典 保存获得的属性名
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        //获得属性
        objc_property_t properties = list[i];
        //获得属性名
        const char *cName = property_getName(properties);
        //把属性名添加到可变字典
        [arrayM addObject:[NSString stringWithUTF8String:cName]];
    }
    return arrayM.copy;
//    return @[@"title",@"digest",@"imgsrc",@"replyCount"];
}


//重写description方法 可以返回模型的属性列表
-(NSString *)description{
    //根据我们想要的字典属性 创建字典
    NSArray *properties = [self.class loadProperties];
    NSDictionary *dict = [self dictionaryWithValuesForKeys:properties];
    
    //返回格式 <类：指针> 字典
    return [NSString stringWithFormat:@"<%@：%p> %@",self.class,self,dict];
}


//加载指定url的新闻数组
+(void)loadNewsListWithRULString:(NSString *)urlString{
    //发起网络请求
    [[networkTools sharedNetworkTools] GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        //因为返回的是text/html类型  需给AFN添加这种类型的解析在创建单例的时候
//        NSLog(@"%@",responseObject);

        //url不同 ，第一层字典的key不同
        //根据keyEnumerator.nextObject可以获取第一层的key （修改respondObject类型）
        //第一层key对应的value是一个数组  里面装的又使字典
        NSArray *array = responseObject[responseObject.keyEnumerator.nextObject];
//        NSLog(@"%@",array);
        
        //得到了第二层的数组后  就可以将数组里面的字典转模型了
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
        //capacity：容量  假设10 ，就是一次性开品10的存储空间，当添加11个元素时，会再开辟10个空间
        //用[NSMutableArray array]创建可变数组，是在每才添加对象的时候，临时申请开辟一个存储空间  这样的效率不会太好
        for (NSDictionary  *dic in array) {//数组中的对象是多个字典
//            News *new = [News newsWithDict:dic];
//            [arrayM addObject:new];
            [arrayM addObject:[self newsWithDict:dic]];
        }
        NSLog(@"%@",arrayM.copy);
        //这样的话运行会崩，因为arrayM中有的属性key不支持
        //我们可以在创建模型初始化的时候，指定我们想要截取的key
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
