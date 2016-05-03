//
//  MyFavourCell.m
//  JuPlus
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "MyFavourCell.h"

@implementation MyFavourCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        CGRect frame = self.contentView.frame;
        frame.size.width = SCREEN_WIDTH;
        self.contentView.frame = frame;
        
        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, PICTURE_HEIGHT/2)];
        [self.contentView addSubview:back];
        back.layer.masksToBounds = YES;
        [back addSubview:self.backImage];

        UIView *coverV = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, PICTURE_HEIGHT/2)];
        coverV.backgroundColor = RGBACOLOR(137, 83, 41, 0.2);
        [back addSubview:coverV];
        [self.backImage addSubview:self.nameLabel];
        
    }
    return self;
}

-(UIImageView *)backImage
{
    if(!_backImage)
    {
    _backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, -PICTURE_HEIGHT/4, SCREEN_WIDTH, PICTURE_HEIGHT)];
        [_backImage setImage:[UIImage imageNamed:@"default_square"]];

    }
    return _backImage;
    
}
-(UILabel *)nameLabel
{
    if(!_nameLabel)
    {
        _nameLabel =[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 260.0f)/2, (self.backImage.height - 30.0f)/2,260.0f, 30.0f)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel setFont:FontType(14.0f)];
        _nameLabel.numberOfLines = 0;
        _nameLabel.backgroundColor = RGBACOLOR(255, 255, 255, 0.8);
        _nameLabel.textColor = HEX_RGB(@"895329");
    }
    return _nameLabel;
}
-(void)fileData:(MyFavourDTO *)dto
{
    [self.nameLabel setText:dto.name];
    [self.backImage setimageUrl:dto.coverUrl placeholderImage:nil];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
