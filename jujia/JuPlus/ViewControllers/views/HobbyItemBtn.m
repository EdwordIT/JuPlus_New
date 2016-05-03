//
//  HobbyItemBtn.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/18.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "HobbyItemBtn.h"
#import "UIImage+GIF.h"
#import "SCGIFImageView.h"
@implementation HobbyItemBtn
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.userInteractionEnabled = YES;
        [self addSubview:self.iconBtn];
       // [self addSubview:self.selectedImage];
    }
    return self;
}
-(UIButton *)iconBtn
{
    if(!_iconBtn)
    {
        _iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_iconBtn setTitleColor:Color_Basic forState:UIControlStateNormal];
        _iconBtn.frame = CGRectMake(0.0f, 0.0f, self.width, self.height);
    }
    return _iconBtn;
}
-(UIImageView *)selectedImage
{
    if(!_selectedImage)
    {
       // _selectedImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.width - 16.0f, (self.height - 16.0f)/2, 16.0f, 16.0f)];
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"checkmark.gif" ofType:nil];
        _selectedImage = [[SCGIFImageView alloc]initWithGIFFile:filePath withSeconds:0.5];
        _selectedImage.frame = CGRectMake(self.width - 16.0f, (self.height - 16.0f)/2, 16.0f, 16.0f);
    }
    return _selectedImage;
    
}

@end
