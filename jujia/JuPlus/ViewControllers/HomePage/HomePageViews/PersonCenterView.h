//
//  PersonCenterView.h
//  JuPlus
//
//  Created by admin on 15/7/7.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusUIView.h"

@interface PersonCenterView : JuPlusUIView<UITableViewDataSource,UITableViewDelegate>
////个人信息展示
@property(nonatomic,strong)JuPlusUIView *topView;
//
@property(nonatomic,strong)UIButton *portrait;
//
@property(nonatomic,strong)JuPlusUILabel *nickLabel;
////存储作品数/买入/收藏
@property(nonatomic,strong)NSMutableArray *listArr;
//
@property (nonatomic,strong)UIButton *uploadBtn;
@property (nonatomic ,strong)UITableView *appointTable;

//是否是搭配师
@property (nonatomic, strong)NSString *designerFlag;

@end
