//
//  UIImage+Helper.m
//  NSString类别的封装
//
//  Created by Teplot_03 on 16/8/25.
//  Copyright © 2016年 Teplot_03. All rights reserved.
//

#import "UIImage+Helper.h"
#import "UIImage+GIF.h"
#import <ImageIO/ImageIO.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation UIImage (Helper)

/**
 *  取得第三方库中的gif Image
 */

+ (UIImage *)getLocalGifPictureWithAsset:(ALAsset *)asset {
    ALAssetRepresentation *rep = [asset defaultRepresentation];
    Byte *imageBuffer = (Byte*)malloc(rep.size);
    NSUInteger bufferSize = [rep getBytes:imageBuffer fromOffset:0.0 length:rep.size error:nil];
    NSData *imageData = [NSData dataWithBytesNoCopy:imageBuffer length:bufferSize freeWhenDone:YES];
    UIImage *img = [UIImage sd_animatedGIFWithData:imageData];
    //    NSArray *imgsArr = [img images];
    //    NSLog(@"%@",imgsArr);
    return img;
}

+ (NSData *)getLocalGifDataPictureWithAsset:(ALAsset *)asset {
    ALAssetRepresentation *rep = [asset defaultRepresentation];
    Byte *imageBuffer = (Byte*)malloc(rep.size);
    NSUInteger bufferSize = [rep getBytes:imageBuffer fromOffset:0.0 length:rep.size error:nil];
    NSData *imageData = [NSData dataWithBytesNoCopy:imageBuffer length:bufferSize freeWhenDone:YES];
    return imageData;
}

- (NSDictionary *)praseGIFDataToImageArray:(NSData *)data;
{
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    CGImageSourceRef src = CGImageSourceCreateWithData((CFDataRef)data, NULL);
    CGFloat animationTime = 0.f;
    if (src) {
        size_t l = CGImageSourceGetCount(src);
        frames = [NSMutableArray arrayWithCapacity:l];
        for (size_t i = 0; i < l; i++) {
            CGImageRef img = CGImageSourceCreateImageAtIndex(src, i, NULL);
            NSDictionary *properties = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(src, i, NULL));
            NSDictionary *frameProperties = [properties objectForKey:(NSString *)kCGImagePropertyGIFDictionary];
            NSNumber *delayTime = [frameProperties objectForKey:(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
            animationTime += [delayTime floatValue];
            if (img) {
                [frames addObject:[UIImage imageWithCGImage:img]];
                CGImageRelease(img);
            }
        }
        CFRelease(src);
    }
    return @{@"time":@(animationTime),
             @"frames":frames};
}

@end
