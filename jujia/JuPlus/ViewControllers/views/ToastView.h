//
//  ToastView.h
//  JuPlus
//
//  Created by admin on 15/8/13.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    ShareToWechatTimeline = 1,  //分享到朋友圈
    ShareToWechatSession , //分享到微信好友
    ShareToWechatTencent,//分享腾讯微博
    ShareToWechatSina,//新浪微博
} ShareMethod;


@protocol ToastViewDelegate <NSObject>

-(void)Method:(NSInteger )tag;

@end

@interface ToastView : UIView

@property (nonatomic,strong)UIImageView *backImage;

@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UIButton *sureBtn;

@property (nonatomic,strong)NSMutableArray *buttonArr;

@property (nonatomic,assign)id<ToastViewDelegate>delegate;

-(id)initWithFrame:(CGRect)frame title:(NSString *)title;

-(void)showShareView:(UIImage *)image;


@end
