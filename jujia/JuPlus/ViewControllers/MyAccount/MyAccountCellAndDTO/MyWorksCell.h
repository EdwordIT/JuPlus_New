//
//  MyWorksCell.h
//  JuPlus
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyWorksDTO.h"

@interface MyWorksCell : UITableViewCell
//时间
@property (nonatomic,strong)UILabel *dateLabel;
//套餐背景
@property (nonatomic,strong)UIImageView *backImage;
//审核状态
@property (nonatomic,strong)UILabel *nameLabel;
//底部介绍
@property (nonatomic,strong)JuPlusUIView *bottomView;
//被赞次数
@property (nonatomic,strong)UIButton *favBtn;
//购买次数
@property (nonatomic,strong)UIButton *payBtn;
//删除按钮
@property (nonatomic,strong)UIButton *deleteBtn;

@property (nonatomic,strong)UIView *back;
-(void)fileData:(MyWorksDTO *)dto;
@end
