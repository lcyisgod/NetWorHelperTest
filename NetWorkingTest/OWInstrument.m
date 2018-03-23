//
//  OWInstrument.m
//  Owner
//
//  Created by xiaolongxia on 2017/12/15.
//  Copyright © 2017年 Alog. All rights reserved.
//

#import "OWInstrument.h"
static OWInstrument *instrument;

@interface OWInstrument()

@property (nonatomic, strong)NSDictionary *infoDicitionary;

@end;

@implementation OWInstrument

+(OWInstrument *)shareDefault {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instrument = [[OWInstrument alloc] init];
    });
    return instrument;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        self.infoDicitionary = [[NSBundle mainBundle] infoDictionary];
    }
    return self;
}

-(NSString *)currentAppVersion {
    NSString *app_version = [_infoDicitionary objectForKey:@"CFBundleShortVersionString"];
    return app_version;
}

-(BOOL)checkPhoneNum:(NSString *)phone {
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(14[0-9])|(17[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}

-(BOOL)checkPassword:(NSString *)password {
    if (password.length >= 6 && password.length <=16) {
        int n = 0;
        
        //是否包含数字
        NSRange urgentRange0 = [password rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"0123456789"]];
        if (urgentRange0.location != NSNotFound) {
            n++;
        }
        
        //是否包含大写字母
        NSRange urgentRange1 = [password rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"ABCDEFGHJKLMNOPQRSTUVWXYZ"]];
        if (urgentRange1.location != NSNotFound) {
            n++;
        }
        
        //是否包含小写字母
        NSRange urgentRange2 = [password rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"abcdefghjklmnopqrstuvwxyz"]];
        if (urgentRange2.location != NSNotFound) {
            n++;
        }
        

        //是否含有特殊字符
        NSRange urgentRange = [password rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"-/:;()$&@\".,?!'[]{}#%^*+=_\\|~<>€￡￥·"]];
        if (urgentRange.location != NSNotFound) {
            n++;
        }
        
        
        if (n >= 2) {
            return YES;
        }else {
            return NO;
        }
    }else {
        return NO;
    }
}

-(BOOL)checkidCardNum:(NSString *)idCard {
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:idCard];
}

- (NSString *)jsonFromDict:(NSDictionary *)dict {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}


-(BOOL)checkAllChinaes:(NSString *)str {
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:str];  
}

-(NSDictionary *)dictionFromStr:(NSString *)str {
    if (str.length == 0) {
        return nil;
    }
    
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if (!err) {
        return nil;
    }else {
        return dict;
    }
}

- (NSString *)formateTime:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:date];
    return dateTime;
}

@end
