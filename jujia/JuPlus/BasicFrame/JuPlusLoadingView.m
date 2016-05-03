//
//  AutoyolProgressView.m
//  progress
//
//  Created by 詹文豹 on 14-4-23.
//  Copyright (c) 2014年 詹文豹. All rights reserved.
//

#import "JuPlusLoadingView.h"
#import <QuartzCore/QuartzCore.h>
#import "SCGIFImageView.h"
#import "UIImage+GIF.h"
@implementation JuPlusLoadingView
{
    CGFloat viewHeight;
    UIImageView *redBack;
    SCGIFImageView* gifImageView;
    UIImageView *imageView;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self uifig];
        self.userInteractionEnabled = NO;
        
    }
    return self;
}

-(void)showActivityViewFrame:(CGRect)frame AndTag:(int)vieTag
{

    redBack.frame = CGRectMake((frame.size.width-redBack.width)/2, (frame.size.height-redBack.height)/2, redBack.width, redBack.height);
    imageView.frame = redBack.frame;
    [imageView startAnimating];
    [self setHidden:NO];

}
-(void)uifig
{

    CGFloat imgSize = 50.0f;
    redBack = [[UIImageView alloc]initWithFrame:CGRectMake((self.width - imgSize)/2, (self.height - imgSize)/2, imgSize, imgSize)];
    redBack.layer.masksToBounds =  YES;
    redBack.layer.cornerRadius = imgSize/2;
    //redBack.backgroundColor = RGBCOLOR(242, 114, 128);
    //redBack.alpha = 0.7;
    [self addSubview:redBack];
    
//    gif = [[UIImageView alloc]initWithFrame:redBack.frame];
//    [gif setImage:[UIImage sd_animatedGIFNamed:@"loading"]];
//    [self addSubview:gif];
   // 开始显示Loading动画
//    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"loading.gif" ofType:nil];
//     gifImageView = [[SCGIFImageView alloc] initWithGIFFile:filePath withSeconds:1.5];
//    gifImageView.frame = CGRectMake((self.width - imgSize)/2, (self.height - imgSize)/2, imgSize, imgSize);
//    gifImageView.tag = Progress_tag;
//    [self addSubview:gifImageView];
//    [self setHidden:YES];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"1.png"],[UIImage imageNamed:@"2.png"],[UIImage imageNamed:@"3.png"],[UIImage imageNamed:@"4.png"],[UIImage imageNamed:@"5.png"],[UIImage imageNamed:@"6.png"],[UIImage imageNamed:@"7.png"],[UIImage imageNamed:@"8.png"],[UIImage imageNamed:@"9.png"],[UIImage imageNamed:@"10.png"],[UIImage imageNamed:@"11.png"], nil ,nil];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - imgSize)/2, (self.height - imgSize)/2, imgSize, imgSize)];
    
    imageView.animationImages = array; //动画图片数组
    imageView.animationDuration = 1.0; //执行一次完整动画所需的时长
    imageView.animationRepeatCount = 0;  //动画重复次数 0表示无限次，默认为0
    imageView.tag = Progress_tag;

    [self addSubview:imageView];
    [self setHidden:YES];
}

-(void)hideActivityView
{
    [self removeFromSuperview];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
