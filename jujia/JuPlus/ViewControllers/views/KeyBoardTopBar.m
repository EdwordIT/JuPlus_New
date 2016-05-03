//
//  KeyBoardTopBar.m
//  Autoyol
//
//  Created by Ning Gang on 13-9-14.
//  Copyright (c) 2013年 Autoyol. All rights reserved.
//

#import "KeyBoardTopBar.h"

@implementation KeyBoardTopBar
@synthesize view,nextButtonItem,prevButtonItem,TextFields;
@synthesize currentTextField;

@synthesize delegate = _delegate;
-(id)initWithArray:(NSArray *) array{
	if(self = [super init]) {
        
        
		prevButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上一项" style:UIBarButtonItemStylePlain target:self action:@selector(ShowPrevious)];
		nextButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一项" style:UIBarButtonItemStylePlain target:self action:@selector(ShowNext)];
		hiddenButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(HiddenKeyBoard)];
    
		spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
		view = [[UIToolbar alloc] initWithFrame:CGRectMake(0,480,SCREEN_WIDTH,44)];
		view.barStyle = UIBarStyleBlackTranslucent;
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, view.width, 1.0f)];
        [line setBackgroundColor:RGBCOLOR(197, 197, 197)];
        [view addSubview:line];
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, view.height - 1.0f, view.width, 1.0f)];
        [line1 setBackgroundColor:RGBCOLOR(197, 197, 197)];
        [view addSubview:line1];

        //设置toolBar的背景颜色
        [view setBackgroundImage:[UIImage imageWithColor:Color_White] forToolbarPosition:0 barMetrics:0];
		view.items = [NSArray arrayWithObjects:prevButtonItem,nextButtonItem,spaceButtonItem,hiddenButtonItem,nil];
		allowShowPreAndNext = YES;
//		TextFields = array;
        self.TextFields = [NSMutableArray arrayWithArray:array];
		isInNavigationController = YES;
		self.currentTextField = nil;
        
        for (UITextField * field in array )
        {
            field.inputAccessoryView = self.view;
        }
    }

	return self;
}
-(id) init
{
    if (self=[self initWithArray:nil])
    {
        
    }
    return self;
}
-(void)addTextField:(id)sender
{
    for (int i = 0; i<[TextFields count];i++) {
        if ([TextFields objectAtIndex:i]==sender) {
            return;
        }
    }
    [TextFields addObject:sender];
}
-(void)setTextFieldArray:(NSArray *)array
{
   

//    self.TextFields = array;
    self.TextFields = [NSMutableArray arrayWithArray:array];
    for (UITextField * field in array )
    {
        field.inputAccessoryView = self.view;
    }
    
}
-(void)setIsInNavigationController:(BOOL)isbool{
	isInNavigationController = isbool;
}
-(void)ShowPrevious{
	if (TextFields==nil) {
		return;
	}
	NSInteger num = -1;
	for (NSInteger i=0; i<[TextFields count]; i++) {
		if ([TextFields objectAtIndex:i]==currentTextField) {
			num = i;
			break;
		}
	}
	if (num>0){

		[[TextFields objectAtIndex:num] resignFirstResponder];
        if ([_delegate respondsToSelector:@selector(keyBoardTopBarPrevious:)]) 
        {  
            [_delegate keyBoardTopBarPrevious:[TextFields objectAtIndex:num-1]];
        }
		[[TextFields objectAtIndex:num-1 ] becomeFirstResponder];
		[self ShowBar:[TextFields objectAtIndex:num-1]];
        if ([_delegate respondsToSelector:@selector(keyBoardTopBarButtonPrevious:)]) 
        {  
            [_delegate keyBoardTopBarButtonPrevious:[TextFields objectAtIndex:num-1]];
        }

	}
}
-(void)ShowNext{
	if (TextFields==nil) {
		return;
	}
	NSInteger num = -1;
	for (NSInteger i=0; i<[TextFields count]; i++) {
		if ([TextFields objectAtIndex:i]==currentTextField) {
			num = i;
			break;
		}
	}
	if (num<[TextFields count]-1){
        
		[[TextFields objectAtIndex:num] resignFirstResponder];
        if ([_delegate respondsToSelector:@selector(keyBoardTopBarNext:)]) 
        {  
            [_delegate keyBoardTopBarNext:[TextFields objectAtIndex:num+1]];
        }
		[[TextFields objectAtIndex:num+1] becomeFirstResponder];
		[self ShowBar:[TextFields objectAtIndex:num+1]];
        if ([_delegate respondsToSelector:@selector(keyBoardTopBarButtonNext:)]) 
        {  
            [_delegate keyBoardTopBarButtonNext:[TextFields objectAtIndex:num+1]];
        }

        
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
	}
}
-(void)ShowBar:(UITextField *)textField{
		self.currentTextField = textField;	
	if (allowShowPreAndNext) {
		[view setItems:[NSArray arrayWithObjects:prevButtonItem,nextButtonItem,spaceButtonItem,hiddenButtonItem,nil]];
	}
    
	else {
		[view setItems:[NSArray arrayWithObjects:spaceButtonItem,hiddenButtonItem,nil]];
	}
	if (TextFields==nil) {
		prevButtonItem.enabled = NO;
		nextButtonItem.enabled = NO;
	}
	else {
		NSInteger num = -1;
		for (NSInteger i=0; i<[TextFields count]; i++) {
			if ([TextFields objectAtIndex:i]==currentTextField) {
				num = i;
				break;
			}
		}
		if (num>0) {
			prevButtonItem.enabled = YES;
		}
		else {
			prevButtonItem.enabled = NO;
		}
		if (num<[TextFields count]-1) {
			nextButtonItem.enabled = YES;
		}
		else {
			nextButtonItem.enabled = NO;
		}
	}	
    
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3];
	if (isInNavigationController) {
//		view.frame = CGRectMake(0, 201, 320, 44);
	}
	else {
//		view.frame = CGRectMake(0, 201, 320, 44);
	}	
	[UIView commitAnimations];
}

-(void)setAllowShowPreAndNext:(BOOL)isShow{
	allowShowPreAndNext = isShow;
}

-(void)HiddenKeyBoard{
    if ([_delegate respondsToSelector:@selector(keyBoardTopBarConfirmClicked:)]) 
    {  
        [_delegate keyBoardTopBarConfirmClicked:currentTextField];
    }
	if (currentTextField!=nil) {
		[currentTextField  resignFirstResponder];
	}
    
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3];
    //	view.frame = CGRectMake(0, 480, 320, 44);
	[UIView commitAnimations];

}
- (void)dealloc {
	[view release];
	[TextFields release];
	[prevButtonItem release];
	[nextButtonItem release];
	[hiddenButtonItem release];
	[currentTextField release];
	[spaceButtonItem release];
    [super dealloc];
}
@end
