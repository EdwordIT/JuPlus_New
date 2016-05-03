//
//  AboutUsViewController.m
//  JuPlus
//
//  Created by admin on 15/10/22.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()
@property (nonatomic,strong)UIImageView *backImg;
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.titleLabel setText:@"关于我们"];
    [self.view addSubview:self.backImg];
    // Do any additional setup after loading the view.
}
-(UIImageView *)backImg
{
    if (!_backImg) {
        _backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, view_height)];
        [_backImg setImage:[UIImage imageNamed:@"AboutUs.jpg"]];
    }
    return _backImg;
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
