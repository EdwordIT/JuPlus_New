//
//  AddressCell.h
//  JuPlus
//
//  Created by admin on 15/7/13.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressDTO.h"
@interface AddressCell : UITableViewCell
@property(nonatomic,strong)JuPlusUIView *topView;
//收件人
@property(nonatomic,strong)JuPlusUILabel *nameL;
//联系方式
@property(nonatomic,strong)JuPlusUILabel *mobileL;
//地址
@property(nonatomic,strong)JuPlusUILabel *addressL;
//设为默认
@property(nonatomic,strong)UIButton *setDetaultBtn;
//
@property(nonatomic,strong)JuPlusUIView *botView;

@property(nonatomic,strong)UIButton *editBtn;

@property(nonatomic,strong)UIView *editingV;
-(void)loadCellWithDTO:(AddressDTO *)dto;
@end
