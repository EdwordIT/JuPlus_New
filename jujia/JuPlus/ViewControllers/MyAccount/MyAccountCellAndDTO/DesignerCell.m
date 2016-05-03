//
//  DesignerCell.m
//  JuPlus
//
//  Created by ios_admin on 15/8/25.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "DesignerCell.h"
#import "DesignerDTO.h"
@interface DesignerCell ()
{
    CGFloat labelH;
}
@end
@implementation DesignerCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        labelH = 30;
        CGRect frame = self.contentView.frame;
        frame.size.width = SCREEN_HEIGHT;
        
        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, PICTURE_HEIGHT/2-2)];
        [self.contentView addSubview:back];
        back.layer.masksToBounds = YES;
        [back addSubview:self.coverUrlImage];
        [back addSubview:self.simpleLabel];
        [back addSubview:self.totalPriceLabel];
        
        UIView *coverV = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0, self.coverUrlImage.width, PICTURE_HEIGHT/2-2)];
        coverV.backgroundColor = RGBACOLOR(137, 83, 41, 0.2);
        [back addSubview:coverV];
        
        }
    return self;
}

- (UIImageView *)coverUrlImage
{
    if (!_coverUrlImage) {
        _coverUrlImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,-PICTURE_HEIGHT/4, SCREEN_WIDTH, PICTURE_HEIGHT )]; // 留出两个像素的白边

//        [_coverUrlImage setBackgroundColor:Color_Basic];
    }
    return _coverUrlImage;
}
- (UILabel *)simpleLabel
{
    if (!_simpleLabel) {
        _simpleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5, (PICTURE_HEIGHT/2-labelH)/3, SCREEN_WIDTH*3/5, labelH)];
        _simpleLabel.textAlignment = NSTextAlignmentCenter;
        [_simpleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:FontMaxSize]];
//        _simpleLabel.font = FontType(FontMaxSize);
        _simpleLabel.numberOfLines = 0;
        _simpleLabel.textColor = Color_White;
        
    }
    return _simpleLabel;
}
- (UILabel *)totalPriceLabel
{
    if (!_totalPriceLabel) {
        self.totalPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2/5, (PICTURE_HEIGHT/2-labelH)/3+labelH+10, SCREEN_WIDTH/5, 20)];
        self.totalPriceLabel.backgroundColor = RGBACOLOR(255, 255, 255, 0.8);
        self.totalPriceLabel.textAlignment = NSTextAlignmentCenter;
        self.totalPriceLabel.textColor = Color_Basic;
        self.totalPriceLabel.font = [UIFont systemFontOfSize:FontSize];
        
    }
    return _totalPriceLabel;
}
- (void)fileData:(DesignerDTO *)dto
{
    [self.coverUrlImage setimageUrl:dto.coverUrl placeholderImage:nil];
    [self.simpleLabel setText:dto.simpleExplain];
    NSString *allArr = [@"¥ " stringByAppendingString:dto.totalPrice];
    [self.totalPriceLabel setText:allArr];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
