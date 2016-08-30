//
//  NSString+Helper.h
//  NSString类别的封装
//
//  Created by Teplot_03 on 16/8/25.
//  Copyright © 2016年 Teplot_03. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

#define fileManger [NSFileManager defaultManager]

typedef enum : NSUInteger {
    TimeStringFormatterStyleNormal,                 //!< yyyy-MM-dd HH:mm:ss(双用)
    TimeStringFormatterStyleCurrentDateNoSymbol,    //!< yyyyMMddHHssSSS(获取当前时间字符串)
    TimeStringFormatterStyleCurrentDateStyle1,      //!< yyyy-MM-dd HH:mm(同上)
    TimeStringFormatterStyleCurrentDateStyle2,      //!< yyyy-MM-dd HH:mm:ss:SSS(同上)
    TimeStringFormatterStyleTimeLine,               //!<朋友圈时间显示
    TimeStringFormatterStyleConversation,           //!<会话时间显示（类似微信）
} TimeStringFormatterStyle;



@interface NSString (Helper)

#pragma mark - 一般功能
/**
 *  字符串是否为空
 *
 *  @return YES/NO
 */
- (BOOL)isEmpty;

#pragma mark - 字符串长宽获取
/**
 *  一般用于计算label的frame
 *
 *  @param font 字体大小
 *  @param maxW 限定宽度
 *
 *  @return 文字的宽高
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
/**
 *  不限定字符串宽度的时候获取size
 *
 *  @param font 字体大小
 *
 *  @return 不限定宽度的size
 */
- (CGSize)sizeWithFont:(UIFont *)font;

#pragma mark - 手机号码处理
/**
 *  将电话号码格式转化
 *
 *  @return 133-3333-3333
 */
- (NSString *)formatTelephone;

/**
 *  将电话号码转化为保密的电话号码
 *
 *  @return 保密后的电话号码
 */
- (NSString *)formatSecretPhoneNumber;

#pragma mark - 错误码
/**
 *  错误代码转化为错误信息
 *
 *  @return 错误信息
 */
- (NSString *)errorString;

#pragma mark - 字符串截取与替换
/**
 *  截取两个字符串之间的字符串
 *
 *  @param startString 开头的字符串
 *  @param endString   结尾的字符串
 *
 *  @return 中间的字符串
 */
- (NSString *)handleStringFromeStartString:(NSString *)startString toEndString:(NSString *)endString;

#pragma mark - json字符串与json字典的转换
+ (NSString*)jsonDictionaryToJsonString:(NSDictionary *)dic;

+ (NSDictionary *)JsonStringToJsonDictionary:(NSString *)jsonString;

#pragma mark - 文件路径(私人定制，根据个人习惯)

+ (NSString *)pathImgsFolder;

+ (NSString *)pathVoicesFolder;

+ (NSString *)pathVideosFolder;


#pragma mark - 时间专属

//此部分参考网站：http://www.cnblogs.com/Cristen/p/3599922.html 感谢作者
/**
 *  获取现在时间相应的不同格式的字符串
 *
 *  @param timeStringFormatterStyle 时间格式
 *
 *  @return 所得字符串
 */
+ (NSString *)timeStringWithDateFormatterStyle:(TimeStringFormatterStyle)timeStringFormatterStyle;


#pragma mark - 时间格式转化
/**
 *  聊天和朋友圈相关时间格式转化
 *
 *  @param timeStringFormatterStyle 需要转化为的时间格式
 *  @param ts                       距1970的秒或毫秒
 *
 *  @return 应该转化为的时间字符串
 */
+ (NSString *)timeFormateWithTimeFormatterStyle:(TimeStringFormatterStyle)timeStringFormatterStyle timeInterval:(long long)ts;


- (NSString *)replaceHtmlString;


@end