
//  HttpCommunication.m
//  JuPlus
//
//  Created by admin on 15/6/29.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "HttpCommunication.h"
#import "NetException.h"
#import "TimeoutException.h"
#import "CommonUtil.h"
#import "JuPlusLoadingView.h"
#import "LFCGzipUtillity.h"
#import "UnPackException.h"
#import "ErrorInfoDto.h"
#import "JuPlusUIViewController.h"
#import "JuPlusGlobalData.h"
@implementation HttpCommunication
/*
    1、request 相对应的请求头
    2、response 请求得到的本地数据处理，一般要重新自定义方法
 */
//数据处理
+(NSURLSessionDataTask *)request:(JuPlusRequest *)request getResponse:(JuPlusResponse *)response
           Success:(JuPlusCallBackSuccess)successBlock
            failed:(JuPlusCallBackFailed)failedBlock
  showProgressView:(BOOL)showProgressBar
              with:(UIView *)view
{
    if(showProgressBar)
    {
        [self showWaitingView:view withTitle:nil];
    }
    
    //组包验证信息
    [request validatePackValue:[request getJsonDict] ParamsArray:[request getValidArray] Optional:NO];
#pragma mark --此处上传设备信息，如：经纬度、UUID、城市等
    //NSJSONWritingPrettyPrinted 设置转化之后格式化输出。如果不设置，即为单纯字符串
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[JuPlusGlobalData getAppInfoDic] options:0 error:nil];
    NSString *dicStr = [[NSString alloc] initWithData:jsonData encoding:NSISOLatin1StringEncoding];
    NSString *userAgent = [NSString stringWithFormat:@"Jujia-App_%d:IOS%@", [[[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey] intValue],dicStr];
    
    [[AFNetWorkClient sharedClient].requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];

    NSString *path = [request getUrlString:[request getUrlArray]];
    if([[request getrequestMethodString] isEqualToString:@"GET"])
    {
       return [[AFNetWorkClient sharedClient] GET:path  parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
            //如果返回状态码为200，则为成功，可以解析data数据
           [HttpCommunication dismissWaitingView:view];
           //如果连接服务器成功，则隐藏reload界面
           if ([view isKindOfClass:[JuPlusUIView class]]) {
               [((JuPlusUIView *)view).reloadImage setHidden:YES];
           }else{
               UIViewController *vc = view.viewController;
               if ([vc isKindOfClass: [JuPlusUIViewController class]]) {
                   [((JuPlusUIViewController *)vc).reloadImage setHidden:YES];
               }
           }
           //解析response内容
           if([JSON isKindOfClass:[NSDictionary class]])
           {
               NSDictionary *resalut = (NSDictionary *)JSON;
               //返回数据正确 ，则解析到response
               if([[resalut objectForKey:RESPONSE_CODE] isEqualToString:RESPONSE_OK])
               {
                   [response parseResponse:resalut encryptionType:EncryptionType_NO signType:NO];
                   dispatch_async(dispatch_get_main_queue(), ^{
                       successBlock(response);
                   });
               }
               else
               {
                   ErrorInfoDto *errDic = [[ErrorInfoDto alloc]init];
                   [errDic loadDTO:resalut];
                   errDic.reqMethod = [request getrequestMethodString];
                   
                   dispatch_async(dispatch_get_main_queue(), ^{
                       failedBlock(errDic);
                   });
                   
               }
               
           }
           else
           {
               @throw [UnPackException exception:@"Json数据格式错误"];
           }

        } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
            [HttpCommunication dismissWaitingView:view];
            ErrorInfoDto *errDic = [[ErrorInfoDto alloc]init];
            errDic.resCode = @"404";
            errDic.resMsg = error.domain;
            errDic.reqMethod = [request getrequestMethodString];
            //网络连接处理，如果是网络连接3804错误，则做系统处理
            dispatch_async(dispatch_get_main_queue(), ^{
                failedBlock(errDic);
            });

        }];
    }
    else if([[request getrequestMethodString] isEqualToString:@"POST"])
    {
        NSMutableDictionary *dic=[request getJsonDict];

       NSData *data = [LFCGzipUtillity gzipData:[self dictToJSONData:dic]];
//    NSDictionary *dic = 
       return  [[AFNetWorkClient sharedClient] POST:path parameters:data success:^(NSURLSessionDataTask * __unused task, id JSON) {
           [HttpCommunication dismissWaitingView:view];
           //如果连接服务器成功，则隐藏reload界面
           if ([view isKindOfClass:[JuPlusUIView class]]) {
               [((JuPlusUIView *)view).reloadImage setHidden:YES];
           }else{
               UIViewController *vc = [view getSuperViewController];
               if ([vc isKindOfClass: [JuPlusUIViewController class]]) {
                   [((JuPlusUIViewController *)vc).reloadImage setHidden:YES];
               }
           }

           //解析response内容
           if([JSON isKindOfClass:[NSDictionary class]])
           {
               NSDictionary *resalut = (NSDictionary *)JSON;
               //返回数据正确 ，则解析到response
               if([[resalut objectForKey:RESPONSE_CODE] isEqualToString:RESPONSE_OK])
               {
                   
                   [response parseResponse:resalut encryptionType:EncryptionType_NO signType:NO];
                   dispatch_async(dispatch_get_main_queue(), ^{
                       successBlock(response);
                   });
               }
               else
               {
                   ErrorInfoDto *errDic = [[ErrorInfoDto alloc]init];
                   [errDic loadDTO:resalut];
                   errDic.reqMethod = [request getrequestMethodString];

                   dispatch_async(dispatch_get_main_queue(), ^{
                       failedBlock(errDic);
                   });

                   
               }
               
           }
           else
           {
               @throw [UnPackException exception:@"Json数据格式错误"];
           }
        } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
            [HttpCommunication dismissWaitingView:view];
            ErrorInfoDto *errDic = [[ErrorInfoDto alloc]init];
            errDic.resCode = @"404";
            errDic.resMsg = error.domain;
            errDic.reqMethod = [request getrequestMethodString];
            //网络连接处理，如果是网络连接3804错误，则做系统处理
            dispatch_async(dispatch_get_main_queue(), ^{
                failedBlock(errDic);
            });
        }];
        
    }
    else if([[request getrequestMethodString] isEqualToString:@"DELETE"])
    {
       return  [[AFNetWorkClient sharedClient] DELETE:path parameters:request.validParams  success:^(NSURLSessionDataTask * __unused task, id JSON) {
           [HttpCommunication dismissWaitingView:view];

           //解析response内容
           if([JSON isKindOfClass:[NSDictionary class]])
           {
               NSDictionary *resalut = (NSDictionary *)JSON;
               //返回数据正确 ，则解析到response
               if([[resalut objectForKey:RESPONSE_CODE] isEqualToString:RESPONSE_OK])
               {
                   [response parseResponse:resalut encryptionType:EncryptionType_NO signType:NO];
                   dispatch_async(dispatch_get_main_queue(), ^{
                       successBlock(response);
                   });
               }
               else
               {
                   ErrorInfoDto *errDic = [[ErrorInfoDto alloc]init];
                   [errDic loadDTO:resalut];
                   errDic.reqMethod = [request getrequestMethodString];

                   dispatch_async(dispatch_get_main_queue(), ^{
                       failedBlock(errDic);
                   });
                   
               }
               
           }
           else
           {
               @throw [UnPackException exception:@"Json数据格式错误"];
           }
           
        } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
            [HttpCommunication dismissWaitingView:view];

            //反馈错误信息（网络连接失败等信息）
            [self errorExp:error];
        }];
        
    }
    else if([[request getrequestMethodString] isEqualToString:@"PUT"])
    {
       return  [[AFNetWorkClient sharedClient] PUT:path parameters:request.validParams success:^(NSURLSessionDataTask * __unused task, id JSON) {
           [HttpCommunication dismissWaitingView:view];

           //解析response内容
           if([JSON isKindOfClass:[NSDictionary class]])
           {
               NSDictionary *resalut = (NSDictionary *)JSON;
               //返回数据正确 ，则解析到response
               if([[resalut objectForKey:RESPONSE_CODE] isEqualToString:RESPONSE_OK])
               {
                   [response parseResponse:resalut encryptionType:EncryptionType_NO signType:NO];
                   dispatch_async(dispatch_get_main_queue(), ^{
                       successBlock(response);
                   });
               }
               else
               {
                   ErrorInfoDto *errDic = [[ErrorInfoDto alloc]init];
                   [errDic loadDTO:resalut];
                   errDic.reqMethod = [request getrequestMethodString];
                   
                   dispatch_async(dispatch_get_main_queue(), ^{
                       failedBlock(errDic);
                   });
               }
               
           }
           else
           {
               @throw [UnPackException exception:@"Json数据格式错误"];
           }
        } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
            //反馈错误信息（网络连接失败等信息）
            [HttpCommunication dismissWaitingView:view];

            [self errorExp:error];
        }];
        
    }
    else
    {
        return nil;
    }
    
}
+ (NSData *)dictToJSONData:(NSDictionary *)dict{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}

+(void)errorExp:(NSError *)error
{
    NSLog(@"%@",error);
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络连接失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}
+ (UIView *)showWaitingView:(UIView *)view withTitle:(NSString *)string
{
    if(view == nil)
    {
        return nil;
    }
    JuPlusLoadingView *loading=[[JuPlusLoadingView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, view.width, view.height)];
    //loading.backgroundColor = Color_Black;
    [loading showActivityViewFrame:view.frame AndTag:view.tag];
    [view addSubview:loading];
    return view;
}

+ (void)dismissWaitingView:(UIView *)aView
{
    if(aView == nil)
    {
        return;
    }
    aView.userInteractionEnabled=YES;
    Class autoClass = [JuPlusLoadingView class];
    for(UIView *view in aView.subviews)
    {
        if ([view isKindOfClass:autoClass])
        {
            [UIView animateWithDuration:2.0 animations:^{
                view.alpha = 0;
            } completion:^(BOOL finished) {
                [(JuPlusLoadingView *)view hideActivityView];
                [view removeFromSuperview];
            }];
            
        }
    }
}
@end
