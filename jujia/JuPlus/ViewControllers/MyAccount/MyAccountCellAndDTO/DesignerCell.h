//
//  DesignerCell.h
//  JuPlus
//
//  Created by ios_admin on 15/8/25.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesignerDTO.h"
@interface DesignerCell : UITableViewCell

@property (nonatomic, strong)UIImageView *coverUrlImage;
@property (nonatomic, strong)UILabel * simpleLabel;
@property (nonatomic, strong)UILabel *totalPriceLabel;
@property (nonatomic,strong)UIButton *appointmentBtn;
- (void)fileData:(DesignerDTO *)dto;
@end
