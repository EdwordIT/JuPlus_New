//
//  HomeFurnishingViewController.h
//  JuPlus
//
//  Created by 詹文豹 on 15/6/19.
//  Copyright (c) 2015年 居+. All rights reserved.
//选择完标签之后跳转到筛选首页

#import "JuPlusUIViewController.h"
#import "PackageCell.h"
#import "ClassifyView.h"
#import "JuPlusTabBarView.h"
#import "CollectionView.h"
#import "PersonCenterView.h"
@interface HomeFurnishingViewController : JuPlusUIViewController<TabBarViewDelegate>
@property (nonatomic,strong)UITableView *listTab;
//分类界面
@property (nonatomic,strong)ClassifyView *classifyV;
//个人中心界面
@property (nonatomic,strong)PersonCenterView *personCenterV;
//搭配界面
@property (nonatomic,strong)CollectionView *collectionV;
//底部标签栏
@property(nonatomic,strong)JuPlusTabBarView *tabBarV;
//分类信息控制，显示主界面隐藏其余
@property(nonatomic,strong)NSMutableArray *viewArray;

@property (nonatomic,strong)UIImageView *remindView;

@end
