//
//  BasicWebViewViewController.h
//  JuPlus
//
//  Created by admin on 15/10/16.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "BasicUIViewController.h"

@interface BasicWebViewViewController : JuPlusUIViewController
@property (nonatomic,strong)UIWebView *htmlView;

@property (nonatomic,strong)NSString *htmlUrl;

@property (nonatomic,strong)NSString *titleStr;
@end
