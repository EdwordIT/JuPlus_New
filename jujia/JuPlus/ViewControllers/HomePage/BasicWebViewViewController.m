//
//  BasicWebViewViewController.m
//  JuPlus
//
//  Created by admin on 15/10/16.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "BasicWebViewViewController.h"

@interface BasicWebViewViewController ()

@end

@implementation BasicWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.titleLabel setText:self.titleStr];
    [self.view addSubview:self.htmlView];
    // Do any additional setup after loading the view.
}
-(UIWebView *)htmlView
{
    if (!_htmlView) {
        
        _htmlView = [[UIWebView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, view_height)];
        _htmlView.autoresizesSubviews = YES;
        _htmlView.scalesPageToFit = YES;
        
//        NSString *fullURL = [NSString stringWithFormat:@"%@%@/%@",urlString,acId,[CommonUtil getToken]];
        NSURL *url = [NSURL URLWithString:self.htmlUrl];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [_htmlView loadRequest:requestObj];

    }
    return _htmlView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
