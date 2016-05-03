//
//  LabelView.m
//  JuPlus
//
//  Created by admin on 15/7/6.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "LabelView.h"
#import "SingleDetialViewController.h"
#import "UINavigationController+RadialTransaction.h"
#import "CollectionView.h"
#define space 5.0f
@implementation LabelView
{
    CGPoint tipsCenter ;
    CGPoint alphaCenter ;
    //先缩小后放大
    CGRect nextFrame1 ;
    CGRect nextFrame2 ;
    CGRect orignFrame ;
    
    CGRect alpha1  ;
    CGRect orignAlpha ;
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
        CGFloat tipsW = self.tipsImage.width;
        //背景view的转变
        CGFloat scale = 4.0f;
        CGFloat changeSpace = tipsW*(scale - 1);
        
        CGFloat scale1 = 0.8f;
        CGFloat scale2 = 1.2f;
        CGFloat changeSpace1 = tipsW*(1.0f - scale1);
        CGFloat changeSpace2 = tipsW*(scale2 - 1.0f);
        
        tipsCenter = self.tipsImage.center;
        alphaCenter = self.alphaImage.center;
        //先缩小后放大
        nextFrame1 = CGRectMake(self.tipsImage.left + changeSpace1, self.tipsImage.top + changeSpace1, tipsW*scale1, tipsW*scale1);
        nextFrame2 = CGRectMake(self.tipsImage.left - changeSpace2, self.tipsImage.top - changeSpace2, tipsW*scale2, tipsW*scale2);
        orignFrame = self.tipsImage.frame;
        
        alpha1 = CGRectMake(self.alphaImage.left - changeSpace, self.alphaImage.top-changeSpace, tipsW*scale, tipsW*scale);
        orignAlpha = self.alphaImage.frame;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(setAnimation) userInfo:nil repeats:YES];    //使用timer定时，每3秒触发一次，然后就是写selector了。
        [self setAnimation];

    }
    return self;

}
-(void)setAnimation
{
    
    [UIView animateKeyframesWithDuration:0.3f delay:0 options:0 animations:^{
        self.tipsImage.frame = nextFrame1;
        self.tipsImage.center = tipsCenter;
    } completion:^(BOOL finished) {
        // NSLog(@"1");
    }];
    [UIView animateKeyframesWithDuration:0.3f delay:0.3 options:0 animations:^{
        self.tipsImage.frame = nextFrame2;
        self.tipsImage.center = tipsCenter;
    } completion:^(BOOL finished) {
        // NSLog(@"2");
    }];
    [UIView animateKeyframesWithDuration:0.3f delay:0.6 options:0 animations:^{
        self.tipsImage.frame = orignFrame;
        self.tipsImage.center = tipsCenter;
    } completion:^(BOOL finished) {
        //  NSLog(@"3");
        
    }];
    [UIView animateKeyframesWithDuration:0.5f delay:1.0f options:0 animations:^{
        self.alphaImage.frame = alpha1;
        self.alphaImage.alpha = 0;
        self.alphaImage.center = alphaCenter;

    } completion:^(BOOL finished) {
        self.alphaImage.frame = orignAlpha;
        self.alphaImage.alpha = 1;
        self.alphaImage.center = alphaCenter;
        [UIView animateKeyframesWithDuration:0.5f delay:0 options:0 animations:^{
            self.alphaImage.frame = alpha1;
            self.alphaImage.alpha = 0;
            self.alphaImage.center = alphaCenter;

        } completion:^(BOOL finished) {
            self.alphaImage.frame = orignAlpha;
            self.alphaImage.alpha = 1;
            self.alphaImage.center = alphaCenter;
            //  NSLog(@"5");
            
        }];
    }];
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
            _alphaImage.alpha = 0;
        [_alphaImage setImage:[UIImage imageNamed:@"alpha_back"]];
       
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
        [_labelText setFont:FontType(FontMinSize)];
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
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.window];
    UIViewController *vc = [self getSuperViewController];
    
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, vc.view.width, vc.view.height)];
    backV.alpha = 0.99;
    backV.backgroundColor = RGBACOLOR(255, 255, 255, 0.6);
    [vc.view addSubview:backV];
    [UIView animateWithDuration:1.0f animations:^{
        backV.alpha = 1;
    } completion:^(BOOL finished) {
        [backV removeFromSuperview];
    }];

    CGPoint startPoint = CGPointMake(point.x -25.0f,point.y - 25.0f);
    SingleDetialViewController *sing = [[SingleDetialViewController alloc]init];
    sing.regNo =[NSString stringWithFormat:@"%ld", (long)self.superview.tag];
    sing.isfromPackage = YES;
    sing.singleId = [NSString stringWithFormat:@"%ld",(long)self.tag];
    sing.point = startPoint;
    [vc.navigationController radialPushViewController:sing withDuration:1.0f withStartFrame:CGRectMake(startPoint.x,startPoint.y,50.0f,50.0f) comlititionBlock:^{
        
    }];
    

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

@end
