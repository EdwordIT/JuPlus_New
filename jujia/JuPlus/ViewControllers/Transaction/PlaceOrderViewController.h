//
//  PlaceOrderViewController.h
//  JuPlus
//
//  Created by admin on 15/6/29.
//  Copyright (c) 2015年 居+. All rights reserved.
//(套餐下单或者单品下单)

#import "JuPlusUIViewController.h"
//下单界面
@interface PlaceOrderViewController : JuPlusUIViewController
//
@property(nonatomic,strong)NSArray *regArray;
//是单品还是套餐
@property(nonatomic,assign)BOOL isSingle;
@end
