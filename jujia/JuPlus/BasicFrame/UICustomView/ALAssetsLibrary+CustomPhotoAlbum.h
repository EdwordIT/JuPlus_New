//
//  ALAssetsLibrary+CustomPhotoAlbum.h
//  JuPlus
//
//  Created by admin on 15/9/9.
//  Copyright (c) 2015年 居+. All rights reserved.
//映射到新建相册目录中，得到本项目独有的项目目录

#import <AssetsLibrary/AssetsLibrary.h>

typedef void(^SaveImageCompletion)(NSError* error);


@interface ALAssetsLibrary (CustomPhotoAlbum)

-(void)saveImage:(UIImage*)image toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock;

-(void)addAssetURL:(NSURL*)assetURL toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock;
@end
