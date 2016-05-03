//
//  TimerButton.h
//  Autoyol
//
//  Created by Ning Gang on 13-9-14.
//  Copyright (c) 2013年 Autoyol. All rights reserved.
//

#import <UIKit/UIKit.h>
// 手机验证码发送间隔，秒
#define SEND_SMS_INTERVAL 60

@interface TimerButton : UIButton


-(NSInteger)initCodeTime;
-(void)useTimerButton;
-(void)showTimer;
@end
