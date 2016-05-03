//
//  FavCell.m
//  JuPlus
//
//  Created by ios_admin on 15/8/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "FavCell.h"
#import "FavDTO.h"
@interface FavCell ()
{
    CGFloat labelH;
}
@end
@implementation FavCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        labelH = 30;
        CGRect frame = self.contentView.frame;
        frame.size.width = SCREEN_HEIGHT;
        [self.contentView addSubview:self.headImage];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.datalabel];
    }
    return self;
}
- (UIImageView *)headImage
{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.frame = CGRectMake(SCREEN_WIDTH /16, (PICTURE_HEIGHT/5-PICTURE_HEIGHT /8)/2, PICTURE_HEIGHT /8, PICTURE_HEIGHT /8);
        _headImage.backgroundColor = Color_Gray_lines;
        [self.headImage.layer setMasksToBounds:YES];
        [self.headImage.layer setCornerRadius:PICTURE_HEIGHT/16];
    }
    return _headImage;
}
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.frame = CGRectMake(SCREEN_WIDTH/4,(PICTURE_HEIGHT/5-labelH)/2,SCREEN_WIDTH*3/5,labelH);
        _nameLabel.numberOfLines = 0;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = FontType(FontMinSize);


    }
    return _nameLabel;
}
- (UILabel *)datalabel
{
    if (!_datalabel) {
        _datalabel = [[UILabel alloc]init];
        _datalabel.frame = CGRectMake(SCREEN_WIDTH*2/3+10, (PICTURE_HEIGHT/5-labelH)/2, SCREEN_WIDTH/4,labelH);
        _datalabel.numberOfLines = 0;
        _datalabel.textAlignment = NSTextAlignmentLeft;
        _datalabel.font = FontType(FontMinSize);

    }
    return _datalabel;
}
-(void)fileData:(FavDTO *)dto
{

    [self.headImage setimageUrl:dto.memPortraitPath placeholderImage:nil];
    [self.nameLabel setText:dto.nickname];
    
    if (!IsStrEmpty(dto.createTime)) {
        NSString *strAll = [[dto.createTime substringFromIndex:5] stringByAppendingString:@"收藏"];
        [self.datalabel setText:strAll];
    }
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor); CGContextFillRect(context, rect);
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"e2e2e2"].CGColor); CGContextStrokeRect(context, CGRectMake(0, PICTURE_HEIGHT/5, SCREEN_WIDTH, 1));
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
