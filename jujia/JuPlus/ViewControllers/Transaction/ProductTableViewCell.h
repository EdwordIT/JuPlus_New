//
//  ProductTableViewCell.h
//  JuPlus
//
//  Created by admin on 15/10/23.
//  Copyright © 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountView.h"
#import "productOrderDTO.h"
@interface ProductTableViewCell : UITableViewCell
//图标
@property(nonatomic,strong)UIImageView *iconImgV;
//标题
@property(nonatomic,strong)JuPlusUILabel *titleL;
//价格
@property(nonatomic,strong)JuPlusUILabel *priceL;
//增删器
@property(nonatomic,strong)CountView *countV;

-(void)fileCell:(productOrderDTO *)dto;

@end
