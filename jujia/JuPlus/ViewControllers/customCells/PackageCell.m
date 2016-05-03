//
//  PackageCell.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/23.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "PackageCell.h"
#import "LabelView.h"
#import "LabelDTO.h"
#import "DesignerDetailViewController.h"
#import "HomeFurnishingViewController.h"
#import "CommentLabel.h"
CGFloat space = 10.0f;
@implementation PackageCell
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
    [self.contentView addSubview:self.messView];
    [self.messView addSubview:self.topV];
    [self.messView addSubview:self.timeLabel];
    [self.messView addSubview:self.descripL];
    [self.contentView addSubview:self.showImgV];
    [self.contentView addSubview:self.commentView];
    [self.contentView addSubview:self.feedbackView];
    [self.feedbackView addSubview:self.favBtn];
    [self.feedbackView addSubview:self.comCountBtn];
    [self.contentView addSubview:self.bottomView];
   // [self.showImgV addSubview:self.priceV];
}
-(JuPlusUIView *)messView
{
    if(!_messView)
    {
        _messView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.contentView.width, 90.0f)];
    }
    return _messView;
}
-(PortraitView *)topV
{
    if(!_topV)
    {
        _topV = [[PortraitView alloc]initWithFrame:CGRectMake(space, space, self.contentView.width - space*2, 40.0f)];        
    }
    return _topV;
}
-(JuPlusUILabel *)timeLabel
{
    if(!_timeLabel)
    {
        _timeLabel = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(self.contentView.width - 80.0f, space*2, 60.0f, 20.0f)];
        [_timeLabel setTextAlignment:NSTextAlignmentRight];
        [_timeLabel setFont:FontType(FontMinSize)];
        [_timeLabel setTextColor:Color_Gray];
    }
    return _timeLabel;
}
-(UILabel *)descripL
{
    if(!_descripL)
    {
        _descripL = [[UILabel alloc]initWithFrame:CGRectMake(space, self.topV.bottom+space, self.topV.width, 20.0f)];
        _descripL.textColor = [UIColor grayColor];
        [_descripL setFont:FontType(FontMinSize)];
    }
    return _descripL;
}
-(UIImageView *)showImgV
{
    if(!_showImgV)
    {
        _showImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, self.messView.bottom, SCREEN_WIDTH, PICTURE_HEIGHT)];
        [_showImgV setImage:[UIImage imageNamed:@"default_square"]];
        _showImgV.userInteractionEnabled = YES;
    }
    return _showImgV;
}
-(UIView *)commentView
{
    if (!_commentView) {
        _commentView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, _showImgV.bottom, SCREEN_WIDTH, 10.0f)];
        _commentView.userInteractionEnabled = YES;
    }
    return _commentView;
}
-(UIView *)feedbackView
{
    if (!_feedbackView) {
        _feedbackView = [[UIView alloc]initWithFrame:CGRectMake(0.f, _commentView.bottom, SCREEN_WIDTH, 50.f)];
        UIImageView *fav1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100.f, space, 20.f, 20.f)];
        [fav1 setImage:[UIImage imageNamed:@"fav_col"]];
        [_feedbackView addSubview:fav1];
        UIImageView *fav2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 55.f, space, 20.f, 20.f)];
        [fav2 setImage:[UIImage imageNamed:@"review_col"]];
        [_feedbackView addSubview:fav2];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0.f, 40.f, SCREEN_WIDTH, space)];
        [line setBackgroundColor:Color_Bottom];
        [_feedbackView addSubview:line];

    }
    return _feedbackView;
}
-(UIButton *)favBtn
{
    if (!_favBtn) {
        _favBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _favBtn.frame = CGRectMake(SCREEN_WIDTH -80.f, space, 25.f, 20.f);
        [_favBtn.titleLabel setFont:FontType(FontSize)];
        _favBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_favBtn setTitleColor:Color_Basic forState:UIControlStateNormal];
    }
    return _favBtn;
}
-(UIButton *)comCountBtn
{
    if (!_comCountBtn) {
        _comCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _comCountBtn.frame = CGRectMake(SCREEN_WIDTH -35.f, space, 25.f, 20.f);
        _comCountBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_comCountBtn.titleLabel setFont:FontType(FontSize)];
        [_comCountBtn setTitleColor:Color_Basic forState:UIControlStateNormal];
    }
    return _comCountBtn;
}

-(JuPlusUIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.showImgV.bottom, self.contentView.width, 2.0f)];
        _bottomView.backgroundColor = Color_Gray_lines;
        [_bottomView setHidden:YES];
    }
    return _bottomView;
}
//cell数据加载
-(void)loadCellInfo:(HomePageInfoDTO *)homepageDTO withShared:(BOOL)isShared animationed:(BOOL)animationed
{
    //
    if (isShared) {
        [self.showImgV setimageUrl:homepageDTO.sharePic  placeholderImage:nil];
        //如果是点击切换
        if (animationed) {
           
        }
        //隐藏信息栏
        [self.messView setHidden:YES];
        [self.commentView setHidden:YES];
        [self.feedbackView setHidden:YES];
        //隐藏标签
        for(UIView *sub in self.showImgV.subviews)
        {
            if ( [sub isKindOfClass:[LabelView class]]) {
                [sub setHidden:YES];
            }
        }
        [self.bottomView setHidden:NO];
        self.messView.frame = CGRectMake(0.0f, 0.0f, self.contentView.width, 0.0f);
        [UIView animateWithDuration:ANIMATION animations:^{
            self.showImgV.frame = CGRectMake(0.0f, 0.0f, self.contentView.width, PICTURE_HEIGHT);
            self.bottomView.frame = CGRectMake(0.0f, self.showImgV.bottom, self.bottomView.width, self.bottomView.height);
        }];

    }
    else
    {
        [self.showImgV setimageUrl:homepageDTO.collectionPic  placeholderImage:nil];
        
        if (animationed) {
            
        }
        //显示信息栏
        [self.messView setHidden:NO];
        [self.commentView setHidden:NO];
        [self.feedbackView setHidden:NO];
        //显示标签
        for(UIView *sub in self.showImgV.subviews)
        {
            if ( [sub isKindOfClass:[LabelView class]]) {
                [sub setHidden:NO];
            }
        }
        [UIView animateWithDuration:ANIMATION animations:^{
            self.messView.frame = CGRectMake(0.0f, 0.0f, self.contentView.width, 90.0f);
            self.showImgV.frame = CGRectMake(0.0f, self.messView.bottom, self.contentView.width, PICTURE_HEIGHT);
            self.bottomView.frame = CGRectMake(0.0f, self.showImgV.bottom, self.bottomView.width, self.bottomView.height);
        }];

        [self.topV.portraitImgV setimageUrl:homepageDTO.portrait  placeholderImage:nil];
        self.commentView.tag = [homepageDTO.regNo integerValue];
        [self.topV.nikeNameL setText:homepageDTO.nikename];
        [self.timeLabel setText:homepageDTO.uploadTime];
        [self.descripL setText:homepageDTO.descripTxt];
        [self.showImgV setimageUrl:homepageDTO.collectionPic  placeholderImage:nil];
        [self.bottomView setHidden:YES];
        [self.favBtn setTitle:homepageDTO.favCount forState:UIControlStateNormal];
        [self.comCountBtn setTitle:homepageDTO.comCount forState:UIControlStateNormal];
        self.showImgV.tag = [homepageDTO.regNo intValue];
        [self setTipsWithArray:homepageDTO.labelArray];
        [self loadCommentView:homepageDTO];
    }
    
    [self.priceV setPriceText:homepageDTO.price];
    self.topV.portraitImgV.tag = [homepageDTO.memNo intValue];
    [self.topV.portraitImgV addTarget:self action:@selector(portraitImgVPress:) forControlEvents:UIControlEventTouchUpInside];
}
//推出搭配师
-(void)portraitImgVPress:(UIButton *)sender
{
    DesignerDetailViewController *design = [[DesignerDetailViewController alloc]init];
    design.userId = [NSString stringWithFormat:@"%ld",sender.tag];
    UIViewController *vc = [self getSuperViewController];
    [vc.navigationController.view.layer addAnimation:[self getPushTransition] forKey:nil];
    [vc.navigationController pushViewController:design animated:NO];
   
}
-(void)loadCommentView:(HomePageInfoDTO *)homePageDTO
{

            if (IsArrEmpty(homePageDTO.commentList)) {
                self.commentView.frame = CGRectMake(self.commentView.left, self.commentView.top, self.commentView.width, 0.f);
                [self.commentView setHidden:YES];
            }else{
                [self.commentView setHidden:NO];
                [self.commentView removeAllSubviews];
                for (int i=0; i<homePageDTO.commentList.count; i++) {
                    CommentItem *item = [homePageDTO.commentList objectAtIndex:i];
                    CommentLabel *label = [[CommentLabel alloc]initWithFrame:CGRectMake(0.0f, i*30.f, self.commentView.width, 30.0f)];
                    [label resetFrame:item isHomepage:YES];
                    label.textLabel.frame = CGRectMake(label.textLabel.left, label.textLabel.top, label.textLabel.width, 20.0f);
                    
                    [self.commentView addSubview:label];
                    if (i==homePageDTO.commentList.count-1) {
                        
                        //重置提交框的起始位置
                        self.commentView.frame = CGRectMake(self.commentView.left, self.commentView.top, self.commentView.width, 30.f*(i+1));
                        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(space, self.commentView.height - 1.0f, SCREEN_WIDTH, 1.0f)];
                        [line setBackgroundColor:Color_Gray_lines];
                        [self.commentView addSubview:line];
                    }
                }
            }
    //重置整个评论框架的大小
    self.feedbackView.frame = CGRectMake(self.feedbackView.left, self.commentView.bottom, self.feedbackView.width, self.feedbackView.height);
}
-(void)setTipsWithArray:(NSArray *)tipsArray
{
    for(UIView *vi in [self.showImgV subviews])
    {
        if([vi isKindOfClass:[LabelView class]])
        {
            [((LabelView *)vi).timer invalidate];
            [vi removeFromSuperview];
        }
    }
       for(int i=0;i<[tipsArray count];i++)
    {
        LabelDTO *dto = [tipsArray objectAtIndex:i];
        CGFloat orignX = (dto.locX/100)*self.showImgV.width;
        CGFloat orignY = (dto.locY/100)*self.showImgV.height - 50.0f;
        
        CGSize size = [CommonUtil getLabelSizeWithString:dto.productName andLabelHeight:20.0f andFont:FontType(FontMinSize)];
        LabelView *la;
        if ([dto.direction floatValue]==1) {
             la = [[LabelView alloc]initWithFrame:CGRectMake(orignX, orignY, size.width +15.0f, 50.0f) andDirect:dto.direction];
        }
        else
        {
            la = [[LabelView alloc]initWithFrame:CGRectMake(orignX - size.width - 15.0f, orignY, size.width +15.0f, 50.0f) andDirect:dto.direction];

        }
       
        la.tag = [dto.productNo intValue];
        [la showText:dto.productName];
        [self.showImgV addSubview:la];
    }
}

@end
