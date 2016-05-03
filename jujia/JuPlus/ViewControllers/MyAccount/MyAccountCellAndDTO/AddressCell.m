//
//  AddressCell.m
//  JuPlus
//
//  Created by admin on 15/7/13.
//  Copyright (c) 2015年 居+. All rights reserved.
//地址管理

#import "AddressCell.h"
@interface AddressCell ()
{
    CGFloat labelH;
    CGFloat space;
}
@end

@implementation AddressCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        space = 10.0f;
        labelH = 30.0f;
        CGRect frame = self.contentView.frame;
        frame.size.width = SCREEN_WIDTH;
        self.contentView.frame = frame;
        [self.contentView addSubview:self.topView];
        [self.contentView addSubview:self.nameL];
        [self.contentView addSubview:self.mobileL];
        [self.contentView addSubview:self.addressL];
        [self.contentView addSubview:self.botView];
        [self.botView addSubview:self.setDetaultBtn];
        //[self.botView addSubview:self.editBtn];
    }
    return self;
}

-(JuPlusUIView *)topView
{
    if(!_topView)
    {
        _topView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.contentView.width, 10.0f)];
        [_topView setBackgroundColor:Color_Bottom];
    }
    return _topView;
}
-(JuPlusUIView *)botView
{
    if(!_botView)
    {
        _botView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, 70.0f, self.contentView.width, 40.0f)];
        [_botView setBackgroundColor:Color_White];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(space,0.0f,self.contentView.width - space , 1.0f)];
        [line setBackgroundColor:Color_Gray_lines];
        [_botView addSubview:line];
    }
    return _botView;
}

-(JuPlusUILabel *)nameL
{
    if(!_nameL)
    {
        _nameL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(space, space, 80.0f, labelH)];
        [_nameL setFont:FontType(18.0f)];
        [_nameL setTextColor:Color_Black];
    }
    return _nameL;
}
-(JuPlusUILabel *)mobileL
{
    if(!_mobileL)
    {
        _mobileL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(self.nameL.right, space, 120.0f, labelH)];
        [_mobileL setFont:FontType(18.0f)];
        [_mobileL setTextColor:Color_Black];
    }
    return _mobileL;
}
-(JuPlusUILabel *)addressL
{
    if(!_addressL)
    {
        _addressL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(space, self.mobileL.bottom, self.width - 110.0f, labelH)];
        [_addressL setFont:FontType(16.0f)];
        [_addressL setTextColor:Color_Gray];
    }
    return _addressL;
}
-(UIButton *)setDetaultBtn
{
    if(!_setDetaultBtn)
    {
        _setDetaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _setDetaultBtn.frame = CGRectMake(space, space, 100.0f, 30.0f);
        [_setDetaultBtn setImage:[UIImage imageNamed:@"check_1"] forState:UIControlStateNormal];
        [_setDetaultBtn setImage:[UIImage imageNamed:@"check_2"] forState:UIControlStateSelected];

        [_setDetaultBtn setTitle:@"设为默认" forState:UIControlStateNormal];
        [_setDetaultBtn.titleLabel setFont:FontType(16.0f)];
        [_setDetaultBtn setTitleColor:Color_Gray forState:UIControlStateNormal];
        [_setDetaultBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,_setDetaultBtn.imageView.image.size.width, 0.0, 0.0)];
        }
    return _setDetaultBtn;
}
-(UIButton *)editBtn
{
    if(!_editBtn)
    {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _editBtn.frame = CGRectMake(self.botView.width - 90.0f, space, 80.0f, 30.0f);
        [_editBtn setImage:[UIImage imageNamed:@"icons_edit"] forState:UIControlStateNormal];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn.titleLabel setFont:FontType(16.0f)];
        [_editBtn setTitleColor:Color_Gray forState:UIControlStateNormal];
        [_editBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,_editBtn.imageView.image.size.width, 0.0, 0.0)];
        
    }
    return _editBtn;
}
-(void)loadCellWithDTO:(AddressDTO *)dto
{
    [self.nameL setText:dto.addName];
    [self.mobileL setText:dto.addMobile];
    [self.addressL setText:dto.addAddress];
    self.setDetaultBtn.tag = [dto.addId intValue];
    if (dto.isDefault) {
        self.setDetaultBtn.selected = YES;
    }
    else
        self.setDetaultBtn.selected = NO;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
