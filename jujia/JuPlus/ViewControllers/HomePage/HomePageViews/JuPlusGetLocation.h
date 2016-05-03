//
//  JuPlusGetLocation.h
//  JuPlus
//
//  Created by admin on 15/8/25.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

@interface JuPlusGetLocation : NSObject
AS_SINGLETON(JuPlusGetLocation);
//经纬度
@property(nonatomic,assign)CGFloat locLong;
@property(nonatomic,assign)CGFloat locLat;
@property(nonatomic,strong)NSString *cityName;
-(void)getLocation;
//地理位置反编码
-(void)getcityName;
@end
