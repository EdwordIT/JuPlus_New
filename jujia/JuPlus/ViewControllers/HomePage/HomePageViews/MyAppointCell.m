//
//  MyAppointCell.m
//  JuPlus
//
//  Created by ios_admin on 15/9/1.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "MyAppointCell.h"
#import "DesignerDetailViewController.h"
@interface MyAppointCell ()
{
    CGFloat labelH;
}
@end
@implementation MyAppointCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        labelH = 25;
        CGRect frame = self.contentView.frame;
        frame.size.width = SCREEN_HEIGHT;
        self.contentView.backgroundColor = RGBACOLOR(235.0f, 235.0f, 235.0f, 0.8);
        [self.contentView addSubview:self.effectImage];
        [self.effectImage addSubview:self.imgUrl];
        [self.effectImage addSubview:self.typeBut];
        [self.effectImage addSubview:self.status];
        
    }
    return self;
}
- (UIImageView *)effectImage
{
    if (!_effectImage) {
        _effectImage = [[UIImageView alloc]initWithFrame:CGRectMake(12, 8, SCREEN_WIDTH-24, PICTURE_HEIGHT/2-8)];
        _effectImage.image = [UIImage imageNamed:@"designer"];
        UIView *vc = [[UIView alloc]init];
        vc.backgroundColor = RGBACOLOR(137, 83, 41, 0.2);
        [self.effectImage addSubview:vc];

    }
    return _effectImage;
}
- (UIImageView *)imgUrl
{
    if (!_imgUrl) {
        _imgUrl = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-PICTURE_HEIGHT/7-8)/2, PICTURE_HEIGHT/12, PICTURE_HEIGHT/7, PICTURE_HEIGHT/7)];
        _imgUrl.layer.masksToBounds = YES;
        _imgUrl.layer.cornerRadius= PICTURE_HEIGHT/14;
        
    }
    return _imgUrl;
}
- (UIButton *)typeBut
{
    if (!_typeBut) {
        _typeBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _typeBut.frame = CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/4-8)/2, PICTURE_HEIGHT/12+PICTURE_HEIGHT/7+15, SCREEN_WIDTH/4,labelH);
//        _typeBut.backgroundColor = RGBACOLOR(255, 255, 255, 0.8);
        _typeBut.titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:FontMaxSize];
        [_typeBut setTitleColor:Color_White forState:UIControlStateNormal];
        [_typeBut setTitle:self.typeBut.titleLabel.text forState:UIControlStateNormal];
//        _typeBut.titleLabel.font = FontType(FontMaxSize);
    }
    return _typeBut;
}
- (UILabel *)status
{
    if (!_status) {
        _status = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/5-8)/2, PICTURE_HEIGHT/12+PICTURE_HEIGHT/7+labelH+16,SCREEN_WIDTH/5, labelH-4)];
        _status.textAlignment = NSTextAlignmentCenter;
        _status.numberOfLines = 0;
        _status.font = FontType(FontSize);
        _status.textColor = Color_Basic;
        _status.backgroundColor = RGBACOLOR(255, 255, 255, 0.8);
    }
    return _status;
}
- (void)fileData:(MyappointDTO *)dto
{
    [self.imgUrl setimageUrl:dto.imgUrl placeholderImage:nil];
    
    NSString *typeStr = @"";
    if ([dto.type integerValue] == 1) {
        typeStr = @"预约搭配师";
    }
    [self.typeBut setTitle:typeStr forState:UIControlStateNormal];
    NSString *str = @"";
    if ([dto.status integerValue] == 10) {
        str = @"正在预约";
    }else if ([dto.status integerValue] == 20){
        str = @"预约失败";
    }else if ([dto.status integerValue] == 30){
        str = @"预约成功";
    }
    [self.status setText:str];
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
