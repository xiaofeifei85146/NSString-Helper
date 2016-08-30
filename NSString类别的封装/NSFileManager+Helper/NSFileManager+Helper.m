//
//  NSFileManager+Helper.m
//  NSString类别的封装
//
//  Created by Teplot_03 on 16/8/25.
//  Copyright © 2016年 Teplot_03. All rights reserved.
//

#import "NSFileManager+Helper.h"
#import "NSString+Helper.h"
#import <UIKit/UIKit.h>

@implementation NSFileManager (Helper)


- (void)saveFile:(id)file FileType:(FileType)fileType BlockFileName:(FileBlock)block {
    NSString *timeString = [NSString timeStringWithDateFormatterStyle:TimeStringFormatterStyleCurrentDateNoSymbol];
    
    NSMutableString *fileName = [NSMutableString stringWithString:timeString];
    
    if ([file isKindOfClass:[UIImage class]]) {
        UIImage *img = (UIImage *)file;
        NSData *imgData = nil;
        switch (fileType) {
            case FileTypePNG:
            {
                imgData = UIImagePNGRepresentation(img);
                [fileName stringByAppendingString:@".PNG"];
            }
                break;
                
            case FileTypeJPEG:
            {
                imgData = UIImageJPEGRepresentation(img, 0.5);
                [fileName stringByAppendingString:@".JPG"];
            }
                break;
                
            case FileTypeGIF://暂不支持gif本地存储
            {
                //将animationImage转化为data之后存储
                NSAssert(1, @"暂不支持gif图片存储");

                [fileName stringByAppendingString:@".GIF"];
            }
                break;
                
            default:
                break;
        }
        
        BOOL saveOk = [imgData writeToFile:[[NSString pathImgsFolder] stringByAppendingPathComponent:fileName] atomically:YES];
        if (saveOk) {
            block(fileName);
        }
    }
    else if ([file isKindOfClass:[NSData class]]) {
        NSData *data = (NSData *)file;
        NSString *filePath = nil;
        
        switch (fileType) {
            case FileTypeWAV:
            {
                [fileName stringByAppendingString:@".WAV"];
                filePath = [[NSString pathVoicesFolder] stringByAppendingString:fileName];
            }
                break;

            case FileTypeMP3:
            {
                [fileName stringByAppendingString:@".MP3"];
                filePath = [[NSString pathVoicesFolder] stringByAppendingString:fileName];
            }
                break;
                
            case FileType3GP:
            {
                [fileName stringByAppendingString:@".3GP"];
                filePath = [[NSString pathVideosFolder] stringByAppendingString:fileName];
            }
                break;
                
            case FileTypeMP4:
            {
                [fileName stringByAppendingString:@".MP4"];
                filePath = [[NSString pathVideosFolder] stringByAppendingString:fileName];
            }
                break;
                
            case FileTypeMOV:
            {
                [fileName stringByAppendingString:@".MOV"];
                filePath = [[NSString pathVideosFolder] stringByAppendingString:fileName];
            }
                break;
                
            case FileTypeAVI:
            {
                [fileName stringByAppendingString:@".AVI"];
                filePath = [[NSString pathVideosFolder] stringByAppendingString:fileName];
            }
                break;
            default:
                break;
        }
        BOOL saveOk = [data writeToFile:filePath atomically:YES];
        if (saveOk) {
            block(fileName);
        }
    }
}

@end
