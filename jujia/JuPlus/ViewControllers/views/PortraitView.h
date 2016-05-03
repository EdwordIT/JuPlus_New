//
//  portraitView.h
//  JuPlus
//
//  Created by 詹文豹 on 15/6/23.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusUIView.h"
#import "UIImageView+JuPlusUIImageView.h"
@interface PortraitView : JuPlusUIView
//头像
@property(nonatomic,strong)UIButton *portraitImgV;
//昵称
@property(nonatomic,strong)UILabel *nikeNameL;
-(id)initWithFrame:(CGRect)frame;
@end
