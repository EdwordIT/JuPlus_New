//
//  HttpCommunication.h
//  JuPlus
//
//  Created by admin on 15/6/29.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JuPlusRequest.h"
#import "JuPlusResponse.h"

@interface HttpCommunication : NSObject
//token失效
#define ERROR_TOKEN_INVALID 110003
//效果图不存在
#define ERROR_NO_COLLOCATION 130001
//单品不存在
#define ERROR_NO_PRODUCT 120001
//强制更新
#define ERROR_VERSON_OUT 900001
//需要版本更新
#define VERSION_UPDATE 100000
//链接服务器错误
#define ERROR_SERVER_OUT 404
//考虑到扩展性，可以自定义HTTPRequestOperation的类，继承ASIHTTPRequest，然后直接返回HTTPRequestOperation
//success、failure block可以适当加一些参数比如返回的数据这些

+(NSURLSessionDataTask *)request:(JuPlusRequest *)request getResponse:(JuPlusResponse *)response
       Success:(JuPlusCallBackSuccess)successBlock
        failed:(JuPlusCallBackFailed)failedBlock
        showProgressView:(BOOL)showProgressBar
          with:(UIView *)view;

@end
