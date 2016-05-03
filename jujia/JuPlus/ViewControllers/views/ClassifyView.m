//
//  ClassifyView.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/18.
//  Copyright (c) 2015年 居+. All rights reserved.
//分类标签

#import "ClassifyView.h"
#import "JuPlusEnvironmentConfig.h"
#import "HobbyItemBtn.h"
#import <AFNetworking/AFNetworking.h>
#import "ClassifyLabelsRequest.h"
#import "ClassifyRespon.h"
#import "SCGIFImageView.h"
#import "UIButton+WebCache.h"

@implementation ClassifyView
{
    UIView *superView;
    
    NSMutableArray *buttonArray;
    
    //当只有一个选项可选中时
    HobbyItemBtn *selectedBtn;
    
    //提示用户左右滑动的提示层
    UIButton *leftArrow;
    
    UIButton *rightArrow;
}
-(id)initWithFrame:(CGRect)frame andView:(UIView *)superV
{
    superView = superV;
    self = [super initWithFrame:frame];
    if(self)
    {
        buttonArray = [[NSMutableArray alloc]init];
        self.alpha = 0;
        [self uifig];
        [self setHidden:YES];
    }
    return self;
}

-(void)fileData
{
    CGFloat spaceX = 10.0f;
    CGFloat spaceY = 70.0f;
    CGFloat btnW = 70.0f;
    CGFloat orignY = self.height/2 - (btnW*1.5+spaceY);
    CGFloat space = (self.width - btnW*3 - spaceX*2)/2;
    CGFloat btnH = btnW;
    for(int i=0;i<[self.dataArray count];i++)
    {
        ClassifyTagsDTO *tagDTO = [self.dataArray objectAtIndex:i];
        HobbyItemBtn *btn = [[HobbyItemBtn alloc]initWithFrame:CGRectMake(spaceX +self.width*(i/9)+(space+btnW)*(i%3),orignY + (spaceY+btnH)*((i/3)%3), btnW, btnH)];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = btnW/2;
        [btn.iconBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",FRONT_PICTURE_URL,tagDTO.imgUrl]] forState:UIControlStateNormal];
        [btn.iconBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",FRONT_PICTURE_URL,tagDTO.selImgUrl]] forState:UIControlStateSelected];
        btn.iconBtn.tag = [tagDTO.tagId integerValue];
        if([tagDTO.tagId isEqualToString:[CommonUtil getUserDefaultsValueWithKey:LabelTag]])
        {
            btn.iconBtn.selected = YES;
            selectedBtn = btn;
        }
        [btn.iconBtn addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
        [buttonArray addObject:btn];
        [self.itemsScroll addSubview:btn];
    }
    //如果超过9个(1屏)，则需要添加切换按钮
    if ([self.dataArray count]>9) {
        [self addSwitchBtn];
    }
    self.itemsScroll.contentSize = CGSizeMake(SCREEN_WIDTH*(([self.dataArray count] -1)/9+1), self.itemsScroll.width);
    /*
     此通知作用：由于网络加载有时间延迟，只有在网络加载完成后调用showClassify才能完成缩放效果，因此此处加通知，当第一次打开应用的时候，如果labels未加载完成，则不触发九宫格显示效果
     */
    [CommonUtil postNotification:ShowClassify Object:nil];
}
-(void)showClassify
{
    
    [self setHidden:NO];
    [self setVisualEffect];
    CGFloat spaceX = 30.0f;
    CGFloat spaceY = 30.0f;
    CGFloat btnW = 70.0f;
    CGFloat orignY = self.height/2 - (btnW*1.5+spaceY);
    CGFloat space = (self.width - btnW*3 - spaceX*2)/2;
    CGFloat btnH = btnW;

    [UIView animateWithDuration:1.0f animations:^{
        for(int i=0;i<[buttonArray count];i++)
        {
            HobbyItemBtn *btn = [buttonArray objectAtIndex:i];
            btn.frame = CGRectMake(spaceX+self.width*(i/9)+(space+btnW)*(i%3),orignY + (spaceY+btnH)*((i/3)%3), btnW, btnH);
        }
        //取到高斯模糊的背景view
        UIView *visual = [superView viewWithTag:VisualEffectTag];
        self.alpha = 1;
        if(visual!=nil)
            visual.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)reloadNetWorkError
{
    [self startRequest];
}
//后台下发标签列表，统计用户的兴趣内容
-(void)startRequest
{
    ClassifyLabelsRequest *req = [[ClassifyLabelsRequest alloc]init];
    ClassifyRespon *respon = [[ClassifyRespon alloc]init];
    [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
        [self.dataArray addObjectsFromArray:respon.tagsArray];
        [self fileData];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:NO with:self];
}
////允许多重选择的点击以及加载事件
//-(void)btnClick:(UIButton *)sender
//{
//    if(!sender.selected)
//    {
//        sender.selected = YES;
//        UIView *sup =  sender.superview;
//        if([sup isKindOfClass:[HobbyItemBtn class]])
//        {
//            NSString* filePath = [[NSBundle mainBundle] pathForResource:@"checkmark" ofType:@"gif"];
//          SCGIFImageView * selectedImage = [[SCGIFImageView alloc]initWithGIFFile:filePath withSeconds:0.5];
//            selectedImage.frame = CGRectMake(sup.width - 16.0f, (sup.height - 16.0f)/2, 16.0f, 16.0f);
//            [sup addSubview:selectedImage];
//        }
//        [self.selectArr addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
//    }
//    else
//    {
//        sender.selected =  NO;
//        UIView *sup =  sender.superview;
//        if([sup isKindOfClass:[HobbyItemBtn class]])
//        {
//            for(UIView *v in sup.subviews)
//            {
//                if([v isKindOfClass:[SCGIFImageView class]])
//                {
//                    [v removeFromSuperview];
//                }
//            }
//        }
//        [self.selectArr removeObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
//    }
//}
////确认按钮
//-(void)surePress:(UIButton *)sender
//{
//    NSLog(@"selArr = %@",self.selectArr);
//    [self setHidden:YES];
//    //[superView removeVisualEffect];
//}
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
    //如果为选中任何内容
           if(IsNilOrNull(selectedBtn))
        {
        [CommonUtil removeUserDefaultsValue:LabelTag];
        }
        else
        {
        [CommonUtil setUserDefaultsValue:[NSString stringWithFormat:@"%ld",(long)selectedBtn.iconBtn.tag] forKey:LabelTag];
    
        }
        [CommonUtil postNotification:ReloadList Object:nil];

    CGFloat spaceX = 10.0f;
    CGFloat spaceY = 70.0f;
    CGFloat btnW = 70.0f;
    CGFloat space = (self.width - btnW*3 - spaceX*2)/2;
    CGFloat btnH = btnW;
    CGFloat orignY = self.height/2 - (btnW*1.5+spaceY);
    UIView *visual = [superView viewWithTag:VisualEffectTag];
    
    [UIView animateWithDuration:1.0f animations:^{
        for(int i=0;i<[buttonArray count];i++)
        {
            HobbyItemBtn *btn = [buttonArray objectAtIndex:i];
            btn.frame =  CGRectMake(spaceX +self.width*(i/9)+(space +btnW)*(i%3),orignY + (spaceY+btnH)*((i/3)%3), btnW, btnH);
        }
        self.alpha = 0;
        if(visual!=nil)
            visual.alpha = 0;
    } completion:^(BOOL finished) {
        [self setHidden:YES];
        [visual removeFromSuperview];
    }];
}
//提醒用户点击切换
-(void)switchPress:(UIButton *)sender
{
    CGFloat orignX = self.itemsScroll.contentOffset.x;
    
        [UIView animateWithDuration:ANIMATION animations:^{
            if (sender.tag) {
                [self.itemsScroll setContentOffset:CGPointMake(orignX + SCREEN_WIDTH, 0.0f)];
            }else{
                [self.itemsScroll setContentOffset:CGPointMake(orignX - SCREEN_WIDTH, 0.0f)];
            }
        } completion:^(BOOL finished) {
            [self scrollViewDidEndDecelerating:self.itemsScroll];
        }];
}
//scrollView代理时间
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat orignX = self.itemsScroll.contentOffset.x;
    if (orignX>0) {
        [leftArrow setHidden:NO];
    }else{
        [leftArrow setHidden:YES];
    }
    
    if (orignX==scrollView.contentSize.width - SCREEN_WIDTH) {
        [rightArrow setHidden:YES];
    }else{
        [rightArrow setHidden:NO];
    }


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

#pragma uifig
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
-(void)addSwitchBtn
{
    leftArrow = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftArrow setImage:[UIImage imageNamed:@"turn_left"] forState:UIControlStateNormal];
    leftArrow.frame=CGRectMake(5.0f, (self.height-35.0f)/2, 15.0f, 35.0f);
    [leftArrow addTarget:self action:@selector(switchPress:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftArrow];
    
    [leftArrow setHidden:YES];
    
    rightArrow = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightArrow setImage:[UIImage imageNamed:@"turn_right"] forState:UIControlStateNormal];
    rightArrow.frame=CGRectMake(self.width - 20.0f, (self.height-35.0f)/2, 15.0f, 35.0f);
    [rightArrow addTarget:self action:@selector(switchPress:) forControlEvents:UIControlEventTouchUpInside];
    rightArrow.tag =1;
    [self addSubview:rightArrow];
    

    
}
-(UIScrollView *)itemsScroll
{
    if(!_itemsScroll)
    {
        _itemsScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.width, self.height)];
        _itemsScroll.delegate = self;
        _itemsScroll.pagingEnabled = YES;
        _itemsScroll.scrollsToTop = NO;
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
-(NSMutableArray *)selectArr
{
    if(!_selectArr)
    {
        _selectArr = [[NSMutableArray alloc]init];
    }
    return _selectArr;
}

-(void)uifig
{
    [self addSubview:self.titleL];
    [self addSubview:self.itemsScroll];
    [self addSubview:self.sureBtn];
    [self startRequest];
}

@end
