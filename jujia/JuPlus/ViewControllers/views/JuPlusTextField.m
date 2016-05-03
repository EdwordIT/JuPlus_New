//
//  JuPlusTextField.m
//  JuPlus
//
//  Created by admin on 15/6/23.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusTextField.h"
#import "JuPlusCustomMethod.h"
#import "UIImage+JuPlusUIImage.h"
#import "UIView+JuPlusUIView.h"
@implementation JuPlusTextField
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    float y=frame.size.height;
    if (self)
    {
        self.userInteractionEnabled=YES;
        
        //标题
        _headTitleLa=[[UILabel alloc]initWithFrame:CGRectMake(0, y -30.0f, 70.0f, 30.0f)];
        _headTitleLa.backgroundColor=[UIColor clearColor];
        _headTitleLa.textAlignment=NSTextAlignmentLeft;
        _headTitleLa.font= FontType(16.0f);
        _headTitleLa.textColor=Color_Black;
        [self addSubview:_headTitleLa];
        
        //field
        _contentField=[[UITextField alloc]initWithFrame:CGRectMake(70.0f, y - 30.0f, self.width - 70.0f, 30.0f)];
        [_contentField setBorderStyle:UITextBorderStyleNone];
        _contentField.secureTextEntry=NO;
        _contentField.textColor=Color_FieldText;
        _contentField.font=FontType(15.0f);
      //  _contentField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//自适应字体
        _contentField.keyboardType=UIKeyboardTypeDefault;
        _contentField.delegate=self;
        _contentField.returnKeyType= UIReturnKeyDone;
        _contentField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:_contentField];
        
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f,self.height -1.0f, self.width, 1.0f)];
        [line setImage:[UIImage imageWithColor:Color_Gray_lines]];
        [self addSubview:line];
        return self;
        
        
    }
    
    
    return self;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //键盘消失
    [textField resignFirstResponder];
    
    return YES;
}
//重载键盘弹出时的方法
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //解决键盘不能输入问题
    if (!textField.window.isKeyWindow) {
        [textField.window makeKeyAndVisible];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
