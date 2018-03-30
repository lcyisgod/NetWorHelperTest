//
//  ViewController.m
//  NetWorkingTest
//
//  Created by dsm on 2018/3/22.
//  Copyright © 2018年 dsm. All rights reserved.
//

#import "ViewController.h"
#import "NetWorkingHelper.h"
#import <CommonCrypto/CommonDigest.h>
#import "OWInstrument.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutletCollection(UITableView) NSArray *baseTable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [NetWorkingHelper getDataWithUrlStr:@"http://xy.alog.com:9010/api/v1/countries/getCountryCode" successBlock:^(id obj) {
//        NSLog(@"%@",obj);
//    } failueBlock:^(id obj) {
//        NSLog(@"%@",obj);
//    }];
 
    [self.navigationItem setTitle:@"测试"];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"发起" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    [self.navigationItem setRightBarButtonItem:rightBar];
}

-(void)post {
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setObject:@"18668222523" forKey:@"userid"];
    [dataDic setObject:@"86" forKey:@"areaCode"];
    [dataDic setObject:[NSNumber numberWithInt:3] forKey:@"role"];
    //对密码进行MD5加密
    NSString *strPassword = [NSString stringWithFormat:@"%@@3bi&LEMUE7lVMTa",@"qwer?123"];
    strPassword = [self md5HexDigest:strPassword];
    strPassword = strPassword.lowercaseString;
    //在加一次
    [dataDic setObject:[self md5HexDigest:strPassword] forKey:@"password"];
    
    NSString *jsonStr = [[OWInstrument shareDefault] jsonFromDict:dataDic];
    
    [dataDict setObject:jsonStr forKey:@"simpleAccountService.login"];
    
    [NetWorkingHelper postDataWithParamer:dataDict url:@"http://gate.ys.51juban.com/odin/servlet/gate/single" successBlock:^(id obj) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict);
    } failueBlock:^(id obj) {
        NSLog(@"%@",obj);
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cells = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cells];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cells];
    }
    cell.textLabel.text = @"321";
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}


-(void)actionLogin:(id)seder {
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setObject:@"18668222523" forKey:@"userid"];
    [dataDic setObject:@"86" forKey:@"areaCode"];
    [dataDic setObject:[NSNumber numberWithInt:3] forKey:@"role"];
    //对密码进行MD5加密
    NSString *strPassword = [NSString stringWithFormat:@"%@@3bi&LEMUE7lVMTa",@"qwer?123"];
    strPassword = [self md5HexDigest:strPassword];
    strPassword = strPassword.lowercaseString;
    //在加一次
    [dataDic setObject:[self md5HexDigest:strPassword] forKey:@"password"];
    
    NSString *jsonStr = [[OWInstrument shareDefault] jsonFromDict:dataDic];
    
    [dataDict setObject:jsonStr forKey:@"simpleAccountService.login"];
    
    [NetWorkingHelper postDataWithParamer:dataDict
                                      url:@"http://gate.ys.51juban.com/odin/servlet/gate/single"
                             successBlock:^(id obj) {
                                 NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingMutableContainers error:nil];
                                 NSLog(@"%@",dict);
                             } failueBlock:^(id obj) {
                                 NSLog(@"%@",obj);
                             }];
}



- (IBAction)loginClick:(id)sender {
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setObject:@"18668222523" forKey:@"userid"];
    [dataDic setObject:@"86" forKey:@"areaCode"];
    [dataDic setObject:[NSNumber numberWithInt:3] forKey:@"role"];
    //对密码进行MD5加密
    NSString *strPassword = [NSString stringWithFormat:@"%@@3bi&LEMUE7lVMTa",@"qwer?123"];
    strPassword = [self md5HexDigest:strPassword];
    strPassword = strPassword.lowercaseString;
    //在加一次
    [dataDic setObject:[self md5HexDigest:strPassword] forKey:@"password"];
    
    NSString *jsonStr = [[OWInstrument shareDefault] jsonFromDict:dataDic];
    
    [dataDict setObject:jsonStr forKey:@"simpleAccountService.login"];
    
    [NetWorkingHelper postDataWithParamer:dataDict
                                      url:@"http://gate.ys.51juban.com/odin/servlet/gate/single"
                             successBlock:^(id obj) {
                                 NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingMutableContainers error:nil];
                                 NSLog(@"%@",dict);
                             }
                              failueBlock:^(id obj) {NSLog(@"%@",obj);
                                  
                              }];
}

- (NSString *)md5HexDigest:(NSString*)password
{
    const char *str= [password UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    
    NSLog(@"===========%@",ret.lowercaseString);
    return ret.lowercaseString;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
