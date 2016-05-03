//
//  MyAppointCell.h
//  JuPlus
//
//  Created by ios_admin on 15/9/1.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyappointDTO.h"
@interface MyAppointCell : UITableViewCell
//预约
@property (nonatomic, strong)UIButton *typeBut;
//是否成功
@property (nonatomic, strong)UILabel *status;
//背景图
@property (nonatomic, strong)UIImageView *effectImage;
//图像
@property (nonatomic, strong)UIImageView *imgUrl;
- (void)fileData:(MyappointDTO *)dto;
@end
