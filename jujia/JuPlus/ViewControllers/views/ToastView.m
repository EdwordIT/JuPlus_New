//
//  ToastView.m
//  JuPlus
//
//  Created by admin on 15/8/13.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "ToastView.h"
@implementation ToastView
{
    NSString *titleStr;
}
-(id)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        titleStr = title;
        self.backgroundColor = [UIColor whiteColor];
        self.buttonArr = [[NSMutableArray alloc]init];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4.0f;
        [self addSubview:self.backImage];
        [self addSubview:self.titleLabel];
        //新浪微博、腾讯微博暂不上线
       // NSArray *nameArr = [NSArray arrayWithObjects:@"weichat_TimeLine",@"weichat_session",@"tencent twitter",@"sina twitter", nil];
        NSArray *nameArr = [NSArray arrayWithObjects:@"weichat_TimeLine",@"weichat_session", nil];

        CGFloat orignY = self.backImage.bottom+10.0f;
//        CGFloat space = (self.width - 48.0f*4)/5;
        CGFloat space = (self.width - 48.0f*[nameArr count])/([nameArr count]+1);
        for (int i =0; i<[nameArr count]; i++) {
          UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(space+i*(space + 48.0f), orignY, 48.0f, 65.0f);
            [btn setImage:[UIImage imageNamed:[nameArr objectAtIndex:i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:[nameArr objectAtIndex:i]] forState:UIControlStateHighlighted];

            btn.tag = i+1;
            [self addSubview:btn];
            [btn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttonArr addObject:btn];
        }
//        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0.0f, self.height - 40.0f, self.width, 1.0f)];
//        [line setBackgroundColor:Color_Gray_lines];
//        [self addSubview:line];
//        [self addSubview:self.sureBtn];
    }
    return self;
}
-(UIImageView *)backImage
{
    if (!_backImage) {
        _backImage = [[UIImageView alloc]initWithFrame:CGRectMake(2.0f, 2.0f, self.width - 4.0f, self.width - 4.0f)];
        [_backImage setImage:[UIImage imageNamed:@"default_square"]];
    }
    return _backImage;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.width - 70.0f)/2, (self.backImage.height - 25.0f)/2, 70.0f, 25.0f)];
        _titleLabel.backgroundColor = RGBACOLOR(255, 255, 255, 0.8);

        [_titleLabel setFont:FontType(FontMaxSize)];
        _titleLabel.alpha = 0.9;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setTextColor:Color_Basic];
        if (titleStr==nil) {
            _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, self.backImage.bottom+10.0f, self.width, 0.0f)];
        }
        else
        {
            [_titleLabel setText:titleStr];
        }
    }
    return _titleLabel;
}

//-(UIButton *)sureBtn
//{
//    if (!_sureBtn) {
//        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _sureBtn.frame = CGRectMake(0.0f, self.height - 40.0f, self.width, 40.0f);
//        [_sureBtn setTitleColor:Color_Basic forState:UIControlStateNormal];
//        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
//        [_sureBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:FontMaxSize]];
//        [_sureBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _sureBtn;
//}
-(void)btnPress:(UIButton *)sender
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(Method:)]) {
        [self.delegate Method:sender.tag];
    }
}

-(void)showShareView:(UIImage *)image
{
    [self.backImage setImage:image];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
