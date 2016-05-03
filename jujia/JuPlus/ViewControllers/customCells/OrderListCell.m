//
//  OrderListCell.m
//  JuPlus
//
//  Created by admin on 15/7/8.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "OrderListCell.h"
#import "OrderProductView.h"
@implementation OrderListCell
#define orignX 10.0f
#define labelH 30.0f
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        CGRect frame = self.contentView.frame;
        frame.size.width = SCREEN_WIDTH;
        self.contentView.frame = frame;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self uifig];
    }
    return self;
}
-(void)uifig
{
    [self.contentView addSubview:self.orderNoL];
    [self.contentView addSubview:self.timeL];
    [self.contentView addSubview:self.productScroll];
    [self.contentView addSubview:self.moreBtn];
    [self.contentView addSubview:self.countView];
    [self.contentView addSubview:self.bomAddV];
    [self.countView addSubview:self.typeLabel];
    [self.countView addSubview:self.totalCountL];
    [self.countView addSubview:self.totalPayL];
}
-(JuPlusUILabel *)orderNoL
{
    if(!_orderNoL)
    {
        _orderNoL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(orignX, 0.0f, 150.0f, labelH)];
        [_orderNoL setTextColor:Color_Gray];
        [_orderNoL setFont:FontType(FontSize)];
    }
    return _orderNoL;
}

-(JuPlusUILabel *)timeL
{
    if(!_timeL)
    {
        _timeL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 160.0f, 0.0f, 150.0f, labelH)];
        [_timeL setTextColor:Color_Gray];
        _timeL.textAlignment = NSTextAlignmentRight;
        [_timeL setFont:FontType(FontSize)];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(orignX,labelH -1.0f,self.contentView.width - orignX , 1.0f)];
        [line setBackgroundColor:Color_Gray_lines];
        [self.contentView addSubview:line];

    }
    return _timeL;
}
-(UIScrollView *)productScroll
{
    if(!_productScroll)
    {
        _productScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, self.timeL.bottom, self.contentView.width, 100.0f)];
    }
    return _productScroll;
}

-(UIButton *)moreBtn
{
    if(!_moreBtn)
    {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.frame = CGRectMake(100, 0.0f, 120.0f, 30.0f);
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(orignX,labelH -1.0f,self.contentView.width - orignX , 1.0f)];
            [line setBackgroundColor:Color_Gray_lines];
            [_moreBtn addSubview:line];
        //子类view根据父类的改变而改变
        _moreBtn.layer.masksToBounds = YES;
        [_moreBtn.titleLabel setTextColor:Color_Gray_lines];
        [_moreBtn.titleLabel setFont:FontType(FontSize)];
    }
    return _moreBtn;
}
//总数和总价
-(JuPlusUIView *)countView
{
    if(!_countView)
    {
        _countView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.moreBtn.bottom, self.contentView.width , 40.0f)];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0.0f,40.0f -1.0f, _countView.width, 1.0f)];
        [line setBackgroundColor:Color_Gray_lines];
        [_countView addSubview:line];
    }
    return _countView;
}
-(JuPlusUILabel *)totalCountL
{
    if(!_totalCountL)
    {
        _totalCountL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 220.0f, orignX, 100.0f, 20.0f)];
        [_totalCountL setTextColor:Color_Black];
        [_totalCountL setFont:FontType(FontSize)];
    }
    return _totalCountL;
}
-(JuPlusUILabel *)totalPayL
{
    if(!_totalPayL)
    {
        _totalPayL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(self.totalCountL.right, orignX, 110.0f, 20.0f)];
        [_totalPayL setTextColor:Color_Gray];
        [_totalPayL setTextAlignment:NSTextAlignmentRight];
        [_totalPayL setFont:[UIFont systemFontOfSize:FontSize]];
    }
    return _totalPayL;
}
-(JuPlusUILabel *)typeLabel
{
    if(!_typeLabel)
    {
        _typeLabel = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(orignX, orignX, 70.0f, 20.0f)];
        [_typeLabel setTextColor:Color_Basic];
        [_typeLabel setFont:FontType(FontSize)];
    }
    return _typeLabel;
}

-(JuPlusUIView *)bomAddV
{
    if(!_bomAddV)
    {
        _bomAddV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.countView.bottom, SCREEN_WIDTH, 10.0f)];
        [_bomAddV setBackgroundColor:RGBCOLOR(239, 239, 239)];
    }
    return _bomAddV;
}
//数据加载
-(void)fileCell:(OrderListDTO *)listDto
{
    [self.orderNoL setText:[NSString stringWithFormat:@"订单号：%@",listDto.orderNo]];
    [self.timeL setText:listDto.orderTime];
    [self.totalCountL setText:[NSString stringWithFormat:@"共%d件商品",listDto.totalCount]];
    [self.totalPayL setPriceText:listDto.totalPrice];
    [self.typeLabel setStatus:listDto.statusTxt];
    NSString *amt = [NSString stringWithFormat:@"总金额：%@",self.totalPayL.text];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:amt];
    [attributedString addAttribute:NSForegroundColorAttributeName value:Color_Gray range:[amt rangeOfString:@"总金额："]];
    [self.totalPayL setAttributedText:attributedString];
    CGFloat productH = 80.0f;
    [self.productScroll removeAllSubviews];
    if(listDto.totalCount>0)
    {
        for (int i=0; i<listDto.totalCount; i++) {
            OrderProductView *order = [[OrderProductView alloc]initWithFrame:CGRectMake(orignX,i*productH, SCREEN_WIDTH - orignX, productH)];
            productOrderDTO *dto = [listDto.productArray objectAtIndex:i];
            [order loadData:dto];
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0.0f,productH -1.0f, order.width, 1.0f)];
            [line setBackgroundColor:Color_Gray_lines];
            [order addSubview:line];
            
            [self.productScroll addSubview:order];

        }
        self.productScroll.frame = CGRectMake(0.0f, self.productScroll.top, SCREEN_WIDTH, productH*listDto.totalCount);
        self.productScroll.userInteractionEnabled = NO;
        self.moreBtn.frame = CGRectMake(0.0f, self.productScroll.bottom, 0.0f, 0.0f);
    }
    else
    {
        
    }
}
-(void)layoutSubviews
{
    self.countView.frame = CGRectMake(0.0f, self.productScroll.bottom, self.countView.width, self.countView.height);
    self.bomAddV.frame = CGRectMake(0.0f, self.countView.bottom, self.bomAddV.width, self.bomAddV.height);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
