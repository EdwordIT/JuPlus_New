//
//  OrderListViewController.h
//  JuPlus
//
//  Created by admin on 15/7/8.
//  Copyright (c) 2015年 居+. All rights reserved.
//订单列表

#import "JuPlusUIViewController.h"

@interface OrderListViewController : JuPlusUIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *orderListTab;

@property (nonatomic,strong)NSMutableArray *dataArray;
@end
