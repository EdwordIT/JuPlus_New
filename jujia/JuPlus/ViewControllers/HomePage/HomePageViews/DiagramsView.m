//
//  DiagramsView.m
//  JuPlus
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 居+. All rights reserved.
//

#import "DiagramsView.h"
#import "PostFaverReq.h"
#import "FavRespon.h"
#import "DeleteFavReq.h"
#import "LoginViewController.h"
@implementation DiagramsView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 1.f;
        self.layer.borderWidth = 1.5f;
        self.layer.borderColor = [Color_Bottom CGColor];
        [self addSubview:self.diagramsImg];
        [self addSubview:self.textLabel];
        [self addSubview:self.favBtn];
        self.layer.masksToBounds = YES;
    }
    return self;
}
//宏定义命名不能重复，否则项目会报错
CGFloat spaceX = 10.f;
/*
 展示图图片分两种，一种为长方形，宽高比3：4，一种为正方形
 */
-(UIImageView *)diagramsImg
{
    if (!_diagramsImg) {
        _diagramsImg = [[UIImageView alloc]initWithFrame:CGRectMake(spaceX, spaceX, self.width - spaceX*2, self.height - 50.f)];
//        _diagramsImg.layer.masksToBounds = YES;
    }
    return _diagramsImg;
}
-(UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(spaceX,self.height - 50.f, self.diagramsImg.width, 50.f)];
        [_textLabel setFont:FontType(FontSize)];
        _textLabel.numberOfLines = 3;
        _textLabel.textColor = Color_Gray;
    }
    return _textLabel;
}
-(UIButton *)favBtn
{
    if (!_favBtn) {
        _favBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _favBtn.frame = CGRectMake(self.width - 30.f, self.height - 30.f, 25.f, 25.f);
        [_favBtn setImage:[UIImage imageNamed:@"fav_unsel"] forState:UIControlStateNormal];
        [_favBtn setImage:[UIImage imageNamed:@"fav_sel"] forState:UIControlStateSelected];
        [_favBtn addTarget:self action:@selector(favBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _favBtn;
}
//点击收藏按钮
-(void)favBtnPressed:(UIButton *)btn
{
    if ([CommonUtil isLogin]) {
        if(btn.selected){
            [self cancelFav];
        }else{
            [self addFav];
        }
    }else{
        LoginViewController *log = [[LoginViewController alloc]init];
        [[self getSuperViewController].navigationController pushViewController:log animated:YES];
    }
        
   
}
//添加收藏
-(void)addFav
{
    PostFaverReq *req = [[PostFaverReq alloc]init];
    [req setField:[CommonUtil getToken] forKey:TOKEN];
    [req setField:self.diagramesId forKey:@"objNo"];
    [req setField:@"3" forKey:@"objType"];
    JuPlusResponse *respon =[[JuPlusResponse alloc]init];
    [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
        self.favBtn.selected = YES;
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self];
    

}
//取消收藏
-(void)cancelFav
{
    DeleteFavReq *req = [[DeleteFavReq alloc]init];
    JuPlusResponse *respon =[[JuPlusResponse alloc]init];
    [req setField:[CommonUtil getToken] forKey:TOKEN];
    [req setField:self.diagramesId forKey:@"objNo"];
    [req setField:@"3" forKey:@"objType"];
    
    [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
        self.favBtn.selected=NO;
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self];
    
}

-(void)ReloadView:(DiagramsDTO *)dto
{
    self.diagramesId = dto.regNo;
    NSString *imgPath = [NSString stringWithFormat:@"%@%@",FRONT_PICTURE_URL,dto.imgUrl];
    //根据img图片大小决定imageview的大小
    //队列用于处理同步图片加载
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgPath]]];
//        if(image!=nil)
//        {
//            CGRect frame = self.diagramsImg.frame;
//            //图片显示比例
//            CGFloat percentage = image.size.width/frame.size.width;
//            if (image.size.height*3!=image.size.width*4) {
//                //如果是正方形的图，图形居中显示
//                frame.origin.y = (self.height - image.size.height/percentage)/2;
//                frame.size.height = image.size.height/percentage;
//            }else
//            {
//                //如果是长方形的图
//                frame.size.height = ((image.size.width*4)/3)/percentage;
//                frame.origin.y = spaceX;
//                
//            }
//            
//            self.diagramsImg.frame = frame;
//            
//            
//            //    //重置text的起始位置
//            CGRect textFrame = self.textLabel.frame;
//            textFrame.origin.y = self.diagramsImg.bottom +spaceX;
//            //
//            //        CGSize size = [CommonUtil getLabelSizeWithString:dto.textString andLabelWidth:self.textLabel.width andFont:self.textLabel.font];
//            //        textFrame.size.height = size.height;
//            self.textLabel.frame = textFrame;
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                [self.textLabel setText:dto.textString];
//                
//                [self.diagramsImg setImage:image];
//            });
//        }
//        else
//        {
//            
//        }
//    });
    [self.diagramsImg sd_setImageWithURL:[NSURL URLWithString:imgPath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGRect frame = self.diagramsImg.frame;
        self.diagramsImg.image = nil;
        //图片显示比例
        CGFloat percentage = image.size.width/frame.size.width;
        if (image.size.height<=image.size.width) {
            //如果是正方形的图，图形居中显示
//            frame.origin.y = (self.height - image.size.height/percentage)/2;
            frame.origin.y = spaceX;

            frame.size.height = frame.size.width;
        }else
        {
            //如果是长方形的图
            frame.size.height = ((image.size.width*4)/3)/percentage;
            frame.origin.y = spaceX;

        }

        self.diagramsImg.frame = frame;
    

//    //重置text的起始位置
        CGRect textFrame = self.textLabel.frame;
        textFrame.origin.y = self.diagramsImg.bottom +spaceX;

        self.textLabel.frame = textFrame;
        [self.textLabel setText:dto.textString];
        [self.textLabel sizeToFit];
        [self.diagramsImg setImage:image];

    }];
    
}
-(void)reloadFrame
{

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
