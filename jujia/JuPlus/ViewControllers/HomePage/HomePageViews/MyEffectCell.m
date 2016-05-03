//
//  MyEffectCell.m
//  JuPlus
//
//  Created by ios_admin on 15/9/2.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "MyEffectCell.h"
@interface MyEffectCell ()
{
    CGFloat labelH;
}
@end
@implementation MyEffectCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        labelH = 25;
        CGRect frame = self.contentView.frame;
        frame.size.width = SCREEN_HEIGHT;
        self.contentView.backgroundColor = RGBACOLOR(235.0f, 235.0f, 235.0f, 0.8);
        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(12, 8, SCREEN_WIDTH-24, PICTURE_HEIGHT/2-8)];
        [self.contentView addSubview:back];
        back.layer.masksToBounds = YES;
        [back addSubview:self.effectImage];
        [back addSubview:self.designerBut];
        [back addSubview:self.appLabel];
        
        UIView *vc = [[UIView alloc]init];
        vc.backgroundColor = RGBACOLOR(137, 83, 41, 0.2);
        [self.effectImage addSubview:vc];
    }
    return self;
}
- (UIImageView *)effectImage
{
    if (!_effectImage) {
        _effectImage = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, -PICTURE_HEIGHT/4, SCREEN_WIDTH, PICTURE_HEIGHT)];
        
    }
    return _effectImage;
}
- (UIButton *)designerBut
{
    if (!_designerBut) {
        _designerBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _designerBut.frame = CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/4)/2, PICTURE_HEIGHT/7+8, SCREEN_WIDTH/4,labelH);
        _designerBut.backgroundColor = RGBACOLOR(255, 255, 255, 0.8);
        [_designerBut setTitleColor:Color_Basic forState:UIControlStateNormal];
        _designerBut.titleLabel.font = FontType(FontSize);
    }
    return _designerBut;
}
- (UILabel *)appLabel
{
    if (!_appLabel) {
        _appLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/5)/2, PICTURE_HEIGHT/7+labelH+14,SCREEN_WIDTH/5, labelH)];
        _appLabel.textAlignment = NSTextAlignmentCenter;
        _appLabel.numberOfLines = 0;
        _appLabel.font = FontType(FontSize);
        _appLabel.textColor = Color_Basic;
        _appLabel.backgroundColor = RGBACOLOR(255, 255, 255, 0.8);
        
    }
    return _appLabel;
}
- (void)fileData:(MyappointDTO *)dto
{
    [self.effectImage setimageUrl:dto.imgUrl placeholderImage:nil];
    NSString *typeStr = @"";
    if ([dto.type integerValue] == 2){
        typeStr = @"预约体验店";
    }
    [self.designerBut setTitle:typeStr forState:UIControlStateNormal];
    NSString *str = @"";
    if ([dto.status integerValue] == 10) {
        str = @"正在预约";
    }else if ([dto.status integerValue] == 20){
        str = @"预约失败";
    }else if ([dto.status integerValue] == 30){
        str = @"预约成功";
    }
    
    [self.appLabel setText:str];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
