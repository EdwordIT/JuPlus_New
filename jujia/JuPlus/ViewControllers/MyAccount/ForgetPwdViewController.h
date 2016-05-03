//
//  ForgetPwdViewController.h
//  JuPlus
//
//  Created by admin on 15/7/20.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusUIViewController.h"
#import "KeyBoardTopBar.h"
#import "JuPlusTextField.h"
#import "TimerButton.h"
@interface ForgetPwdViewController : JuPlusUIViewController
{
    TimerButton *identifyButtom;
    KeyBoardTopBar *keyboardTopBar;
    //界面向上弹出的高度
    int movementDistance;
    
    UILabel *statusLabel;
    
}

@end
