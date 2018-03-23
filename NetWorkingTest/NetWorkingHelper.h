//
//  NetWorkingHelper.h
//  NetWorkingTest
//
//  Created by dsm on 2018/3/22.
//  Copyright © 2018年 dsm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkingHelper : NSObject

+(void)getDataWithUrlStr:(NSString *)url successBlock:(void (^)(id obj))success failueBlock:(void (^)(id obj))failue;
+(void)postDataWithParamer:(id)paramer successBlock:(void (^)(id obj))success failueBlock:(void (^)(id obj))failue;
@end
