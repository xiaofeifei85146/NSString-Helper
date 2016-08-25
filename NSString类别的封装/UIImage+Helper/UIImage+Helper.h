//
//  UIImage+Helper.h
//  NSString类别的封装
//
//  Created by Teplot_03 on 16/8/25.
//  Copyright © 2016年 Teplot_03. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ALAsset;

@interface UIImage (Helper)

+ (UIImage *)getLocalGifPictureWithAsset:(ALAsset *)asset;

+ (NSData *)getLocalGifDataPictureWithAsset:(ALAsset *)asset;

@end
