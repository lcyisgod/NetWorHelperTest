//
//  NetWorkingHelper.m
//  NetWorkingTest
//
//  Created by dsm on 2018/3/22.
//  Copyright © 2018年 dsm. All rights reserved.
//

#import "NetWorkingHelper.h"
#import "NSURL+CheckUrl.h"
#import "OWInstrument.h"

static NetWorkingHelper *shareNetworking = nil;

@interface NetWorkingHelper()<NSURLSessionDataDelegate>
@property (nonatomic, strong) NSURLSession *session;
@end
@implementation NetWorkingHelper

+(instancetype)shareDefault {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareNetworking = [[NetWorkingHelper alloc] init];
    });
    return shareNetworking;
}

-(instancetype)init {
    if (self == [super init]) {
        _session = [NSURLSession sharedSession];
    }
    return self;
}

+(void)getDataWithUrlStr:(NSString *)url
            successBlock:(void (^)(id))success
             failueBlock:(void (^)(id))failue {
    NetWorkingHelper *helper = [NetWorkingHelper shareDefault];
    //对url进行转码,防止有中文产生
    NSString *urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURLSessionDataTask *dataTask = [helper.session dataTaskWithURL:[NSURL URLWithString:urlStr] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!error) {
                    success(data);
                }else {
                    failue(error);
                }
            });
        }];
        [dataTask resume];
    });
}

+(void)postDataWithParamer:(id)paramer url:(NSString *)urlStr successBlock:(void (^)(id))success failueBlock:(void (^)(id))failue {
    NetWorkingHelper *helper = [NetWorkingHelper shareDefault];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    //设置请求超时时间
//    request.timeoutInterval = 0.5;
//    //设置缓存策略
//    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
//    //设置请求方式
    request.HTTPMethod = @"POST";
    //设置请求头
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

    //设置请求体
    request.HTTPBody = [NetWorkingHelper requestDataWithObj:paramer];
    
    //将网络请求放到子线程去执行
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURLSessionDataTask *dataTask = [helper.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //在主线程回传数据并处理
                if (!error) {
                    success(data);
                }else {
                    failue(error);
                }
            });
        }];
        [dataTask resume];
    });
}

//苹果官方的请求体最终封装成字符串类型
+(NSData *)requestDataWithObj:(id)paramer {
    NSString *dataStr = @"";
    if ([paramer isKindOfClass:[NSString class]]) {
        dataStr = [paramer mutableCopy];
    }else if ([paramer isKindOfClass:[NSDictionary class]]) {
        NSArray *keys = [paramer allKeys];
        for (NSString *key in keys) {
            NSString *value = [paramer objectForKey:key];
            NSString *valueAll = [key stringByAppendingString:[NSString stringWithFormat:@"=%@",value]];
            dataStr = [dataStr stringByAppendingString:valueAll];
        }
    }else {
        
    }
    return [dataStr dataUsingEncoding:NSUTF8StringEncoding];
}

@end
