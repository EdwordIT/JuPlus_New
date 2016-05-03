//
//  ResetnicknameView.h
//  JuPlus
//
//  Created by admin on 15/7/21.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusUIView.h"

@interface ResetnicknameView : JuPlusUIView
@property (strong, nonatomic) IBOutlet UILabel *titleL;
@property (strong, nonatomic) IBOutlet UILabel *nicknameL;
@property (strong, nonatomic) IBOutlet UITextField *nickTF;
@property (strong, nonatomic) IBOutlet UILabel *messageL;
@property (strong, nonatomic) IBOutlet UIView *topLine;

@property (strong, nonatomic) IBOutlet UIView *bottomLine;
@property (strong, nonatomic) IBOutlet UIButton *sureBtn;

@end
