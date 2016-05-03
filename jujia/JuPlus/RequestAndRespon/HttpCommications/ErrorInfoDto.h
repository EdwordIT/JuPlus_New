//
//  ErrorInfoDto.h
//  JuPlus
//
//  Created by admin on 15/7/27.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "BaseDTO.h"

@interface ErrorInfoDto : BaseDTO
@property (nonatomic,strong)NSString *resCode;
@property (nonatomic,strong)NSString *resMsg;
@property (nonatomic,strong)NSString *reqMethod;
@property (nonatomic,strong)NSString *downloadUrl;
@end
