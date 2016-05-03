//
//  GetVersionRespon.h
//  JuPlus
//
//  Created by admin on 15/10/14.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "JuPlusResponse.h"

@interface GetVersionRespon : JuPlusResponse
//版本id
@property (nonatomic,strong)NSString *idString;
//平台
@property (nonatomic,strong)NSString *plateform;
//内部版本号
@property (nonatomic,strong)NSString *internalNo;
//外部版本号
@property (nonatomic,strong)NSString *externalNo;
//下载链接
@property (nonatomic,strong)NSString *downLink;
//是否强制更新
@property (nonatomic,strong)NSString *forceUpdate;
//版本信息
@property (nonatomic,strong)NSString *versionInfo;
//更新日期
@property (nonatomic,strong)NSString *updateTime;

@end
