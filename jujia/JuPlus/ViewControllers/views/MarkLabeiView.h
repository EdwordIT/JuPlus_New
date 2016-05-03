//
//  MarkLabeiView.h
//  JuPlus
//
//  Created by admin on 15/8/4.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusUIView.h"
#import "LabelDTO.h"
@interface MarkLabeiView : JuPlusUIView

-(id)initWithFrame:(CGRect)frame andDirect:(NSString *)dir;
//定点image
@property(nonatomic,strong)UIImageView *tipsImage;
//渐隐图层
@property(nonatomic,strong)UIImageView *alphaImage;
//斜线
@property(nonatomic,strong)UIImageView *dropImg;
//延伸线
@property(nonatomic,strong)UIImageView *lineImg;
//标签内容
@property(nonatomic,strong)UILabel *labelText;
//点击事件
@property(nonatomic,strong)UIButton *touchBtn;
//标签朝向
@property(nonatomic,assign)BOOL isLeft;

@property(nonatomic,strong)LabelDTO *infoDTO;

@property(nonatomic,strong)NSTimer *timer;
//判断是否正在编辑标签
@property(nonatomic,assign)BOOL isEdit;
-(void)showText:(NSString *)text;
//切换朝向
-(void)setDirectionWithDire;
@end
