//
//  CommentListCell.m
//  JuPlus
//
//  Created by admin on 15/11/17.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "CommentListCell.h"
@implementation CommentListCell

#define space 20.0f
- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self uifig];
    }
    return self;
}
-(void)uifig
{
    [self.contentView addSubview:self.headerImg];
    [self.contentView addSubview:self.nikenameLabel];
    [self.contentView addSubview:self.createTime];
    [self.contentView addSubview:self.nikenameButton];
    [self.contentView addSubview:self.contentLabel];
}
-(UIButton *)headerImg
{
    if (!_headerImg) {
        _headerImg = [UIButton buttonWithType:UIButtonTypeCustom];
        _headerImg.frame =CGRectMake(space, space/2, 40.0f, 40.0f);
        _headerImg.layer.masksToBounds = YES;
        _headerImg.layer.cornerRadius = 20.0f;
    }
    return _headerImg;
}
-(UILabel *)nikenameLabel
{
    if (!_nikenameLabel) {
        _nikenameLabel = [[UILabel alloc]init];
        _nikenameLabel.frame = CGRectMake(self.headerImg.right+space/2, self.headerImg.top+space/2, 100.0f, space);
        [_nikenameLabel setFont:FontType(FontSize)];
        [_nikenameLabel setTextColor:Color_Gray];

    }
    return _nikenameLabel;
}
-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.headerImg.left, self.headerImg.bottom+space/2, SCREEN_WIDTH - space*2, space)];
        [_contentLabel setFont:FontType(FontSize)];
        _contentLabel.numberOfLines = 0;
        [_contentLabel setTextColor:Color_Gray];

    }
    return _contentLabel;
}

-(UILabel *)createTime
{
    if (!_createTime) {
        _createTime = [[UILabel alloc]init];
        _createTime.frame = CGRectMake(SCREEN_WIDTH - 120.0f, self.headerImg.top+space/2, 100.0f, space);
        _createTime.textAlignment = NSTextAlignmentRight;
        [_createTime setFont:FontType(FontSize)];
        [_createTime setTextColor:Color_Gray];
    }
    return _createTime;
}
//-(UIButton *)nikenameButton
//{
//    if (!_nikenameButton) {
//        _nikenameButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _nikenameButton.frame = CGRectMake(self.headerImg.right, self.headerImg.top, self.width - self.headerImg.right , self.height);
//    }
//    return _nikenameButton;
//}

-(void)fileCell:(CommentItem *)item
{
    [self.headerImg setimageUrl:item.memberPortrait placeholderImage:nil];
    [self.nikenameLabel setText:item.memberNickname];
    self.nikenameLabel.tag = [item.memberNo integerValue];
    [self.createTime setText:item.createTime];
    
    NSString *contentTxt;
    if (IsStrEmpty(item.answeredNickname)) {
        contentTxt = item.contentText;
    }else{
        contentTxt = [NSString stringWithFormat:@"@%@ %@",item.answeredNickname,item.contentText];
    }
    CGSize size = [CommonUtil getLabelSizeWithString:contentTxt andLabelWidth:self.contentLabel.width andFont:self.contentLabel.font];
    [self.contentLabel setText:contentTxt];
    self.contentLabel.frame = CGRectMake(self.contentLabel.left, self.contentLabel.top, self.contentLabel.width, size.height);
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
