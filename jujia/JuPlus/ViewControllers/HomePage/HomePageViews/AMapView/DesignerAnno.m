//
//  DesignerAnno.m
//  JuPlus
//
//  Created by admin on 15/8/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "DesignerAnno.h"

@implementation DesignerAnno
//@synthesize myTitle,myCoordinate,myImagePath,myTag,gbType;
-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate andImagePath:(NSString *)imagePath andType:(int)type;
{
    if(self = [super init])
    {

        //设置self的起始点没有意义，因为它总是以撒点的经纬度为中心点
        self.frame = CGRectMake(0, 0.0f, 30.0f, 80.0f);
        self.myCoordinate = coordinate;
        self.portraitPath = imagePath;
        self.type = type;
        self.myCoordinate = coordinate;
        [self addSubview:self.backImg];
        //self.backgroundColor = [UIColor redColor];
        [self.backImg addSubview:self.topImg];
        [self.backImg addSubview:self.btn];
    }
    return self;
}
-(UIImageView *)backImg
{
    if(!_backImg)
    {
        _backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0.0f, 30.0f, 40.0f)];
        if (self.type==1) {
            [_backImg setImage:[UIImage imageNamed:@"designer_map"]];

        }else
        [_backImg setImage:[UIImage imageNamed:@"collocation_map"]];
        _backImg.userInteractionEnabled = YES;

    }
    return _backImg;
}
-(UIButton *)btn
{
    if(!_btn)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(0.0f, 0.0f, self.backImg.width, self.backImg.height);
        [_btn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btn;
}
-(void)btnPress:(UIButton *)sender
{
    if (self.annoDelegate&&[self.annoDelegate respondsToSelector:@selector(annoPress:)]) {
        [self.annoDelegate annoPress:sender];
    }
}
-(UIImageView *)topImg
{
    if (!_topImg) {
        _topImg = [[UIImageView alloc]initWithFrame:CGRectMake(3.0f, 8.5f, self.backImg.width - 6.0f, 24.0f)];
        _topImg.layer.masksToBounds = YES;
        _topImg.userInteractionEnabled = YES;
        _topImg.layer.cornerRadius = _topImg.width/2;
    }
    return _topImg;
}
//coordinate不能直接赋值,需要使用第三方传传值，即_myCoordinate
-(CLLocationCoordinate2D )coordinate
{
    return _myCoordinate;
}
-(NSString *)title
{
    return @" ";
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
