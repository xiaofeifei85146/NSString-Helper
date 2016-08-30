//
//  NSString+Helper.m
//  NSString类别的封装
//
//  Created by Teplot_03 on 16/8/25.
//  Copyright © 2016年 Teplot_03. All rights reserved.
//

#import "NSString+Helper.h"


@implementation NSString (Helper)

#pragma mark - 手机号码处理
- (NSString *)formatSecretPhoneNumber {
    NSString *orgString = self;
    
    NSMutableString *newString = [NSMutableString stringWithString:orgString];
    [newString replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    return newString;
}

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

/**
 *  将电话号码格式转化
 *
 *  @return 133-3333-3333
 */
- (NSString *)formatTelephone {
    NSMutableString *orgString = [NSMutableString stringWithString:self];
    
    [orgString insertString:@"-" atIndex:3];
    [orgString insertString:@"-" atIndex:8];
    
    NSString *newString = orgString;
    return newString;
}

#pragma mark - 错误码
- (NSString *)errorString {
    NSString *errorString = nil;
    
    switch (self.integerValue) {
        case 3001:
            errorString = @"参数为空";
            break;
            
        case 3002:
            errorString = @"数据异常";
            break;
            
        case 3003:
            errorString = @"无返回结果";
            break;
            
        case 4001:
            errorString = @"账号不存在";
            break;
            
        case 4002:
            errorString = @"密码错误";
            break;
            
        case 4003:
            errorString = @"旧密码错误";
            break;
            
        case 4004:
            errorString = @"SMS服务器内部错误";
            break;
            
        case 4005:
            errorString = @"SMS短信验证失败";
            break;
            
        case 4006:
            errorString = @"账号已存在";
            break;
            
        case 4007:
            errorString = @"账号被禁用";
            break;
            
        case 4008:
            errorString = @"好友已添加";
            break;
            
        case 4009:
            errorString = @"好友关系不存在";
            break;
            
        case 4010:
            errorString = @"非群主";
            break;
            
        case 4012:
            errorString = @"权限不足";
            break;
            
        case 4013:
            errorString = @"群管理员超出人数限制";
            break;
            
        default:
            errorString = [NSString stringWithFormat:@"错误代码:%@",self];
            break;
    }
    
    return errorString;
}

#pragma mark - 字符串截取
- (NSString *)handleStringFromeStartString:(NSString *)startString toEndString:(NSString *)endString {
    NSRange range = [self rangeOfString:startString];
    NSString *string;
    if (range.location != NSNotFound) {
        string = [self substringFromIndex:range.location + range.length];
    }
    
    range = [string rangeOfString:endString];
    if (range.location != NSNotFound) {
        string = [string substringToIndex:range.location];
    }
    return  string;
}

#pragma mark - json字符串与json字典的转换
+ (NSString*)jsonDictionaryToJsonString:(NSDictionary *)dic; {
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)JsonStringToJsonDictionary:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                             options:NSJSONReadingMutableContainers
                                               error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma mark - 获取并创建文件路径

+ (NSString *)pathImgsFolder {
    NSString *imgsPath = [[self getDocumentPath] stringByAppendingPathComponent:@"Images"];
    
    
    BOOL isImgsFolderExit = [fileManger fileExistsAtPath:imgsPath];
    if (!isImgsFolderExit) {
        [self createDirectoryWithPath:imgsPath];
    }
    
    return imgsPath;
}

+ (NSString *)pathVoicesFolder {
    NSString *voicesPath = [[self getDocumentPath] stringByAppendingPathComponent:@"Voices"];
    
    BOOL isVoicesFolderExit = [fileManger fileExistsAtPath:voicesPath];
    if (!isVoicesFolderExit) {
        [self createDirectoryWithPath:voicesPath];
    }
    
    return voicesPath;
}

+ (NSString *)pathVideosFolder {
    NSString *videosPath = [[self getDocumentPath] stringByAppendingPathComponent:@"Videos"];
    
    BOOL isVideosFolderExit = [fileManger fileExistsAtPath:videosPath];
    if (!isVideosFolderExit) {
        [self createDirectoryWithPath:videosPath];
    }
    
    return videosPath;
}

+ (NSString *)getDocumentPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

+ (BOOL)createDirectoryWithPath:(NSString *)path {
    NSError *error = nil;
    [fileManger createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    if (error) {
        NSLog(@"创建文件夹失败:%@",error);
        return NO;
    }
    return YES;
}


#pragma mark - 时间专属

+ (NSString *)timeStringWithDateFormatterStyle:(TimeStringFormatterStyle)timeStringFormatterStyle {
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    switch (timeStringFormatterStyle) {
        case TimeStringFormatterStyleNormal:
        {
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        }
            break;
            
        case TimeStringFormatterStyleCurrentDateNoSymbol:
        {
            [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
        }
            break;
            
        case TimeStringFormatterStyleCurrentDateStyle1:
        {
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        }
            break;
          
        case TimeStringFormatterStyleCurrentDateStyle2:
        {
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
        }
            break;
            
        default:
            break;
    }
    
    
    NSString *timeString = [formatter stringFromDate:date];
    return timeString;
}

#pragma mark - 秒格式转化为正常时间
+ (NSString *)timeFormateWithTimeFormatterStyle:(TimeStringFormatterStyle)timeStringFormatterStyle timeInterval:(long long)ts {
    //首先检验这个时间间隔是秒还是毫秒(是10位还是13位)10000000000
    if (ts>10000000000) {//说明是13位的.先转化为10位的秒
        ts = ts*0.001;
    }
    
    NSString *string = nil;
    switch (timeStringFormatterStyle) {
        case TimeStringFormatterStyleNormal:
        {
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:ts];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            string = [formatter stringFromDate:date];
        }
            break;
            
        case TimeStringFormatterStyleTimeLine:
        {
            NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
            
            int period = (int)(interval - ts);//两个时间点之间的时间间隔
            int perDaySecs = 60*60*24;
            
            if (period>=perDaySecs*365) {
                string = @"一年前";
            }else if (period>=perDaySecs*30) {
                string = [NSString stringWithFormat:@"%d个月前",period/perDaySecs];
            }else if (period>=perDaySecs*7) {
                string = [NSString stringWithFormat:@"%d周前",period/(perDaySecs*7)];
            }else if (period>=perDaySecs) {
                string = [NSString stringWithFormat:@"%d天前",period/perDaySecs];
            }else if (period>=60*60) {
                string = [NSString stringWithFormat:@"%d小时前",period/60*60];
            }else if (period>=60) {
                string = [NSString stringWithFormat:@"%d分钟前",period/60];
            }else {
                string = @"刚刚";
            }
            
        }
            break;
            
        case TimeStringFormatterStyleConversation:
        {
            //是一天的显示上午几点，下午几点，
            //如果是前一天的，显示昨天
            //如果是一周内，显示星期几
            //其他时间显示年／月／日
            NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:ts];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            
            int period = (int)(interval - ts);//两个时间点之间的时间间隔
            int perDaySecs = 60*60*24;
            
            if (period>=perDaySecs*7) {
                [formatter setDateStyle:NSDateFormatterShortStyle];
                [formatter setTimeStyle:NSDateFormatterNoStyle];
                string = [formatter stringFromDate:date];
                
            }else if (period>=perDaySecs) {
                [formatter setDateStyle:NSDateFormatterFullStyle];
                [formatter setTimeStyle:NSDateFormatterNoStyle];
                NSString *fullTime = [formatter stringFromDate:date];
                string = [fullTime substringFromIndex:fullTime.length-3];
                
            }else if (period>=60*60) {
                [formatter setDateStyle:NSDateFormatterNoStyle];
                [formatter setTimeStyle:NSDateFormatterShortStyle];
                string = [formatter stringFromDate:date];
                
            }else {
                string = @"未知的时间";
            }
            
        }
            break;
            
        default:
            break;
    }
    return string;
}


- (NSString *)replaceHtmlString {
    
    NSString *oldStr = self;
    oldStr = [oldStr stringByReplacingOccurrencesOfString:@"&mdash;" withString:@"－"];
    oldStr = [oldStr stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"“"];
    oldStr = [oldStr stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"”"];
    oldStr = [oldStr stringByReplacingOccurrencesOfString:@"&rarr;" withString:@"→"];
    oldStr = [oldStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    oldStr = [oldStr stringByReplacingOccurrencesOfString:@"&hellip;" withString:@"..."];
    oldStr = [oldStr stringByReplacingOccurrencesOfString:@"&quot;" withString:@""""];
    oldStr = [oldStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    oldStr = [oldStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    oldStr = [oldStr stringByReplacingOccurrencesOfString:@"&times;" withString:@"×"];
    oldStr = [oldStr stringByReplacingOccurrencesOfString:@"&divide;" withString:@"÷"];
    oldStr = [oldStr stringByReplacingOccurrencesOfString:@"&yen;" withString:@"¥"];
    oldStr = [oldStr stringByReplacingOccurrencesOfString:@"&sim;" withString:@"∼"];
    oldStr = [oldStr stringByReplacingOccurrencesOfString:@"&middot;" withString:@"·"];
    
    return oldStr;
}

- (BOOL)isEmpty {
    NSString *string = self;
    if (string&&string.length>0) {
        return YES;
    }
    return NO;
}



@end


