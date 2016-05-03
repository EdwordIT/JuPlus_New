//
//  OrderListCell.h
//  JuPlus
//
//  Created by admin on 15/7/8.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListDTO.h"
@interface OrderListCell : UITableViewCell
//订单号
@property (nonatomic,strong)JuPlusUILabel *orderNoL;
//时间
@property (nonatomic,strong)JuPlusUILabel *timeL;
//单品列表
@property (nonatomic,strong)UIScrollView *productScroll;
//加载更多
@property (nonatomic,strong)UIButton *moreBtn;

@property (nonatomic,strong)JuPlusUIView *countView;
//商品总数
@property (nonatomic,strong)JuPlusUILabel *totalCountL;
//实付金额
@property (nonatomic,strong)JuPlusUILabel *totalPayL;
//添加
@property (nonatomic,strong)JuPlusUIView *bomAddV;
//是否显示全部内容
@property (nonatomic,assign)BOOL isShowAll;
//发货状态
@property (nonatomic,strong)JuPlusUILabel *typeLabel;
-(void)fileCell:(OrderListDTO *)listDto;
@end
