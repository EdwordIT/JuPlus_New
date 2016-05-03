//
//  CommentLabel.m
//  JuPlus
//
//  Created by admin on 15/11/12.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "CommentLabel.h"
#define space 5.0f
#define orignX 10.0f
#define viewH 20.f
@implementation CommentLabel
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self uifig];
    }
    return self;
}
-(void)uifig
{
    [self addSubview:self.headerImg];
    [self addSubview:self.nikenameLabel];
    [self addSubview:self.answerLabel];
    [self addSubview:self.nikenameButton];
    [self addSubview:self.textLabel];
    [self addSubview:self.textButton];
}
-(UIButton *)headerImg
{
    if (!_headerImg) {
        _headerImg = [UIButton buttonWithType:UIButtonTypeCustom];
        _headerImg.frame =CGRectMake(orignX, space, 20.0f, 20.0f);
        _headerImg.layer.masksToBounds = YES;
        _headerImg.layer.cornerRadius = 10.0f;
    }
    return _headerImg;
}

-(UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.nikenameLabel.right, space, self.width - self.headerImg.right -orignX, viewH)];
        _textLabel.numberOfLines = 0;
        _textLabel.textColor = Color_Gray;
        [_textLabel setFont:FontType(FontSize)];
    }
    return _textLabel;
}
-(UILabel *)nikenameLabel
{
    if (!_nikenameLabel) {
        _nikenameLabel = [[UILabel alloc]init];
        _nikenameLabel.frame = CGRectMake(self.headerImg.right, space, 100.0f, viewH);
        _nikenameLabel.textColor = Color_Pink;
        [_nikenameLabel setFont:FontType(FontSize)];
    }
    return _nikenameLabel;
}

-(UILabel *)answerLabel
{
    if (!_answerLabel) {
        _answerLabel = [[UILabel alloc]init];
        _answerLabel.frame = CGRectMake(self.nikenameLabel.right, space, 100.0f, viewH);
        _answerLabel.textColor = Color_Pink;
        [_answerLabel setFont:FontType(FontSize)];

    }
    return _answerLabel;
}
-(UIButton *)nikenameButton
{
    if (!_nikenameButton) {
        _nikenameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nikenameButton.frame = CGRectMake(self.headerImg.right, space, self.width - self.headerImg.right -orignX, viewH);
    }
    return _nikenameButton;
}
-(UIButton *)textButton
{
    if (!_textButton) {
        _textButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _textButton.frame = CGRectMake(0.0f, space, self.textLabel.width, self.textLabel.height);
    }
    return _textButton;
}
-(void)resetFrame:(CommentItem *)item isHomepage:(BOOL)isHomePage
{
    if(!isHomePage)
    {
    [self.headerImg setimageUrl:item.memberPortrait placeholderImage:nil];
    self.headerImg.frame = CGRectMake(self.headerImg.left, self.headerImg.top, 20.f, 20.f);
    }
    else
    self.headerImg.frame = CGRectMake(self.headerImg.left, self.headerImg.top, 0.f, 0.f);
   
    //添加昵称以及回复人信息
    NSString *nikeNameStr =  [NSString stringWithFormat:@"%@：",item.memberNickname];
    CGSize size1 = [CommonUtil getLabelSizeWithString:nikeNameStr andLabelHeight:self.nikenameLabel.width andFont:self.nikenameLabel.font];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:nikeNameStr];
    //设置：特殊字体的颜色
    NSDictionary* dic = @{NSForegroundColorAttributeName:[UIColor grayColor]};
    [attributedString addAttributes:dic range:[nikeNameStr rangeOfString:@"："]];
    [self.nikenameLabel setAttributedText:attributedString];
    [self.answerLabel setText:item.answeredNickname];

    self.nikenameLabel.frame = CGRectMake(self.headerImg.right, self.nikenameLabel.top, size1.width, self.nikenameLabel.height);
    CGSize size2;
    if (!IsStrEmpty(item.answeredNickname)) {
       size2 = [CommonUtil getLabelSizeWithString:[item.answeredNickname stringByAppendingString:@"@"] andLabelWidth:self.answerLabel.width andFont:self.textLabel.font];
    }else{
        size2 = CGSizeMake(0.0f, self.answerLabel.height);
    }
    self.answerLabel.frame = CGRectMake(self.nikenameLabel.right, self.answerLabel.top, size2.width, self.answerLabel.height);
    [self.answerLabel setText:[@"@" stringByAppendingString:item.answeredNickname]];
    [self.textLabel setText:item.contentText];
        CGSize size = [CommonUtil getLabelSizeWithString:item.contentText andLabelWidth:SCREEN_WIDTH - self.answerLabel.right - 10.f andFont:self.textLabel.font];
    //首页不需要设置评论内容的高度，直接单行显示
    if(!isHomePage)
    {
        self.textLabel.frame = CGRectMake(self.answerLabel.right, self.textLabel.top, SCREEN_WIDTH - self.answerLabel.right - 10.f , size.height+4.0f);
        self.frame = CGRectMake(self.left, self.top, self.width, self.textLabel.height+space*2);
    }else
        self.textLabel.frame = CGRectMake(self.answerLabel.right, self.textLabel.top, SCREEN_WIDTH - self.answerLabel.right - 10.f , self.textLabel.height);

        self.textButton.frame = CGRectMake(self.textLabel.left, self.textLabel.top, self.textLabel.width, self.textLabel.height);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
