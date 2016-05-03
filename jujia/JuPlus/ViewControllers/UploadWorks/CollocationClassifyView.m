//
//  CollocationClassifyView.m
//  JuPlus
//
//  Created by admin on 15/8/19.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "CollocationClassifyView.h"

#import "JuPlusEnvironmentConfig.h"
#import "HobbyItemBtn.h"
#import <AFNetworking/AFNetworking.h>
#import "UploadClassifyReq.h"
#import "UploadClassifyRespon.h"
#import "UIButton+WebCache.h"

@implementation CollocationClassifyView
{
    
    NSMutableArray *buttonArray;
    
    UIView *superView;

    //当只有一个选项可选中时
    HobbyItemBtn *selectedBtn;
    
    
}
-(id)initWithFrame:(CGRect)frame andSuperView:(UIView *)v;
{
    self = [super initWithFrame:frame];
    if(self)
    {
        superView = v;
        self.alpha =  0;
        buttonArray = [[NSMutableArray alloc]init];
        [self uifig];
        [self setHidden:YES];
    }
    return self;
}
-(UILabel *)titleL
{
    if(!_titleL)
    {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 60.0f, self.width, 30.0f)];
        [_titleL setFont:FontType(20.0f)];
        [_titleL setTextAlignment:NSTextAlignmentCenter];
        [_titleL setTextColor:Color_Basic];
        [_titleL setText:@"兴 趣"];
    }
    return _titleL;
}
-(void)fileData
{
    CGFloat spaceX = 20.0f;
    CGFloat spaceY = 50.0f;
    CGFloat btnW = 70.0f;
    CGFloat space = (self.width - btnW*3 - spaceX*2)/2;
    CGFloat btnH = btnW;
    
    for(int i=0;i<[self.dataArray count];i++)
    {
        ClassifyTagsDTO *tagDTO = [self.dataArray objectAtIndex:i];
        HobbyItemBtn *btn = [[HobbyItemBtn alloc]initWithFrame:CGRectMake(spaceX+self.width*(i/9)+(space+btnW)*(i%3),90.0f+spaceY+ (spaceY+btnH)*((i/3)%3), btnW, btnH)];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = btnW/2;
        [btn.iconBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",FRONT_PICTURE_URL,tagDTO.imgUrl]] forState:UIControlStateNormal];
        [btn.iconBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",FRONT_PICTURE_URL,tagDTO.selImgUrl]] forState:UIControlStateSelected];
        btn.iconBtn.tag = [tagDTO.tagId integerValue];
        [btn.iconBtn addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
        [buttonArray addObject:btn];
        [self.itemsScroll addSubview:btn];
    }
    self.itemsScroll.contentSize = CGSizeMake(SCREEN_WIDTH*(([self.dataArray count] -1)/9+1), self.itemsScroll.width);
    /*
     此通知作用：由于网络加载有时间延迟，只有在网络加载完成后调用showClassify才能完成缩放效果，因此此处加通知，当第一次打开应用的时候，如果labels未加载完成，则不触发九宫格显示效果
     */
    
}
-(void)showClassify
{
    
    [self setHidden:NO];
    [self setVisualEffect];
    [UIView animateWithDuration:1.0f animations:^{
        //取到高斯模糊的背景view
        UIView *visual = [superView viewWithTag:VisualEffectTag];
        self.alpha = 1;
        if(visual!=nil)
            visual.alpha = 1;
    }];
}
//设置view高斯模糊显示
-(void)setVisualEffect
{
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame =CGRectMake(0.0f, 0.0f, self.width, self.height);
    visualEffectView.tag = VisualEffectTag;
    [superView addSubview:visualEffectView];
    visualEffectView.alpha = 0.0f;
    
}
//取消高斯模糊
-(void)removeVisualEffect
{
    UIView *visual = [superView viewWithTag:VisualEffectTag];
    if(visual!=nil)
    {
        [UIView animateWithDuration:1.0f animations:^{
            visual.alpha = 0;
        } completion:^(BOOL finished) {
            [visual removeFromSuperview];
        }];
    }
}
-(void)reloadNetWorkError
{
    [self startRequest];
}
//后台下发标签列表，统计用户的兴趣内容
-(void)startRequest
{
    UploadClassifyReq *req = [[UploadClassifyReq alloc]init];
    [req setField:[CommonUtil getToken] forKey:TOKEN];
    UploadClassifyRespon *respon = [[UploadClassifyRespon alloc]init];
    [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:respon.tagsArray];
        [self fileData];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:NO with:self];
}
//只可单选的点击事件以及提交按钮
-(void)btnClick1:(UIButton *)sender
{
    if(!sender.selected)
    {
        for (HobbyItemBtn *btn in buttonArray) {
            if(btn.iconBtn.tag==sender.tag)
            {
                [btn.iconBtn setSelected:YES];
                selectedBtn = btn;
                
            }
            else
            {
                [btn.iconBtn setSelected:NO];
            }
        }
    }
    else
    {
        sender.selected = NO;
        selectedBtn =  nil;
    }
}
//确认按钮
-(void)surePress1:(UIButton *)sender
{
    //如果是作品上传中的编辑效果图分类信息
    
        for (ClassifyTagsDTO *dto in self.dataArray) {
            if ([dto.tagId intValue]==selectedBtn.iconBtn.tag) {
                self.infoDTO = dto;
            }
        }
        if (self.delegate&&[self.delegate respondsToSelector:@selector(reloadInfo:)]) {
            if(IsNilOrNull(selectedBtn))
            {
                self.infoDTO = nil;
            }
            [self.delegate reloadInfo:self.infoDTO];
        }
    UIView *visual = [superView viewWithTag:VisualEffectTag];
    [UIView animateWithDuration:1.0f animations:^{
        self.alpha = 0;
        if(visual!=nil)
            visual.alpha = 0;
    } completion:^(BOOL finished) {
        [self setHidden:YES];
        [visual removeFromSuperview];
    }];
}
#pragma uifig
-(UIScrollView *)itemsScroll
{
    if(!_itemsScroll)
    {
        _itemsScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.width, self.height)];
        _itemsScroll.backgroundColor = [UIColor clearColor];
        _itemsScroll.pagingEnabled = YES;
    }
    return _itemsScroll;
}
-(UIButton *)sureBtn
{
    if(!_sureBtn)
    {
        _sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame=CGRectMake(0, self.height-84, SCREEN_WIDTH, 44);
        _sureBtn.titleLabel.font=FontType(20.0f);
        [_sureBtn setTitle:@"确 定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:Color_Pink forState:UIControlStateNormal];
        _sureBtn.alpha = ALPHLA_BUTTON;
        [_sureBtn addTarget:self action:@selector(surePress1:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
-(NSMutableArray *)dataArray
{
    if(!_dataArray)
    {
        _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataArray;
}

-(void)uifig
{
    [self addSubview:self.titleL];
    [self addSubview:self.itemsScroll];
    [self addSubview:self.sureBtn];
    [self startRequest];
}

@end
