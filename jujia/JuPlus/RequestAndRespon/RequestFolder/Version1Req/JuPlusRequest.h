//
//  JuPlusRequest.h
//  JuPlus
//
//  Created by admin on 15/6/24.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "JuPlusResponse.h"
#import "AFNetWorkClient.h"
#import "ErrorInfoDto.h"
#define DEFAULT_PACKNAME @"the_pack_value_is_nil"

#define TDES_STRING @"TDES"
#define RSA_STRING @"RSA"
#define HMAC_STRING @"HMAC"

#pragma mark - Block functions Block 相关

///block 声明(网络加载结果处理)
#ifdef NS_BLOCKS_AVAILABLE
typedef void (^JuPlusBlock)(void);
typedef void (^JuPlusOperationCallBackBlock)(BOOL isSuccess, NSString *errorMsg);
typedef void (^JuPlusCallBackBlockWithResult)(BOOL isSuccess, NSString *errorCode,NSString *errorMsg,id result);
typedef void (^JuPlusArrayBlock)(NSArray *list);

typedef void (^JuPlusCallBackSuccess)(JuPlusResponse *response);
typedef void (^JuPlusCallBackFailed)(ErrorInfoDto *errorDTO);


#endif

//
typedef enum{
    RequestMethod_GET,              //GET
    RequestMethod_POST,             //POST
    RequestMethod_PUT,              //PUT
    RequestMethod_DELETE,           //DELETE
}RequestMethod;

//加密方式
typedef enum{
    
    SecurityMethod_RSA,             //RSA
    SecurityMethod_3DES,            //3DES
    
}SecurityMethod;

typedef enum{
    
    VerifyMethod_NONE,
    VerifyMethod_HMAC             //HMAC
    
}VerifyMethod;

@interface JuPlusRequest : NSObject

{
    
}

//    URL拼接顺序
@property(nonatomic,strong)NSArray * urlSeq;
//    http的请求方法
@property(nonatomic,assign)RequestMethod requestMethod;
//    需要验证的属性名
@property(nonatomic,strong)NSArray * validParams;
//    post和put需要发送的地址数据和json数据，get、delete只需要地址数据
@property(nonatomic,strong)NSMutableDictionary *packDic;
//  url
@property(nonatomic,strong)NSString * path;

@property(nonatomic,assign)SecurityMethod securityMethod;
@property(nonatomic,assign)VerifyMethod verifyMethod;

@property(nonatomic,strong)NSArray * verifySignSeq;

-(NSArray *)getUrlArray;

-(NSString *)getUrlString :(NSArray *) array;

-(NSString *)getrequestMethodString;

-(NSTimeInterval)getTimeout;

-(NSMutableDictionary *)getJsonDict;

-(void)setField:(id) value forKey:(NSString *) key;

-(NSString*)getField:(id) key;

-(NSArray *)getValidArray;

-(NSString *)getsecurityMethodString;

-(NSString *)getverifyMethodString;

-(NSArray *)getverifySignSeq;

-(void)validatePackValue:(NSDictionary *)dataDic ParamsArray:(NSArray *)paras Optional:(BOOL) optional;
@end
