//
//  OWInstrument.h
//  Owner
//
//  Created by xiaolongxia on 2017/12/15.
//  Copyright © 2017年 Alog. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OWInstrument;

@interface OWInstrument : NSObject
+(OWInstrument *)shareDefault;
//当前APP版本号
- (NSString *)currentAppVersion;
//验证手机号
- (BOOL)checkPhoneNum:(NSString *)phone;
//验证密码格式
- (BOOL)checkPassword:(NSString *)password;
//验证身份证格式
- (BOOL)checkidCardNum:(NSString *)idCard;
//字典转json字符串
- (NSString *)jsonFromDict:(NSDictionary *)dict;
//判断字符串是否是纯汉字
- (BOOL)checkAllChinaes:(NSString *)str;
//字符串转字典
- (NSDictionary *)dictionFromStr:(NSString *)str;
- (NSString *)formateTime:(NSDate *)date;
@end
