//
//  JuPlusTextField.h
//  JuPlus
//
//  Created by admin on 15/6/23.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JuPlusTextField : UIView<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *headTitleLa;//标题
@property(nonatomic,strong)UITextField *contentField;//field

@end
