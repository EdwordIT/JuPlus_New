//
//  OrderDetailViewController.m
//  JuPlus
//
//  Created by admin on 15/7/9.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "PlaceOrderReq.h"
#import "PlaceOrderRespon.h"
#import "ReceiveMessageView.h"
#import "productView.h"
#import "productOrderDTO.h"
#import "AddressDTO.h"
#import "PayParamReq.h"
#import "PayParamRespon.h"
#import "Order.h"
#import "DataSigner.h"
#import "ConfirmReq.h"
#import <AlipaySDK/AlipaySDK.h>
#import "SingleDetialViewController.h"
#define space 10.0f
@interface OrderDetailViewController ()
{
    PlaceOrderReq *getReq;
    PlaceOrderRespon *getRespon;
    //上送购买字段
    NSMutableArray *productList;
    //价格总数
    CGFloat priceNum;
    
    NSMutableArray *productArr;
    
    PayParamReq *postReq;
 
    PayParamRespon *postRespon;
    
}
//标题
@property(nonatomic,strong)JuPlusUIView *sectionTitleV;
//内容
@property(nonatomic,strong)UIScrollView *listScrollV;
//所有单品内容
@property(nonatomic,strong)JuPlusUIView *packageV;

@property(nonatomic,strong)JuPlusUIView *bottomV;
//收货地址
@property(nonatomic,strong)ReceiveMessageView *receivedAddressV;
//物流配送信息
@property(nonatomic,strong)JuPlusUIView *logisticsV;
//总金额
@property(nonatomic,strong)JuPlusUILabel *totalAmt;
//状态显示
@property(nonatomic,strong)JuPlusUILabel *statusL;

@property(nonatomic,strong)TabBar_BottomBtn *bottomBtn;
//备注
@property(nonatomic,strong)UIView *remarkView;

@property(nonatomic,strong)UILabel *remarkLabel;
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"订单详情";
    productArr = [[NSMutableArray alloc]init];
    productList = [[NSMutableArray alloc]init];
    //自定义返回事件
    [self.leftBtn setHidden:YES];
    [self addLeftBtn];
    self.view.backgroundColor = RGBCOLOR(239, 239, 239);
    
    [self.view addSubview:self.listScrollV];
    
    [self.listScrollV addSubview:self.sectionTitleV];
    
    [self.listScrollV addSubview:self.packageV];

    [self.listScrollV addSubview:self.bottomV];
    //订单总金额
    [self.bottomV addSubview:self.totalAmt];
    //地址
    [self.bottomV addSubview:self.receivedAddressV];
    //如果有备注
    [self.bottomV addSubview:self.remarkView];
    
    [self.remarkView addSubview:self.remarkLabel];
    
    [self.view addSubview:self.bottomBtn];
    
    
}
#pragma mark --数据刷新
-(void)reloadNetWorkError
{
    [self startRequest];
}
#pragma mark --request
//网络交互
-(void)startRequest
{
    getReq = [[PlaceOrderReq alloc]init];
    [getReq setField:self.orderNo forKey:@"orderNo"];
    [getReq setField:[CommonUtil getToken] forKey:TOKEN];
    getRespon = [[PlaceOrderRespon alloc]init];
    [HttpCommunication request:getReq getResponse:getRespon Success:^(JuPlusResponse *response) {
      //数据加载成功
        [self fileData];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
}
//
-(void)goDetail:(UIButton *)sender
{
    productOrderDTO *dto = [getRespon.productArr objectAtIndex:sender.tag];
    SingleDetialViewController *detail = [[SingleDetialViewController alloc]init];
    detail.regNo = dto.regNo;
    detail.singleId = dto.productNo;
    [self.navigationController pushViewController:detail animated:YES];
}
-(void)fileData
{
    for(int i=0;i<[getRespon.productArr count];i++)
    {
        productOrderDTO *dto = [getRespon.productArr objectAtIndex:i];
        productView *pro = [[productView alloc]initWithFrame:CGRectMake(0.0f, 100.0f*i, _packageV.width, 100.0f)];
        pro.titleL.frame = CGRectMake(pro.titleL.left, pro.titleL.top, 180.0f, pro.titleL.height);
       
        UIButton * topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        topBtn.frame = CGRectMake(0.0f, 0.0f, pro.width, pro.height);
        
        [topBtn addTarget:self action:@selector(goDetail:) forControlEvents:UIControlEventTouchUpInside];
        topBtn.tag = i;
        [pro addSubview:topBtn];
        [pro.countV setHidden:YES];
        [pro.typeLabel setHidden:NO];
        [pro.typeLabel setText:[NSString stringWithFormat:@"X%@",dto.countNum]];
        [pro loadData:dto];
        [self.packageV addSubview:pro];
        [productArr addObject:pro];
    }
    AddressDTO *dto = [[AddressDTO alloc]init];
    dto.addName = getRespon.receictName;
    dto.addAddress = getRespon.receictAddress;
    dto.addMobile = getRespon.receictMobile;
    //发货状态
    [self.statusL setStatus:getRespon.statusTxt];
    
    [self.receivedAddressV setAddressInfo:dto];
    
    [self resetFrames];
    
    NSString *amt = [NSString stringWithFormat:@"  订单总金额：¥%.2f",[getRespon.totalAmt floatValue]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:amt];
    //设置订单总金额几个字的字体以及颜色
    NSDictionary* dic = @{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:FontType(FontSize)};
    [attributedString addAttributes:dic range:[amt rangeOfString:@"订单总金额："]];
    [self.totalAmt setAttributedText:attributedString];
    
}

-(void)resetFrames
{
    if ([getRespon.status  intValue]==5) {
        [self.bottomBtn setHidden:NO];
        [self.bottomBtn setTitle:@"继续支付" forState:UIControlStateNormal];
        
    }else if([getRespon.status intValue]==20)
    {
        [self.bottomBtn setHidden:NO];
        [self.bottomBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        
    }else
    {
        [self.bottomBtn setHidden:YES];
        self.listScrollV.frame = CGRectMake(self.listScrollV.left, self.listScrollV.top, self.listScrollV.width, view_height);
    }
    CGFloat logstics ;
    //如果是已发货
    if ([getRespon.status integerValue]==20) {
        logstics = 70.f;
        [self.packageV addSubview:self.logisticsV];
    }else
    {
        logstics = 0.f;
        
    }
    CGRect frame = self.packageV.frame;
    frame.size.height = 100.0f*[getRespon.productArr count]+logstics;
    self.packageV.frame = frame;
    if ([getRespon.status integerValue]==20)
    self.logisticsV.frame = CGRectMake(0.0f, self.packageV.height - logstics, SCREEN_WIDTH, logstics);
//备注信息展示
    if (IsStrEmpty(getRespon.remark)) {
        self.remarkView.frame = CGRectMake(self.remarkView.left, self.remarkView.top, self.remarkView.width, 0.0f);
        [self.remarkView removeFromSuperview];
    }else{

        NSString *remark = getRespon.remark;
        CGSize remarkSize = [CommonUtil getLabelSizeWithString:remark andLabelWidth:self.remarkLabel.width andFont:self.remarkLabel.font];
        CGRect frame = self.remarkLabel.frame;
        frame.size.height = remarkSize.height;
        self.remarkLabel.frame = frame;
        [self.remarkLabel setText:remark];
        self.remarkView.frame = CGRectMake(self.remarkView.left, self.remarkView.top, self.remarkView.width, 30.f+remarkSize.height);
    }
    CGFloat bottomHeight;
    bottomHeight = MAX(self.listScrollV.height - self.packageV.bottom, self.remarkView.bottom+space);
    
    self.bottomV.frame = CGRectMake(0.0f, self.packageV.bottom, self.totalAmt.width, bottomHeight);

    [self.listScrollV setContentSize:CGSizeMake(self.listScrollV.width, self.bottomV.bottom)];
}

#pragma mark --UI
-(void)addLeftBtn
{
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0.0f, self.navView.height -44.0f, 44.0f, 44.0f);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backPress) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:leftBtn];

}
-(UIView *)remarkView
{
    if (!_remarkView) {
        _remarkView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, self.receivedAddressV.bottom+space, SCREEN_WIDTH, 60.0f)];
        _remarkView.backgroundColor = Color_White;
       UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0.f, SCREEN_WIDTH ,20.0f)];
        titleLabel.numberOfLines = 0;
        [titleLabel setFont:FontType(FontSize)];
        [titleLabel setTextColor:Color_Gray];
        [titleLabel setText:@"  备注:"];
        [_remarkView addSubview:titleLabel];
    }
    return _remarkView;
}
-(UILabel *)remarkLabel
{
    if (!_remarkLabel) {
        _remarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(space, 25.0f, (SCREEN_WIDTH - space*2),20.0f)];
        _remarkLabel.numberOfLines = 0;
        [_remarkLabel setFont:FontType(FontSize)];
        [_remarkLabel setTextColor:Color_Gray];
    }
    return _remarkLabel;
}
-(TabBar_BottomBtn *)bottomBtn
{
    if(!_bottomBtn)
    {
        _bottomBtn = [[TabBar_BottomBtn alloc]init];
        [_bottomBtn setTitle:@"继续支付" forState:UIControlStateNormal];
        [_bottomBtn addTarget:self action:@selector(bottomBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}
-(void)bottomBtnPress:(UIButton *)sender
{
    //点击继续支付
    if ([getRespon.status intValue]==5) {
        //继续付款
        [self continuePay];
    }else if([getRespon.status integerValue]==20){
        //点击确认收货
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Remind_Title message:@"请确认是否已收货" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alert.tag = 20;
        [alert show];
    }

}
//确认收货
-(void)comfirmPay
{
    ConfirmReq *req = [[ConfirmReq alloc]init];
    [req setField:[CommonUtil getToken] forKey:TOKEN];
    [req setField:self.orderNo forKey:@"orderNo"];
    JuPlusResponse *respon = [[JuPlusResponse alloc]init];
    [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
        [self startRequest];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
    
}
-(void)continuePay
{
    postReq = [[PayParamReq alloc]init];
    postRespon = [[PayParamRespon alloc]init];
    [postReq setField:[CommonUtil getToken] forKey:TOKEN];
    [postReq setField:getRespon.realAmt forKey:@"realAmt"];
    //订单号
    [postReq setField:self.orderNo forKey:@"orderNo"];
    
    [postReq setField:@"1" forKey:@"payType"];//支付类型-支付宝快捷支付
    
    
    [HttpCommunication request:postReq getResponse:postRespon Success:^(JuPlusResponse *response) {
        
        [self goAlipay];
        
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
    
    
}
-(void)goAlipay
{
    Order *order = [[Order alloc] init];
    order.partner = postRespon.alipay.partner;
    order.seller = postRespon.alipay.partner;
    order.tradeNO = postRespon.orderNo; //订单ID（由商家自行制定）
    order.amount = postRespon.totalAmt; //商品价格
    order.notifyURL =  postRespon.alipay.notify_url; //回调URL
    
    //    order.productName = @"居＋订单"; //商品标题
    //    order.productDescription = @"居＋订单"; //商品描述
    //
    //    order.service = @"mobile.securitypay.pay";
    //    order.paymentType = @"1";
    //    order.inputCharset = @"utf-8";
    //    order.itBPay = @"30m";
    //    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = ALI_APPKEY;
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(postRespon.alipay.private_key);
    NSString *signedString = [signer signString:orderSpec];
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderSpec, signedString, @"RSA"];
        /*打开支付宝支付协议，callBack为回调方法，返回不同的状态吗做不同的处理*/
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            //支付宝返回之后，跳转到详情界面
            NSLog(@"reslut = %@",resultDic);
            NSLog(@"resultReason = %@",[resultDic objectForKey:@"memo"]);
            //            if ([[resultDic objectForKey:@"error_code"] isEqualToString:@"9000"]) {
            //                [self startRequest];
            //            }else
            //                [self showAlertView:[resultDic objectForKey:@"memo"] withTag:0];
            [self startRequest];
        }];
        
    }
    
}
-(void)backPress
{
    if(self.isFromPlaceOrder)
    {
        
        NSArray *vcArr = [self.navigationController viewControllers];
        UIViewController *vc = [vcArr objectAtIndex:[vcArr count]-3];
        [self.navigationController popToViewController:vc animated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//标题
-(JuPlusUIView *)sectionTitleV
{
    if(!_sectionTitleV)
    {
        _sectionTitleV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(space, 0.0f, self.view.width - space*2, 30.0f)];
        JuPlusUILabel *left = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 70.0f, 30.0f)];
        [left setFont:FontType(14.0f)];
        [left setTextColor:Color_Gray];
        [left setText:@"单品详情"];
        [_sectionTitleV addSubview:left];
        
        self.statusL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(left.right, 0.0f, 70.0f, 30.0f)];
        [self.statusL setFont:FontType(FontSize)];
        [self.statusL setTextColor:Color_Basic];
        self.statusL.userInteractionEnabled = YES;
        [_sectionTitleV addSubview:self.statusL];
       
        JuPlusUILabel *right = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(_sectionTitleV.width - 100.0f, 0.0f, 100.0f, 30.0f)];
        [right setFont:FontType(14.0f)];
        [right setTextColor:Color_Gray];
        [right setText:@"发件数量"];
        right.textAlignment = NSTextAlignmentRight;
        [_sectionTitleV addSubview:right];
        JuPlusUIView *line = [[JuPlusUIView alloc]initWithFrame:CGRectMake(left.left, _sectionTitleV.bottom -1.0f, _sectionTitleV.width, 1.0f)];
        [line setBackgroundColor:Color_Gray_lines];
        [_sectionTitleV addSubview:line];
    }
    return _sectionTitleV;
}
//滑动层
-(UIScrollView *)listScrollV
{
    if (!_listScrollV) {
        _listScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH , view_height - TABBAR_HEIGHT)];
        _listScrollV.backgroundColor = Color_White;
    }
    
    return _listScrollV;
}
-(JuPlusUIView *)packageV
{
    if(!_packageV)
    {
        _packageV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(space,self.sectionTitleV.bottom, SCREEN_WIDTH - space*2, 100.0f)];
        _packageV.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tagGes:)];
    }
    return _packageV;
}
-(JuPlusUIView *)logisticsV
{
    if(!_logisticsV)
    {
        _logisticsV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.packageV.height - 40.0f, self.packageV.width, 70.0f)];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, _logisticsV.width, 1.0f)];
        [view setBackgroundColor:Color_Gray_lines];
        [_logisticsV addSubview:view];
        
        UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
        [titleL setText:@"配送信息"];
        [titleL setTextColor:Color_Gray];
        [titleL setFont:FontType(FontSize)];
        [_logisticsV addSubview:titleL];
        
        UILabel *companyL = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, titleL.bottom, _logisticsV.width, 20.0f)];
        [companyL setTextColor:Color_Gray];
        [companyL setFont:FontType(FontMinSize)];
        [companyL setText:[NSString stringWithFormat:@"信息来源：%@",getRespon.logCompany]];
        [_logisticsV addSubview:companyL];
        UILabel *waybillL = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, companyL.bottom, _logisticsV.width, 20.0f)];
        [waybillL setTextColor:Color_Gray];
        [waybillL setFont:FontType(FontMinSize)];
        [waybillL setText:[NSString stringWithFormat:@"运单编号：%@",getRespon.waybill]];
        [_logisticsV addSubview:waybillL];

        
    }
    return _logisticsV;
}
//收货地址
-(JuPlusUIView *)receivedAddressV
{
    if(!_receivedAddressV)
    {
        _receivedAddressV =[[ReceiveMessageView alloc]initWithFrame:CGRectMake(0.0f, self.totalAmt.bottom+space, SCREEN_WIDTH, 60.0f)];
        
    }
    return _receivedAddressV;
}
-(JuPlusUIView *)bottomV
{
    if (!_bottomV) {
        _bottomV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.listScrollV.width, 100.0f)];
        [_bottomV setBackgroundColor:RGBCOLOR(239, 239, 239)];
        
        }
    return _bottomV;
}
-(JuPlusUILabel *)totalAmt
{
    if (!_totalAmt) {
        _totalAmt = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(0.0f, space, self.bottomV.width, 50.0f)];
        [_totalAmt setFont:[UIFont systemFontOfSize:FontSize]];
        _totalAmt.textColor = Color_Basic;
        _totalAmt.backgroundColor = [UIColor whiteColor];
    }
    return _totalAmt;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --alertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [super alertView:alertView clickedButtonAtIndex:buttonIndex];
    if (alertView.tag==20) {
        if (buttonIndex==1) {
            [self comfirmPay];
        }
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }
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
