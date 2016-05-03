//
//  CollocationClassifyView.h
//  JuPlus
//
//  Created by admin on 15/8/19.
//  Copyright (c) 2015年 居+. All rights reserved.
// 创建上传过程中的分类信息选择

#import "JuPlusUIView.h"
#import "ClassifyTagsDTO.h"
@protocol CollocationClassifyViewDelegate <NSObject>

-(void)reloadInfo:(ClassifyTagsDTO *)info;

@end


@interface CollocationClassifyView :JuPlusUIView <UIScrollViewDelegate>

@property (nonatomic,strong)UILabel *titleL;
//可扩展的类容分布
@property (nonatomic,strong)UIScrollView *itemsScroll;
//数据源
@property (nonatomic,strong)NSMutableArray *dataArray;
//底层确定按钮
@property (nonatomic,strong)UIButton *sureBtn;

@property (nonatomic,assign)id<CollocationClassifyViewDelegate>delegate;

@property (nonatomic,strong)ClassifyTagsDTO *infoDTO;
-(id)initWithFrame:(CGRect)frame andSuperView:(UIView *)v;

-(void)showClassify;

@end
