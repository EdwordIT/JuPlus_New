//
//  PlaceOrderViewController.m
//  JuPlus
//
//  Created by admin on 15/6/29.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "PlaceOrderViewController.h"
#import "productView.h"
#import "PlaceOrderReq.h"
#import "PlaceOrderRespon.h"
#import "ReceiveMessageView.h"
#import "PostOrderReq.h"
#import "PostOrderRespon.h"
#import "OrderDetailViewController.h"
#import "AddressControlViewController.h"
#import "GetAddressListReq.h"
#import "GetAddressRespon.h"
#import "AddressDTO.h"
#import "AddAddressViewController.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "PayMethodView.h"
#import "InfoChangeV.h"
#import "CouponListViewController.h"
#import "ProductListTab.h"
#import "OrderInsureReq.h"
#import "OrderInsureRespon.h"

#define space 20.0f
@interface PlaceOrderViewController ()<UITextViewDelegate>
{
    PostOrderReq *postReq;
    PostOrderRespon *postRespon;
    //上送购买字段
    NSMutableArray *productList;
    //价格总数
    CGFloat priceNum;
    
    GetAddressListReq *addReq;
    GetAddressRespon *addRespon;
    //订单信息确认
    OrderInsureReq *insureReq;
    OrderInsureRespon *insureRespon;
    
    NSArray *couponArray;
    CouponItem *couponItem;
    
    NSString *totalAmt;
}
//标题
@property(nonatomic,strong)JuPlusUIView *sectionTitleV;
//内容
@property(nonatomic,strong)UIScrollView *listScrollV;
//单品列表
@property(nonatomic,strong)ProductListTab *productTab;
//收货地址
@property(nonatomic,strong)ReceiveMessageView *receivedAddressV;

@property(nonatomic,strong)UIButton *addAddressBtn;
//确认下单
@property(nonatomic,strong)JuPlusUIView *placeOrderV;
//总价
@property(nonatomic,strong)JuPlusUILabel *totalPriceL;

@property(nonatomic,strong)UIButton *postOrderBtn;
//得到收货地址列表
@property(nonatomic,strong)NSArray *dataArray;
//支付方式
@property(nonatomic,strong)PayMethodView *payMethodView;
//优惠券选择
@property(nonatomic,strong)InfoChangeV *couponView;
//
@property(nonatomic,strong)UIView *signView;
//备注
@property(nonatomic,strong)UITextView *signTF;

@property(nonatomic,strong)UILabel *placeL;
@end

@implementation PlaceOrderViewController
{
    NSMutableArray *productArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"确认订单";
    
    productArr = [[NSMutableArray alloc]init];
    productList = [[NSMutableArray alloc]init];
    self.view.backgroundColor = RGBCOLOR(239, 239, 239);
    
    [self.view addSubview:self.listScrollV];
    
    [self.listScrollV addSubview:self.sectionTitleV];

    [self.listScrollV addSubview:self.productTab];
 
    [self fileData];

    [self.view addSubview:self.placeOrderV];
    
    [self.placeOrderV addSubview:self.totalPriceL];
    
    [self.placeOrderV addSubview:self.postOrderBtn];
    
    [self.listScrollV addSubview:self.receivedAddressV];
    
    [self.listScrollV addSubview:self.payMethodView];
    
    [self.listScrollV addSubview:self.addAddressBtn];
    //支付方式
    [self.listScrollV addSubview:self.payMethodView];
    
    [self.listScrollV addSubview:self.couponView];
    
    [self.listScrollV addSubview:self.signView];
    
    [self.signView addSubview:self.signTF];
    
    [self.signTF addSubview:self.placeL];
    //添加通知中心，观察总价的变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetTotalPrice) name:ResetPrice object:nil];
    //添加通知中心，观察tableView是否加载完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startRequestCoupon) name:loadTabSuccess object:nil];

    //添加通知中心，实时改变地址
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startRequest) name:ReloadAddress object:nil];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
//暂时无购物车，数据从上界面返回
#pragma mark --request
-(void)reloadNetWorkError
{
    [self startRequest];
}
//网络交互
-(void)startRequest
{
    addReq = [[GetAddressListReq alloc]init];
    [addReq setField:[CommonUtil getToken] forKey:TOKEN];
    addRespon = [[GetAddressRespon alloc]init];
    [HttpCommunication request:addReq getResponse:addRespon Success:^(JuPlusResponse *response) {
        self.dataArray = addRespon.addressArray;
      //数据加载成功
        [self fileAddress];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
}
-(void)startRequestCoupon
{
    OrderInsureReq *req = [[OrderInsureReq alloc]init];
    [req setField:[CommonUtil getToken] forKey:TOKEN];
    [req setField:[self getPostList] forKey:@"productList"];
    OrderInsureRespon *respon = [[OrderInsureRespon alloc]init];
    [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
        
        [self.couponView.textL setText:[NSString stringWithFormat:@"%ld张可用",(long)[respon.listArray count]]];
        couponArray = respon.listArray;
        [self.totalPriceL setText:[NSString stringWithFormat:@"总价：¥%.2f",[respon.totalAmt floatValue]]];
        totalAmt = respon.totalAmt;
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
}
//补充地址信息
-(void)fileAddress
{
    UIView *header;
    if([self.dataArray count]==0)
    {
        [self.receivedAddressV setHidden:YES];
        [self.addAddressBtn setHidden:NO];
        header = self.addAddressBtn;
    }
    else
    {
        [self.receivedAddressV setHidden:NO];
        [self.addAddressBtn setHidden:YES];
        header = self.receivedAddressV;
    for (AddressDTO *dto in self.dataArray) {
        if (dto.isDefault) {
            [self.receivedAddressV setAddressInfo:dto];
        }
    }
    }
    header.frame = CGRectMake(header.left, self.productTab.bottom+space/2, header.width, header.height);
    self.payMethodView.frame = CGRectMake(self.payMethodView.left, header.bottom+space/2, self.payMethodView.width, self.payMethodView.height);
    self.couponView.frame = CGRectMake(self.couponView.left, self.payMethodView.bottom+space/2, self.couponView.width, self.couponView.height);
    self.signView.frame = CGRectMake(self.signView.left, self.couponView.bottom+space, SCREEN_WIDTH, 100.f);
    self.listScrollV.contentSize = CGSizeMake(self.listScrollV.width, self.signView.bottom+space/2);

}

-(void)fileData
{
    self.productTab.dataArray = self.regArray;
    [self.productTab reloadData];
    //重置frame
}
#pragma mark changePrice
//-(void)showTotalPrice
//{
//    CGFloat total = 0;
//    for(int i =0;i<[self.regArray count];i++)
//    {
//        productOrderDTO *dto = [self.regArray objectAtIndex:i];
//        total+= [dto.price floatValue]*[dto.countNum integerValue];
//    }
//    [self startRequestCoupon];
//}
//计算总价
-(void)resetTotalPrice
{
    
    [self startRequestCoupon];
}
-(NSString *)getTotalPrice
{
    CGFloat total = 0;
    for(int i =0;i<[self.regArray count];i++)
    {
        CountView *count = [self.productTab.countArray objectAtIndex:i];
        productOrderDTO *dto = [self.regArray objectAtIndex:i];
        total+= [dto.price floatValue]*[count getCountNum];
    }
    return [NSString stringWithFormat:@"%.2f",total];
}
#pragma mark --UI
//标题
-(JuPlusUIView *)sectionTitleV
{
    if(!_sectionTitleV)
    {
        _sectionTitleV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.f, 0.0f, self.view.width , 30.0f)];
        JuPlusUILabel *left = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(space, 0.0f, 100.0f, 30.0f)];
        [left setFont:FontType(14.0f)];
        [left setTextColor:Color_Gray];
        [left setText:@"单品详情"];
        [_sectionTitleV addSubview:left];
        JuPlusUILabel *right = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(_sectionTitleV.width - 100.0f -space, 0.0f, 100.0f, 30.0f)];
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
        _listScrollV.backgroundColor = Color_Bottom;
    }
    
    return _listScrollV;
}
-(ProductListTab *)productTab
{
    if (!_productTab) {
        _productTab = [[ProductListTab alloc]initWithFrame:CGRectMake(0.0f, self.sectionTitleV.bottom, SCREEN_WIDTH, [self.regArray count]*100.0f) style:UITableViewStylePlain];
        _productTab.scrollEnabled = NO;
    }
    return _productTab;
}

//收货地址(如果有)
-(ReceiveMessageView *)receivedAddressV
{
    if(!_receivedAddressV)
    {
        _receivedAddressV =[[ReceiveMessageView alloc]initWithFrame:CGRectMake(0.0f, self.productTab.bottom+space/2, SCREEN_WIDTH, 60.0f)];
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, _receivedAddressV.width, _receivedAddressV.height);
        [btn addTarget:self action:@selector(addressClick:) forControlEvents:UIControlEventTouchUpInside];
        [_receivedAddressV addSubview:btn];
    }
    return _receivedAddressV;
}
//收货地址(如果无)
-(UIButton *)addAddressBtn
{
    if(!_addAddressBtn)
    {
    _addAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addAddressBtn.frame = CGRectMake(0.0f, self.productTab.bottom+20.0f, SCREEN_WIDTH, 30.0f);
    [_addAddressBtn setImage:[UIImage imageNamed:@"add_address"] forState:UIControlStateNormal];
    [_addAddressBtn setTitle:@"请添加收货地址" forState:UIControlStateNormal];
    [_addAddressBtn.titleLabel setFont:FontType(FontMaxSize)];
    [_addAddressBtn setTitleColor:Color_Gray forState:UIControlStateNormal];
    [_addAddressBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,_addAddressBtn.imageView.image.size.width, 0.0, 0.0)];
        [_addAddressBtn addTarget:self action:@selector(addAddressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addAddressBtn;

}
-(PayMethodView *)payMethodView
{
    if (!_payMethodView) {
        _payMethodView = [[PayMethodView alloc]initWithFrame:CGRectMake(0.0f, 10.0f, SCREEN_WIDTH, 80.0f)];
    }
    return _payMethodView;
}
-(InfoChangeV *)couponView
{
    if (!_couponView) {
        _couponView = [[InfoChangeV alloc]initWithFrame:CGRectMake(0.0f, self.payMethodView.bottom+space/2, self.listScrollV.width, 50.0f)];
        [_couponView.titleL setText:@"优惠券"];
        [_couponView.titleL setTextColor:Color_Gray];
        [_couponView.botomV removeFromSuperview];
        [_couponView.clickBtn addTarget:self action:@selector(couponViewPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _couponView;
}
-(UIView *)signView
{
    if (!_signView) {
        _signView = [[UIView alloc]initWithFrame:CGRectMake(0.f, self.couponView.bottom+space, SCREEN_WIDTH, 100.f)];
        _signView.backgroundColor = [UIColor whiteColor];
    }
    return _signView;
}
-(UITextView *)signTF
{
    if (!_signTF) {
        _signTF = [[UITextView alloc]initWithFrame:CGRectMake(space/2, space/2, self.signView.width - space, self.signView.height - space)];
        _signTF.layer.borderColor =  [Color_Gray_lines CGColor];
        _signTF.layer.borderWidth = 1.f;
        _signTF.layer.cornerRadius = 3.f;
        _signTF.delegate = self;
    }
    return _signTF;
}
-(UILabel *)placeL
{
    if (!_placeL) {
        _placeL  = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 5.0f, 50.0f,20.0f)];
        [_placeL setTextColor:Color_Gray];
        [_placeL setText:@"备注..."];
        [_placeL setFont:FontType(FontMaxSize)];
    }
    return _placeL;
}
-(void)textViewDidChange:(UITextView *)textView
{
    if (self.signTF.text.length>0) {
        [self.placeL setHidden:YES];
    }else
        [self.placeL setHidden:NO];
}
#pragma mark --keyboardWillShow
-(void)keyboardWillShow:(NSNotification *)noti
{

    NSDictionary *info = [noti userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGFloat keyboardHeight = [value CGRectValue].size.height;
    [UIView animateWithDuration:ANIMATION animations:^{
        self.view.frame = CGRectMake(0.0f,  - keyboardHeight, self.view.width, self.view.height);
    }];
    
}
-(void)keyboardWillHidden:(NSNotification *)noti
{
    [UIView animateWithDuration:ANIMATION animations:^{
        self.view.frame = CGRectMake(0.0f,  0.0f, self.view.width, self.view.height);
    }];
}
//地址管理点击事件
-(void)addAddressBtnClick:(UIButton *)sender
{
    AddressControlViewController *add = [[AddressControlViewController alloc]init];
    [self.navigationController pushViewController:add animated:YES];
}
//优惠券点击事件
-(void)couponViewPress:(UIButton *)sender
{
    CouponListViewController *list = [[CouponListViewController alloc]init];
    list.isFromOrder = YES;
    list.listArray=couponArray;
    list.selectedId = couponItem.idString;
    [list returnCoupon:^(CouponItem *item) {
        couponItem = item;
        if (item==nil) {
            [self.couponView.textL setText:[NSString stringWithFormat:@"%lu张可用",(unsigned long)[couponArray count]]];
            [self.totalPriceL setText:[NSString stringWithFormat:@"总价：¥%.2f",[totalAmt floatValue]]];
        }else{
        [self.couponView.textL setText:[NSString stringWithFormat:@"%@元",item.amt]];
        [self.totalPriceL setText:[NSString stringWithFormat:@"总价：¥%.2f",[totalAmt floatValue] - [item.amt floatValue]]];
        }
        
    }];
    [self.navigationController pushViewController:list animated:YES];
}
//底部下单条
-(JuPlusUIView *)placeOrderV
{
    if(!_placeOrderV)
    {
        _placeOrderV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, SCREEN_HEIGHT - 44.0f, SCREEN_WIDTH, 44.0f)];
    }
    return _placeOrderV;
}
-(JuPlusUILabel *)totalPriceL
{
    if(!_totalPriceL)
    {
        _totalPriceL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(0.0f,  0.0f,self.placeOrderV.width/2, self.placeOrderV.height)];
        [_totalPriceL setTextColor:Color_Basic];
        [_totalPriceL setFont:[UIFont systemFontOfSize:FontMaxSize]];
        [_totalPriceL setBackgroundColor:Color_White];
        _totalPriceL.textAlignment = NSTextAlignmentCenter;
    }
    return _totalPriceL;
}
-(UIButton *)postOrderBtn
{
    if(!_postOrderBtn)
    {
        _postOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _postOrderBtn.frame = CGRectMake(self.totalPriceL.right, 0.0f, self.placeOrderV.width/2, self.placeOrderV.height);
        [_postOrderBtn setBackgroundColor:Color_Pink];
        [_postOrderBtn setTitle:@"确认下单" forState:UIControlStateNormal];
        [_postOrderBtn.titleLabel setFont:FontType(16.0f)];
        _postOrderBtn.alpha = ALPHLA_BUTTON;
        [_postOrderBtn setTitleColor:Color_White forState:UIControlStateNormal];
        if([self.regArray count]==0)
        {
            [_postOrderBtn setBackgroundColor:Color_Gray];
        }
        else
        [_postOrderBtn addTarget:self action:@selector(postPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _postOrderBtn;
}
#pragma mark --btnClick
-(void)addressClick:(UIButton *)sender
{
    AddressControlViewController *control = [[AddressControlViewController alloc]init];
    [self.navigationController pushViewController:control animated:YES];
}
//点击下单按钮弹出下单成功提示
-(void)postPressed:(UIButton *)sender
{
    if (self.receivedAddressV.hidden) {
        [self showAlertView:@"请先添加收货地址" withTag:0];
    }
    else if([self.regArray count]==0)
    {
    
    }
    else
    {
           postReq = [[PostOrderReq alloc]init];
    postRespon = [[PostOrderRespon alloc]init];
    [postReq setField:[CommonUtil getToken] forKey:TOKEN];
    if (self.signTF.text.length>0) {
        [postReq setField:self.signTF.text forKey:@"remark"];
        }else
        [postReq setField:@"" forKey:@"remark"];
  

    [postReq setField:@"1" forKey:@"payType"];//支付类型-支付宝快捷支付
        [postReq setField:couponItem.idString?:@"0" forKey:@"couponId"];
    //收货人信息
    [postReq setField:[NSString stringWithFormat:@"%ld",(long)self.receivedAddressV.tag] forKey:@"receiverId"];
    [postReq setField:[self getPostList] forKey:@"productList"];
    
    [HttpCommunication request:postReq getResponse:postRespon Success:^(JuPlusResponse *response) {
        
        [self goAlipay];

        } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
    }
}
-(void)goAlipay
{
    Order *order = [[Order alloc] init];
    order.partner = postRespon.alipay.partner;
    order.seller = postRespon.alipay.partner;
    order.tradeNO = postRespon.orderNo; //订单ID（由商家自行制定）
      order.amount = postRespon.realAmt; //商品价格
    order.notifyURL =  postRespon.alipay.notify_url; //回调URL
    
//    order.productName = @"居＋订单"; //商品标题
//    order.productDescription = @"居＋订单"; //商品描述
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
            [self goOrderDetail];
        }];
        
    }

}
-(void)goOrderDetail
{
    OrderDetailViewController *detail = [[OrderDetailViewController alloc]init];
    detail.orderNo = postRespon.orderNo;
    detail.isFromPlaceOrder = YES;
    [self.navigationController pushViewController:detail animated:YES];

}
-(NSArray *)getPostList
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for(int i=0;i<[self.productTab.countArray count];i++)
    {
        CountView *count = [self.productTab.countArray objectAtIndex:i];
        productOrderDTO *dto = [self.regArray objectAtIndex:i];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:dto.productNo forKey:@"productNo"];
        [dict setObject:dto.regNo forKey:@"collocatePicNo"];
        [dict setObject:[NSString stringWithFormat:@"%d",[count getCountNum]] forKey:@"productNum"];
        [arr addObject:dict];
    }
    return arr;
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
