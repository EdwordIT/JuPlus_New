//
//  HobbyItemBtn.h
//  JuPlus
//
//  Created by 詹文豹 on 15/6/18.
//  Copyright (c) 2015年 居+. All rights reserved.
//兴趣自定义view

#import "JuPlusUIView.h"
#import "SCGIFImageView.h"
@interface HobbyItemBtn : JuPlusUIView
@property(nonatomic,strong)UIButton *iconBtn;
//打钩按钮
@property(nonatomic,strong)SCGIFImageView *selectedImage;
-(id)initWithFrame:(CGRect)frame;
@end
