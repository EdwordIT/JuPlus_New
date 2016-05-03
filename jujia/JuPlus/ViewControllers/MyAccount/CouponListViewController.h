//
//  CouponListViewController.h
//  JuPlus
//
//  Created by admin on 15/10/19.
//  Copyright © 2015年 居+. All rights reserved.
//优惠券列表

#import "JuPlusUIViewController.h"
#import "CouponCell.h"
//用于选择优惠券界面使用
typedef void(^ReturnCouponBlock)(CouponItem *item);

@interface CouponListViewController : JuPlusUIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *listTab;

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)NSArray *listArray;

@property (nonatomic,assign)BOOL isFromOrder;

@property (nonatomic,strong)NSString *selectedId;

@property (nonatomic,strong)ReturnCouponBlock couponBlock;

-(void)returnCoupon:(ReturnCouponBlock)block;
@end
