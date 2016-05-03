//
//  CouponCell.h
//  JuPlus
//
//  Created by admin on 15/10/19.
//  Copyright © 2015年 居+. All rights reserved.
//优惠券

#import <UIKit/UIKit.h>
#import "CouponItem.h"
#import "RTLabel.h"
@interface CouponCell : UITableViewCell
//背景图
@property (nonatomic,strong)UIImageView *backImg;
//虚线
@property (nonatomic,strong)UIImageView *lineImg;
//优惠券选择页面需要显示
@property (nonatomic,strong)UIButton *selectBtn;
//价格
@property (nonatomic,strong)JuPlusUILabel *priceLabel;
//优惠券名称
@property (nonatomic,strong)JuPlusUILabel *nameLabel;
//优惠券描述
@property (nonatomic,strong)RTLabel *descriptionLabel;
//有效期
@property (nonatomic,strong)JuPlusUILabel *expiryDateLabel;
-(void)fileCell:(CouponItem *)item;
@end
