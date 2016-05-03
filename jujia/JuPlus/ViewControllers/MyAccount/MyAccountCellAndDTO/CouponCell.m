//
//  CouponCell.m
//  JuPlus
//
//  Created by admin on 15/10/19.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "CouponCell.h"

@implementation CouponCell

#define margin 10.0f

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = Color_Bottom;

        [self uifig];
    }
    return self;
}
-(void)uifig
{
    [self.contentView addSubview:self.backImg];
    [self.backImg addSubview:self.priceLabel];
    [self.backImg addSubview:self.lineImg];
    [self.backImg addSubview:self.nameLabel];
    [self.backImg addSubview:self.selectBtn];
    [self.backImg addSubview:self.descriptionLabel];
    [self.backImg addSubview:self.expiryDateLabel];
}
-(UIImageView *)backImg
{
    if (!_backImg) {
        UIImage *img = [UIImage imageNamed:@"coupon_back"];
        _backImg = [[UIImageView alloc]initWithFrame:CGRectMake(margin, margin, (SCREEN_WIDTH - margin*2),SCREEN_WIDTH * 210.0f/584.0f)];
        _backImg.userInteractionEnabled = YES;
        [_backImg setImage:img];
    }
    return _backImg;
}
-(JuPlusUILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(0.0f, (self.backImg.height - 50.0f)/2, 70.0f, 50.0f)];
        [_priceLabel setTextColor:Color_Pink];
        [_priceLabel setFont:FontType(30.0f)];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLabel;
}
-(UIImageView *)lineImg
{
    if (!_lineImg) {
        _lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(80.0f - self.backImg.height/2, self.backImg.height/2, self.backImg.height - margin*2,1.0f)];
//        _lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 20.0f, 200.0f,1.0f)];

    }
    return _lineImg;
}
-(JuPlusUILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(90.0f, margin*1.5, self.backImg.width - 150.0f, 20.0f)];
        [_nameLabel setFont:FontType(FontSize)];
    
    }
    return _nameLabel;
}
-(UIButton *)selectBtn
{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.frame = CGRectMake(self.backImg.width - margin*3, self.nameLabel.top, 20.0f, 20.0f);
        [_selectBtn setImage:[UIImage imageNamed:@"method_no"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"method_yes"] forState:UIControlStateSelected];
        [_selectBtn setHidden:YES];
    }
    return _selectBtn;
}
-(RTLabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        _descriptionLabel = [[RTLabel alloc]initWithFrame:CGRectMake(self.nameLabel.left, self.nameLabel.bottom, self.nameLabel.width+50.f, 60.0f)];
        [_descriptionLabel setFont:FontType(FontMinSize)];
        [_descriptionLabel setTextColor:Color_Gray];
    }
    return _descriptionLabel;
    
}
-(JuPlusUILabel *)expiryDateLabel
{
    if (!_expiryDateLabel) {
        _expiryDateLabel = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(self.descriptionLabel.left, self.backImg.height - 20.0f, self.descriptionLabel.width, 20.0f)];
        [_expiryDateLabel setFont:FontType(FontMinSize)];
        [_expiryDateLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _expiryDateLabel;
}
-(void)fileCell:(CouponItem *)item
{
    if (item.status==1) {
        [self setLineColor:Color_Pink];
        [self.priceLabel setTextColor:Color_Pink];
    }else
    {
        [self setLineColor:Color_Gray];
        [self.priceLabel setTextColor:Color_Gray];
    }

    NSString *price;
    if ([item.amt integerValue]==[item.amt floatValue]) {
        price = [NSString stringWithFormat:@"%ld元",(long)[item.amt integerValue]];
    }else
       price = [NSString stringWithFormat:@"%@元",item.amt];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:price];
    //设置订单总金额几个字的字体以及颜色
    NSDictionary* dic = @{NSFontAttributeName:FontType(FontMaxSize)};
    [attributedString addAttributes:dic range:[price rangeOfString:@"元"]];
    [self.priceLabel setAttributedText:attributedString];
    
    [self.nameLabel setText:item.title];
    
    [self.descriptionLabel setText:item.txt];
    [self.descriptionLabel resetRTFrame];
   
    [self.expiryDateLabel setText:[NSString stringWithFormat:@"有效期至：%@",item.expireDate]];
}
//-(void)drawRect:(CGRect)rect
//{
//    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
//    UIGraphicsBeginImageContext(self.lineImg.frame.size);   //开始画线
//    //lengths的值｛5,5｝表示先绘制5个点，再跳过5个点，如此反复，
//    CGFloat lengths[] = {5,5};
//    CGContextRef line = UIGraphicsGetCurrentContext();
//    CGContextSetStrokeColorWithColor(line, [UIColor redColor].CGColor);
//    
//    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
//    CGContextMoveToPoint(line, 0.0, self.lineImg.height);    //开始画线
//     CGContextAddLineToPoint(line, self.lineImg.width, self.lineImg.height);
//    CGContextStrokePath(line);
//    
//    self.lineImg.image = UIGraphicsGetImageFromCurrentImageContext();
//    self.lineImg.transform = CGAffineTransformMakeRotation(-M_PI_2);
//}
//设置线条颜色
-(void)setLineColor:(UIColor *)color
{
    [self.lineImg.image drawInRect:CGRectMake(0, 0, self.lineImg.width, self.lineImg.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    UIGraphicsBeginImageContext(self.lineImg.frame.size);   //开始画线
    //lengths的值｛5,5｝表示先绘制5个点，再跳过5个点，如此反复，
    CGFloat lengths[] = {5,5};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, color.CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, self.lineImg.height);    //开始画线
    CGContextAddLineToPoint(line, self.lineImg.width, self.lineImg.height);
    CGContextStrokePath(line);
    
    self.lineImg.image = UIGraphicsGetImageFromCurrentImageContext();
    self.lineImg.transform = CGAffineTransformMakeRotation(-M_PI_2);

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
