//
//  NSFileManager+Helper.h
//  NSString类别的封装
//
//  Created by Teplot_03 on 16/8/25.
//  Copyright © 2016年 Teplot_03. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    FileTypePNG,
    FileTypeJPEG,
    FileTypeGIF,
    FileTypeWAV,
    FileTypeMP3,
    FileTypeMOV,
    FileTypeMP4,
    FileTypeAVI,
    FileType3GP,
} FileType;

typedef void (^FileBlock) (NSString *);

@interface NSFileManager (Helper)


#pragma mark - 保存文件
- (void)saveFile:(id)file FileType:(FileType)fileType BlockFileName:(FileBlock)block;

#pragma mark - 获取文件

#pragma mark - 获取文件大小

#pragma mark - 获取文件夹下所有文件

#pragma mark - 获取文件夹缓存


@end
