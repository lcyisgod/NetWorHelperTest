//
//  NSURL+CheckUrl.m
//  NetWorkingTest
//
//  Created by dsm on 2018/3/22.
//  Copyright © 2018年 dsm. All rights reserved.
//

#import "NSURL+CheckUrl.h"
#import <objc/runtime.h>

@implementation NSURL (CheckUrl)

+(void)load {
    [super load];
    Method sysUrl = class_getClassMethod(self, @selector(URLWithString:));
    Method checkUrl = class_getClassMethod(self, @selector(checkUrlWithString:));
    method_exchangeImplementations(sysUrl, checkUrl);
}

+(instancetype)checkUrlWithString:(NSString *)urlStr {
    NSURL *url = [NSURL checkUrlWithString:urlStr];
    if (url == nil) {
        NSLog(@"错误的url---->%@",urlStr);
    }
    return url;
}

@end
