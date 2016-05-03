//
//  JuPlusGlobalData.h
//  JuPlus
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 居+. All rights reserved.
//配置文件内容

#import <Foundation/Foundation.h>

@interface JuPlusGlobalData : NSObject

@property (nonatomic, strong) NSString  *locX;
@property (nonatomic, strong) NSString  *locY;
@property (nonatomic, strong) NSString  *cityCode;

AS_SINGLETON(JuPlusGlobalData);

+(NSDictionary *)getAppInfoDic;

@end
