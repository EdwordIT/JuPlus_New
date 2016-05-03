//
//  MyFavourCell.h
//  JuPlus
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyFavourDTO.h"
@interface MyFavourCell : UITableViewCell
@property (nonatomic,strong)UIImageView *backImage;

@property (nonatomic,strong)UILabel *nameLabel;
-(void)fileData:(MyFavourDTO *)dto;
@end
