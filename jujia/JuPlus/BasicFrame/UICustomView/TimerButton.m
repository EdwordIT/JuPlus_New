//
//  TimerButton.m
//  Autoyol
//
//  Created by Ning Gang on 13-9-14.
//  Copyright (c) 2013年 Autoyol. All rights reserved.
//

#import "TimerButton.h"
#import "JuPlusEnvironmentConfig.h"
@implementation TimerButton
static NSInteger startTime1 = 0;
static NSInteger codeTime = 0; //验证码时间;
static NSTimer * codeTimer;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        
    }
    return self;
}

-(NSInteger)initCodeTime
{
    return SEND_SMS_INTERVAL;
}

-(void)useTimerButton
{
    //change  by zwb  原来写在init事件中，循环会一直存在
    if(startTime1==0)
    {
        codeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(showTimer) userInfo: nil repeats:YES];
    }
    else
    {
        [codeTimer invalidate];
        codeTimer = nil;
        codeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(showTimer) userInfo: nil repeats:YES];
        startTime1 = 0;
        
    }
    codeTime = [self initCodeTime];
    [self setBackgroundImage:nil forState:UIControlStateNormal];
}

-(void)showTimer
{
    NSLog(@"timeButton = %ld",(long)codeTime);
    if (codeTime > 0) {
        codeTime--;
        startTime1 = 1;
    }
    
    if (codeTime <= 0)
    {
        [self setEnabled:YES];
        if(startTime1==1)
        {
            [codeTimer invalidate];
            startTime1 = 0;
        }
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        //[self setTitleColor:[UIColor colorWithRed:ZRF/255 green:ZGF/255 blue:ZBF/255 alpha:1] forState:UIControlStateNormal];
        [self.titleLabel setFont:FontType(FontMaxSize)];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeIdentify" object:nil];
    }
    else {
        [self setEnabled:NO];
   
        [self setTitle:[NSString stringWithFormat: @"%ld 秒", (long)codeTime] forState:UIControlStateNormal];
            
        [self.titleLabel setFont:[UIFont fontWithName:FONTSTYLE size:16.0]];
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
