//
//  MyEffectCell.h
//  JuPlus
//
//  Created by ios_admin on 15/9/2.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyappointDTO.h"
@interface MyEffectCell : UITableViewCell

//预约
@property (nonatomic, strong)UIButton *designerBut;
//是否成功
@property (nonatomic, strong)UILabel *appLabel;
//背景图
@property (nonatomic, strong)UIImageView *effectImage;
- (void)fileData:(MyappointDTO *)dto;
@end
