//
//  DesignerHeaderView.m
//  JuPlus
//
//  Created by 高岐 on 15/8/25.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "DesignerHeaderView.h"
#import "DesignerDTO.h"
@implementation DesignerHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化头像
        self.personHeadImageView = [[UIImageView alloc] init];
        self.personHeadImageView.frame = CGRectMake(SCREEN_WIDTH / 2 - PICTURE_HEIGHT / 10, 18, PICTURE_HEIGHT / 5, PICTURE_HEIGHT / 5);
        self.personHeadImageView.backgroundColor = Color_Gray_lines;
        self.personHeadImageView.userInteractionEnabled = YES;
        // 设置圆角
        self.personHeadImageView.layer.masksToBounds = YES;
        self.personHeadImageView.layer.cornerRadius = PICTURE_HEIGHT / 10;
        [self addSubview:self.personHeadImageView];
        
               
        self.detail = [[UILabel alloc] initWithFrame:CGRectMake(0, 18 + PICTURE_HEIGHT / 5 +10 , SCREEN_WIDTH, 20)];
        self.detail.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.detail];
        self.detail.font = FontType(13);
        

    }
    return self;
}
@end
