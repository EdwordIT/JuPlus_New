//
//  FavCell.h
//  JuPlus
//
//  Created by ios_admin on 15/8/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavDTO.h"
@interface FavCell : UITableViewCell

@property (nonatomic, strong)UIImageView *headImage;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *datalabel;
-(void)fileData:(FavDTO *)dto;
- (void)drawRect:(CGRect)rect;
@end
