//
//  PostOrderRespon.h
//  JuPlus
//
//  Created by admin on 15/7/6.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusResponse.h"
#import "AlipayDTO.h"
@interface PostOrderRespon : JuPlusResponse
@property(nonatomic,strong)NSString *orderNo;
//总价
@property(nonatomic,strong)NSString *totalAmt;

@property (nonatomic,strong)NSString *realAmt;
@property(nonatomic,strong)AlipayDTO *alipay;
@end
