//
//  JuPlusEnvironment.h
//  FurnHouse
//
//  Created by 詹文豹 on 15/6/11.
//  Copyright (c) 2015年 居+. All rights reserved.
//环境配置

#ifndef FurnHouse_JuPlusEnvironmentConfig_h
#define FurnHouse_JuPlusEnvironmentConfig_h

//==========================版本内容适配===============================
// 可读的版本号，类似1.0.0
#define VERSION_STRING @"1.2.4"
// 内部版本号，用于和后台匹配接口信息
#define VERSION_INT [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] integerValue]
//系统版本
#define  VERSION [[UIDevice currentDevice].systemVersion doubleValue]
//APP更新地址
#define APP_URL @"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1023270425&mt=8"
#pragma globalConfig
//
#define nav_height 64.0f
#define view_height [UIScreen mainScreen].bounds.size.height - nav_height
//==========================屏幕宽高适配===============================
//屏幕宽、高（用于适配不同机型）
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//图片高度
#define PICTURE_HEIGHT [UIScreen mainScreen].bounds.size.width

#define iPhone5_ANDLATER SCREEN_HEIGHT>=568.0f
#define iphone5 SCREEN_HEIGHT==568.0f
#define iphone6 SCREEN_HEIGHT==667.0f
#define iphone6P SCREEN_HEIGHT==736.0f
//用于下拉加载更多的每页数据数
#define PAGESIZE @"10"

#define ANIMATION 0.3f

#define TABBAR_HEIGHT 44.0f
//==========================字体相关================================
////字体样式
//#define FONTSTYLE @"Heiti SC"
//张海山1
#define FONTSTYLE @"ZHSRXT--GBK1-0"
//张海山2
//#define FONTSTYLE @"ZHSRXT-GBK"
//叶根友特楷
//#define FONTSTYLE @"-"


//基于给定字体样式的字体设置
#define FontType(_ref) [UIFont fontWithName:FONTSTYLE size:(_ref)]

//常用字体大小
#define FontSize 14.0f
#define FontMinSize 12.0f
#define FontMaxSize 16.0f

//=======================================================================
// 连接超时时间，秒
#define CONNECT_TIMEOUT 30
// 数据等待超时时间，秒
#define READ_TIMEOUT 10
#define Progress_tag 2014
//联系客服
#define HELPTELEPHONE @"021-61138651"

#pragma mark --社会化分享
#define UM_APPKey @"55c2fa1067e58e7c850016e6"
//新浪微博
#define SinaAppKey @"34489026"
#define SinaSecret @"efb2084c177517ea8fad51d9e3d7f47a"
//微信分享
#define WeiChatAppKey @"wxf4ab24a1fcf8de97"
#define WeiChatAppSecret @"60bfbcc61019e15292ea0dd7bd1f0546"

#define WeiChatShareUrl @"www.jujiax.com"
//=======================================================================
//地图相关key
#define AMap_Key @"7c69922b6529b508b04254881b926f92"
//=======================================================================

//支付宝接入相关
//=======================================================================
//pkcs8格式的私钥
#define ALI_PKCS8_PRIVATE_KEY @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAMu8JKaadb8axKLKyPUA32bAJjzq6byz2kOSzIx+sIELYCbDVU05IiQJi11ngGR3LwA/SAU7H4nstqdnoidY4sJhWnmfRVnEsXMoifPfvsONzo+SEvnyklVw0IwNQjxp/iWcwXYnftL4cgKlcPqcc+KzwmhqrNaryfm155gpMpBxAgMBAAECgYEAxNyRlaKesABPjPXhZExpkcGNsUNUg5BOEQliOUeZibfSOuJ4JFxWjvfiAGkoeOtpMRX0o4lTmlRu0iejWd3bjTofY4e/FAvkFbu4Bx+zgZZsmuYCBoojzKxUFRfrnsmpPmET4frMI9/BFfqWWpCeo9EUZUeasIoDuE6iWk3bxyECQQDso/T8t2uCK2kRJjHe6a3pLi47DTbQ+LPbFZ0C2V1lYgvIJGFCohZ+atkD2ztdyjq7bOyoPuYLNrB4ekaFIZs1AkEA3GcI0H/13TMzVaFOf/wjgFTcD9hgyns2KkR49xVQ/0okQEAGf+swlG4gx36u/Vy5ZQmxGvQvZcE9ouaqQuYLzQJBAKdH388l+iGyfjtZPLfPiNjlhFjKJo3iwYGF7dAtyA/7F0kMLpTj7/K9pVtMhtLuOkZz4XetvwD+UBFanq9N6mECQQCcEV29fo7UBrh4D1Qt7pYY/n4hvj+zwZG2Vmwt0mtbit2mnW+8zwbEZENT4JH7GNizAizmADk73Z1Op/Wyj4GVAkBEeOg3NRjnCjOMZ9KMyPlsk/FOHqUspFSM0QsKoD2G3bmOj08+0jqtkUWoaBEPSNyGN3EfiAhZ54x/qY2oY0vY"
//接入支付宝应用appKey
#define ALI_APPKEY @"alipay2015091100269512"
//支付宝的公钥
#define ALI_PUBLIC_KEY @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDI6d306Q8fIfCOaTXyiUeJHkrIvYISRcc73s3vF1ZT7XN8RNPwJxo8pWaJMmvyTn9N4HQ632qJBVHf8sxHi/fEsraprwCtzvzQETrNRwVxLO5jVmRGi60j8Ue1efIlzPXV9je9mkjzOmdssymZkh2QhUrCmZYI/FCEa3/cNMW0QIDAQAB"
//=======================================================================
//测试环境
#ifdef kDevTest
//网络请求IP地址
#define FRONT_SERVER_URL @"http://121.40.237.195:8859"
//#define FRONT_SERVER_URL @"http://192.168.0.119"
//H5界面前缀地址
#define FRONT_WEB_URL @""
//图片的前置地址
#define FRONT_PICTURE_URL @"http://jujia-images-test.oss-cn-hangzhou.aliyuncs.com/"
//准生产环境
#elif kUATTest
//网络请求IP地址
#define FRONT_SERVER_URL @""
//H5界面前缀地址
#define FRONT_WEB_URL @""
//图片的前置地址
#define FRONT_PICTURE_URL @""

//正式上线环境
#elif kReleaseH
//网络请求IP地址
#define FRONT_SERVER_URL @"http://121.40.228.199:8859/"
//H5界面前缀地址
#define FRONT_WEB_URL @""
//图片的前置地址
#define FRONT_PICTURE_URL @"http://jujia-images.oss-cn-hangzhou.aliyuncs.com/"

#else

#endif

#endif
