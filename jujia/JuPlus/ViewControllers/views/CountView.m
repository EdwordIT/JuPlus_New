//
//  CountView.m
//  JuPlus
//
//  Created by admin on 15/7/3.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "CountView.h"

@implementation CountView
{
    CGFloat height;
    int countNum;
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        height = self.height;
        [self addSubview:self.backImg];
        [self addSubview:self.subtractBtn];
        [self addSubview:self.addBtn];
        [self addSubview:self.countL];
        
    }
    return self;
}
-(void)setCountNum:(int)count
{
    countNum = count;
    self.countL.text = [NSString stringWithFormat:@"%d",countNum];
}
//减法
-(void)subtractBtnClick:(UIButton *)sender
{
    if(countNum<=1)
    {
        countNum = 1;
    }
    else
    {
        countNum -= 1;
        self.countL.text = [NSString stringWithFormat:@"%d",countNum];
        [[NSNotificationCenter defaultCenter] postNotificationName:ResetPrice object:nil];
    }
}
//加法
-(void)addBtnClick:(UIButton *)sender
{
    if(countNum==10)
    {
       
    }
    else
    {
        countNum += 1;
        self.countL.text = [NSString stringWithFormat:@"%d",countNum];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"resetPrice" object:nil];
    }
}
#pragma mark --UI
-(UIImageView *)backImg
{
    if(!_backImg)
    {
        _backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.width, self.height)];
        [_backImg setImage:[UIImage imageNamed:@"countNum"]];
    }
    return _backImg;
}
-(UIButton *)subtractBtn
{
    if(!_subtractBtn)
    {
        _subtractBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _subtractBtn.frame = CGRectMake(0.0f, 0.0f, height, height);
        [_subtractBtn addTarget:self action:@selector(subtractBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subtractBtn;
}
-(UIButton *)addBtn
{
    if(!_addBtn)
    {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake(self.width - height, 0.0f, height, height);
        [_addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _addBtn;
}
-(UILabel *)countL
{
    if(!_countL)
    {
        _countL = [[UILabel alloc]initWithFrame:CGRectMake(height, 0.0f,self.width - height*2, height)];
        [_countL setFont:FontType(FontSize)];
        _countL.textAlignment = NSTextAlignmentCenter;
        _countL.text =[NSString getStringValue:countNum];
        [_countL setTextColor:Color_Gray];
    }
    return _countL;
}
//得到运算之后的数值
-(int)getCountNum
{
    
    return [self.countL.text intValue];
}
@end
