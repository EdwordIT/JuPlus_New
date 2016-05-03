//
//  PriceView.h
//  JuPlus
//
//  Created by 詹文豹 on 15/6/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusUIView.h"

@interface PriceView : JuPlusUIView
//价格标签的背景图层
@property(nonatomic,strong)UIImageView *backImage;
//显示内容
@property(nonatomic,strong)UILabel *textLabel;
-(void)setPriceText:(NSString *)price;
@end
