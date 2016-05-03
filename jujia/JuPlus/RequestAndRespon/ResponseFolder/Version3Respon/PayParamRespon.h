//
//  PayParamRespon.h
//  JuPlus
//
//  Created by admin on 15/9/24.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "JuPlusResponse.h"
#import "AlipayDTO.h"
@interface PayParamRespon : JuPlusResponse
@property(nonatomic,strong)NSString *orderNo;
//总价
@property(nonatomic,strong)NSString *totalAmt;

@property(nonatomic,strong)AlipayDTO *alipay;

@end
