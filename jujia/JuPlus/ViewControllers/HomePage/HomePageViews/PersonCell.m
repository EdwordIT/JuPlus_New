//
//  PersonCell.m
//  JuPlus
//
//  Created by ios_admin on 15/8/31.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "PersonCell.h"
@interface PersonCell ()
{
    CGFloat labelH;
}
@end
@implementation PersonCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        labelH = 30;
        CGRect frame = self.contentView.frame;
        frame.size.width = SCREEN_HEIGHT;
        self.contentView.backgroundColor = RGBACOLOR(235.0f, 235.0f, 235.0f, 0.8);
        [self.contentView addSubview:self.appointV];
        [self.appointV addSubview:self.appointLabel];
        [self.appointV addSubview:self.appImage];
        [self.appointV addSubview:self.arrowImage];
        [self.appointLabel addSubview:self.messageLabel];

    }
    return self;
}
- (UIImageView *)appointV
{
    if (!_appointV) {
        _appointV = [[UIImageView alloc]initWithFrame:CGRectMake(12, 10, SCREEN_WIDTH-24, PICTURE_HEIGHT/4-8)];
        _appointV.backgroundColor = Color_White;
    }
    return _appointV;
}
- (UIImageView *)appImage
{
    if (!_appImage) {
        _appImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/12, (PICTURE_HEIGHT/4-48)/2, 40, 40)];
        
    }
    return _appImage;
}
- (UILabel *)appointLabel
{
    if (!_appointLabel) {
        _appointLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, (PICTURE_HEIGHT/4-8-labelH)/2,SCREEN_WIDTH*2/5, labelH)];
        _appointLabel.textAlignment = NSTextAlignmentLeft;
        _appointLabel.numberOfLines = 0;
        _appointLabel.font = FontType(20);
        _appointLabel.textColor = RGBACOLOR(84, 85, 86, 0.8);
    }
    return _appointLabel;
}
-(UILabel *)messageLabel
{
    if(!_messageLabel)
    {
        _messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(90.f, (_appointLabel.height - 20.f)/2, 20.f, 20.f)];
        [_messageLabel setTextColor:Color_White];
        [_messageLabel setFont:FontType(FontSize)];
        [_messageLabel setBackgroundColor:Color_Red];
        _messageLabel.layer.masksToBounds = YES;
        _messageLabel.layer.cornerRadius = _messageLabel.height/2;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        [_messageLabel setHidden:YES];

    }
    return _messageLabel;
}
- (UIImageView *)arrowImage
{
    if (!_arrowImage) {
        _arrowImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*5/6, (PICTURE_HEIGHT/4-20)/2, 7, 12)];
    }
    return _arrowImage;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.appointV.backgroundColor =RGBACOLOR(201,201,201,1);
    // Configure the view for the selected state
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    self.appointV.backgroundColor = Color_White;
}
@end
