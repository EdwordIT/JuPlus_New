//
//  MarkLabeiView.m
//  JuPlus
//
//  Created by admin on 15/8/4.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "MarkLabeiView.h"

@implementation MarkLabeiView
{
    CGPoint tipsCenter ;
    CGPoint alphaCenter ;
    //先缩小后放大
    CGRect nextFrame1 ;
    CGRect nextFrame2 ;
    CGRect orignFrame ;
    
    CGRect alpha1  ;
    CGRect orignAlpha ;
    
    CGPoint beginPoint;
}
-(id)initWithFrame:(CGRect)frame andDirect:(NSString *)dir
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        if ([dir intValue]==1) {
            self.isLeft = YES;
        }
        else
            self.isLeft = NO;
        [self addSubview:self.dropImg];
        [self addSubview:self.alphaImage];
        [self addSubview:self.tipsImage];
        [self addSubview:self.lineImg];
        [self addSubview:self.labelText];
        self.userInteractionEnabled = YES;
        
    }
    return self;
    
}
-(UIImageView *)tipsImage
{
    if(!_tipsImage)
    {
        CGFloat tipRact = 5.0f;
        _tipsImage = [[UIImageView alloc]init];
        if(self.isLeft)
            _tipsImage.frame = CGRectMake(0.0f, self.height - tipRact, tipRact, tipRact);
        else
            _tipsImage.frame = CGRectMake(self.width - tipRact, self.height - tipRact, tipRact, tipRact);
        
        _tipsImage.layer.cornerRadius = tipRact/2;
        _tipsImage.layer.masksToBounds = YES;
        [_tipsImage setImage:[UIImage imageNamed:@"point"]];
    }
    return _tipsImage;
}
-(UIImageView *)alphaImage
{
    if(!_alphaImage)
    {
        CGFloat tipRact = 5.0f;
        _alphaImage = [[UIImageView alloc]init];
        if(self.isLeft)
            _alphaImage.frame = CGRectMake(0.0f, self.height - tipRact, tipRact, tipRact);
        else
            _alphaImage.frame = CGRectMake(self.width - tipRact, self.height - tipRact, tipRact, tipRact);
        
        
        _alphaImage.layer.cornerRadius = tipRact/2;
        _alphaImage.layer.masksToBounds = YES;
        _alphaImage.alpha = 0;
        [_alphaImage setImage:[UIImage imageWithColor:[UIColor blackColor]]];
    }
    return _alphaImage;
}
-(void)layoutSubviews
{
    self.tipsImage.layer.masksToBounds = YES;
    self.tipsImage.layer.cornerRadius = self.tipsImage.width/2;
    self.alphaImage.layer.masksToBounds = YES;
    self.alphaImage.layer.cornerRadius = self.alphaImage.width/2;
    
}
#pragma mark --UIfixed
-(UIImageView *)dropImg
{
    if(!_dropImg)
    {
        _dropImg = [[UIImageView alloc]init];
        if(self.isLeft)
        {
            _dropImg.frame = CGRectMake(2.5, self.height - 15.5f, 8.0f, 13.0f);
            [_dropImg setImage:[UIImage imageNamed:@"lineRight"]];
            
        }
        else
        {
            _dropImg.frame = CGRectMake(self.width - 10.5f, self.height - 15.5f, 8.0f, 13.0f);
            [_dropImg setImage:[UIImage imageNamed:@"lineLeft"]];
        }
        
    }
    return _dropImg;
}
-(UILabel *)labelText
{
    if(!_labelText)
    {
        _labelText = [[UILabel alloc]init];
        _labelText.textAlignment = NSTextAlignmentRight;
        
        if(self.isLeft)
            _labelText.frame = CGRectMake(self.dropImg.right - 50.0f,self.dropImg.top - 20.0f,1.0f,20.0f);
        else
        {
            _labelText.frame = CGRectMake(self.dropImg.left,self.dropImg.top - 20.0f,1.0f,20.0f);
        }
        [_labelText setFont:[UIFont boldSystemFontOfSize:14.0f]];
        
        [_labelText setFont:FontType(FontMaxSize)];
        [_labelText setTextColor:[UIColor whiteColor]];
        [_labelText setShadowColor:Color_Gray];
        [_labelText setShadowOffset:CGSizeMake(0, 1)];
    }
    return _labelText;
}
-(UIImageView *)lineImg
{
    if(!_lineImg)
    {
        _lineImg = [[UIImageView alloc]init ];
        if(self.isLeft)
            _lineImg.frame = CGRectMake(self.dropImg.right, self.dropImg.top - 0.0f, 1.0f, 1.0f);
        else
            _lineImg.frame = CGRectMake(self.dropImg.left -1.0f, self.dropImg.top - 0.0f, 1.0f, 1.0f);
        [_lineImg setImage:[UIImage imageNamed:@"lineLabel"]];
    }
    return _lineImg;
}
-(UIButton *)touchBtn
{
    if(!_touchBtn)
    {
        _touchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _touchBtn.backgroundColor = [UIColor clearColor];
        _touchBtn.frame = CGRectMake(0.0f,0.0f,self.width,self.height);
    }
    return _touchBtn;
}
//开始移动
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    beginPoint = [touch locationInView:self];
    [super touchesBegan:touches withEvent:event];
}
//移动中frame变化
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self];
    CGRect frame = self.frame;
    CGFloat orignX = frame.origin.x+ currentLocation.x - beginPoint.x;
    CGFloat orignY = frame.origin.y+ currentLocation.y - beginPoint.y;
    orignX = MAX(0, orignX);
    orignX = MIN(orignX, SCREEN_WIDTH - self.width);
    
    orignY = MAX(0, orignY);
    orignY = MIN(PICTURE_HEIGHT - 50.0f, orignY);

    frame.origin.x = orignX;
    frame.origin.y = orignY;
    self.frame = frame;
}
//移动结束
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self reloadDTO];
}
-(void)showText:(NSString *)text
{
    [self.labelText setText:text];
    [UIView animateWithDuration:1.0f animations:^{
        
        CGSize  size = [CommonUtil getLabelSizeWithString:text andLabelHeight:20.0f andFont:self.labelText.font];
        if(self.isLeft)
        {
            [self.lineImg setFrame:CGRectMake(self.lineImg.left, self.lineImg.top, size.width, self.lineImg.height)];
            self.labelText.frame = CGRectMake(self.lineImg.right - size.width,self.dropImg.top - 20.0f,size.width,self.labelText.height);
        }
        else
        {
            [self.labelText setFrame:CGRectMake(self.dropImg.left - size.width, self.labelText.top, size.width, self.labelText.height)];
            [self.lineImg setFrame:CGRectMake(self.lineImg.right - size.width, self.lineImg.top, size.width, self.lineImg.height)];
            
        }
        
    }];
}
-(void)reloadDTO
{
    //记录标签内容，指示点的位置
    if(self.isLeft)
    {
        self.infoDTO.direction = @"1";
        self.infoDTO.locX = self.left;
    }
    else
    {
        self.infoDTO.locX = self.right;
        self.infoDTO.direction = @"2";
    }
    self.infoDTO.locY = self.bottom;

}
//切换朝向
-(void)setDirectionWithDire
{
    CGFloat tipRact = 5.0f;
    //如果是正常靠左撒点，切换成向右
    if (self.isLeft) {
        self.isLeft = NO;
        self.frame = CGRectMake(self.left - self.width, self.top, self.width, 50.0f);
        _tipsImage.frame = CGRectMake(self.width - tipRact, self.height - tipRact, tipRact, tipRact);
        _alphaImage.frame = CGRectMake(self.width - tipRact, self.height - tipRact, tipRact, tipRact);
        _dropImg.frame = CGRectMake(self.width - 10.5f, self.height - 15.5f, 8.0f, 13.0f);
        [_dropImg setImage:[UIImage imageNamed:@"lineLeft"]];
        
        [self.labelText setFrame:CGRectMake(self.dropImg.left - self.labelText.width, self.labelText.top, self.labelText.width, self.labelText.height)];
        [self.lineImg setFrame:CGRectMake(self.labelText.left, self.lineImg.top, self.lineImg.width, self.lineImg.height)];
    }
    else
    {
        self.isLeft = YES;
        self.frame = CGRectMake(self.left + self.width, self.top, self.width, 50.0f);
        
        _tipsImage.frame = CGRectMake(0.0f, self.height - tipRact, tipRact, tipRact);
        _alphaImage.frame = CGRectMake(0.0f, self.height - tipRact, tipRact, tipRact);
        _dropImg.frame = CGRectMake(2.5f, self.height - 15.5f, 8.0f, 13.0f);
        [_dropImg setImage:[UIImage imageNamed:@"lineRight"]];
        [self.lineImg setFrame:CGRectMake(10.5f, self.lineImg.top, self.lineImg.width, self.lineImg.height)];
        self.labelText.frame = CGRectMake(self.lineImg.left,self.dropImg.top - 20.0f,self.labelText.width,self.labelText.height);
    }
    [self reloadDTO];
}

@end
