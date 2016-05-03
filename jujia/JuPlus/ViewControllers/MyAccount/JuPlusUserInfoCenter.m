//
//  JuPlusUserInfoCenter.m
//  JuPlus
//
//  Created by admin on 15/7/20.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusUserInfoCenter.h"

@implementation JuPlusUserInfoCenter

DEF_SINGLETON( JuPlusUserInfoCenter);


- (void)loadUserInfo:(LoginRespon *)respon
{
        _userInfo.token = respon.token;
        _userInfo.nickname = respon.nickname;
        _userInfo.portraitUrl = respon.portraitPath;
        _userInfo.regNo = respon.regNo;
}

- (void)resetUserInfo
{
    [self logout];
    self.userInfo = nil;
}

-(UserInfoDTO *)userInfo
{
    if (!_userInfo) {
        _userInfo = [[UserInfoDTO alloc] init];
        _userInfo.token = [CommonUtil getToken];
        _userInfo.nickname = [CommonUtil getUserDefaultsValueWithKey:@"nickname"];
        _userInfo.portraitUrl = [CommonUtil getUserDefaultsValueWithKey:@"portraitUrl"];
        _userInfo.regNo = [CommonUtil getUserDefaultsValueWithKey:@"regNo"];
    }
    return _userInfo;
}
-(void)logout
{
    [CommonUtil removeUserDefaultsValue:TOKEN];
    [CommonUtil removeUserDefaultsValue:@"nickname"];
    [CommonUtil removeUserDefaultsValue:@"portraitUrl"];
    [CommonUtil removeUserDefaultsValue:@"mobile"];
    [CommonUtil removeUserDefaultsValue:@"regNo"];
}
@end
