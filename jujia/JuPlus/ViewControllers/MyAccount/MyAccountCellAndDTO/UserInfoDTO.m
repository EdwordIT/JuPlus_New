//
//  UserInfoDTO.m
//  JuPlus
//
//  Created by admin on 15/7/20.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "UserInfoDTO.h"

@implementation UserInfoDTO
-(void)setToken:(NSString *)token
{
    _token = token;
    [CommonUtil setUserDefaultsValue:token forKey:TOKEN];
}

-(void)setNickname:(NSString *)nickname
{
    _nickname = nickname;
    [CommonUtil setUserDefaultsValue:nickname forKey:@"nickname"];
}
-(void)setPortraitUrl:(NSString *)portraitUrl
{
    _portraitUrl = portraitUrl;
    [CommonUtil setUserDefaultsValue:portraitUrl forKey:@"portraitUrl"];
}
-(void)setMobile:(NSString *)mobile
{
    _mobile = mobile;
    [CommonUtil setUserDefaultsValue:mobile forKey:@"mobile"];
}
-(void)setRegNo:(NSString *)regNo
{
    _regNo = regNo;
    [CommonUtil setUserDefaultsValue:regNo forKey:@"regNo"];
}
@end
