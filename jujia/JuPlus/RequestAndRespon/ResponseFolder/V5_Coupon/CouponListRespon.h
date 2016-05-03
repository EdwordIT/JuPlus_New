//
//  CouponListRespon.h
//  JuPlus
//
//  Created by admin on 15/10/20.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "JuPlusResponse.h"
#import "CouponItem.h"
@interface CouponListRespon : JuPlusResponse

@property (nonatomic,strong)NSMutableArray *listArray;

@property (nonatomic,assign)NSInteger count;
@end
