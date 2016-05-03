//
//  MyMessageCell.m
//  JuPlus
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 居+. All rights reserved.
//

#import "MyMessageCell.h"

@implementation MyMessageCell
{
    
}
#define space 10.f
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftImg];
        [self.contentView addSubview:self.textL];
        [self.contentView addSubview:self.detailTextL];
        [self.contentView addSubview:self.remindImg];
        [self.contentView addSubview:self.rightArrow];
    }
    return self;
}
-(UIImageView *)leftImg
{
    if (!_leftImg) {
        _leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(space, 11.5f, 27.f, 27.f)];
        _leftImg.layer.cornerRadius = 13.5f;
    }
    return _leftImg;
}
-(UILabel *)textL
{
    if (!_textL) {
        _textL = [[UILabel alloc]initWithFrame:CGRectMake(self.leftImg.right+space, 5.f, 100.f, 20.f)];
        [_textL setFont:FontType(FontSize)];
    }
    return _textL;
}
-(UILabel *)detailTextL
{
    if (!_detailTextL) {
        _detailTextL = [[UILabel alloc]initWithFrame:CGRectMake(self.leftImg.right+space, self.textL.bottom, SCREEN_WIDTH - space*3-30.f, 20.f)];
        _detailTextL.textColor =  Color_Gray;
        [_detailTextL setFont:FontType(FontMinSize)];
    }
    return _detailTextL;
}
-(UIImageView *)rightArrow
{
    if (!_rightArrow) {
        _rightArrow = [[UIImageView alloc]initWithFrame:CGRectMake(self.width - 30.0f, (self.height - 20.0f)/2, 20.0f, 20.0f)];
        [_rightArrow setImage: [UIImage imageNamed:@"arrow_right"]];
    }
    return _rightArrow;
}
//提醒
-(UIImageView *)remindImg
{
    if (!_remindImg) {
        _remindImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.leftImg.right - 8.f, self.leftImg.top - 2.f, 10.f, 10.f)];
        _remindImg.layer.cornerRadius = 5.0f;
        [_remindImg setImage:[UIImage imageNamed:@"icon_remind"]];
        [_remindImg setHidden:YES];
    }
    return _remindImg;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
