//
//  YHUtility.m
//  YHTestDemo
//
//  Created by survivors on 2019/2/21.
//  Copyright © 2019年 survivorsfyh. All rights reserved.
//

#import "YHUtility.h"
#import <CommonCrypto/CommonDigest.h>// MD5

#pragma mark - ************************************** MD5
/**
 MD5 加密

 @param originalString 原始字符串
 @return 加密结果
 */
NSString *YHGenerateMD5KeyNew(NSString *originalString) {
    const char *cStr = [originalString UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0],  result[1],  result[2],  result[3],
             result[4],  result[5],  result[6],  result[7],
             result[8],  result[9],  result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

/**
 MD5 加密

 @param originalString 原始字符串
 @return 加密结果
 */
NSString *YHStringGenerateMD5(NSString *originalString) {
    //首先将字符串转换成UTF-8编码, 因为MD5加密是基于C语言的,所以要先把字符串转化成C语言的字符串
    const char *fooData = [originalString UTF8String];
    //然后创建一个字符串数组,接收MD5的值
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    //计算MD5的值, 这是官方封装好的加密方法:把我们输入的字符串转换成16进制的32位数,然后存储到result中
    /*
     第一个参数:需要加密的字符串
     第二个参数:获取需要加密字符串的长度
     第三个参数:接收结果的数组
     */
    CC_MD5(fooData, (CC_LONG)strlen(fooData), result);
    //创建一个字符串保存加密结果
    NSMutableString *saveResult = [NSMutableString string];
    //从 result 数组中获取加密结果并放到 saveResult 中
    /*
     x 表示十六进制;
     %02x 表示不足两位将用0补齐;
     若多余两位则不影响
     NSLog(@"%02x",0x888);//888
     NSLog(@"%02x",0x4);//04
     */
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [saveResult appendFormat:@"%2s",result];//%02x
    }
    
    return saveResult;
}



#pragma mark - ************************************** Dic & json to conversion method
/**
 *  Dictionaryic -> Json to conversion method
 */
NSString *YHDictionaryToJsonString(NSDictionary *dic) {
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (error) {
        return error.localizedDescription;
    }
    else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

/**
 *  Json -> Dictionary to conversion method
 */
NSDictionary *YHJsonStringToDictionary(NSString *jsonString) {
    if (jsonString == nil) {
        return [NSDictionary dictionary];
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:jsonData
                                                           options:NSJSONReadingMutableContainers
                                                             error:&error];
    
    if (error) {
        NSLog(@"YH JsonString To Dictionary Error: %@", error.localizedDescription);
        
        return [NSDictionary dictionary];
    }
    else {
        return result;
    }
}



#pragma mark - ************************************** Alert 弹框
/**
 弹出消息框来显示消息
 
 @param alertVC 当前视图
 @param message 提示语
 */
void YHShowMessage(UIViewController *alertVC, NSString *title, NSString *message) {
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertCon addAction:action];
    [alertVC presentViewController:alertCon animated:YES completion:^{
        
    }];
}



#pragma mark - ************************************** Times
/**
 获取当前时间(时间戳:[NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]])
 
 @param dateFormat 日期格式(例如:@"yyyy-MM-dd HH:mm:ss")
 @return 时间结果
 */
NSString *YHGetCurrentTime(NSString *dateFormat) {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    
    return [formatter stringFromDate:[NSDate date]];
}

/**
 Date 转 Str
 
 @param date 日期
 @param dateFormat 日期格式
 @return 处理结果
 */
NSString *YHStringFromDate(NSDate *date, NSString *dateFormat) {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [formatter setDateFormat:dateFormat];
    
    return [formatter stringFromDate:date];
}

/**
 Str 转 Date
 
 @param strDate  日期
 @param dateFormat 日期格式
 @return 处理结果
 */
NSDate *YHDateFromString(NSString *strDate, NSString *dateFormat) {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [formatter setDateFormat:dateFormat];
    
    return [formatter dateFromString:strDate];
}

/**
 Str 转 Date(自定义区域)
 
 @param strDate     日期
 @param dateFormat  日期格式
 @param zone        所处区域(八小时时差: [NSTimeZone timeZoneWithAbbreviation:@"UTC"])
 @return 处理结果
 */
NSDate *YHDateFromStringAndZone(NSString *strDate, NSString *dateFormat, NSTimeZone *zone) {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:zone];
    [formatter setDateFormat:dateFormat];
    
    return [formatter dateFromString:strDate];
}

/**
 时间戳转时间(NSDate)
 
 @param interval 时间戳
 @return 时间结果
 */
NSDate *YHIntervalToTime(NSString *interval) {
    if (0 >= [interval intValue]) {
        return [NSDate date];
    }
    else {
        return [NSDate dateWithTimeIntervalSince1970:[interval doubleValue] + 3600 * 8];// 加上八小时的时间差值
    }
}

/**
 时间戳转换时间日期(例如:yyyy-MM-dd HH:mm & yyyy-MM-dd)
 
 yyyy-MM-dd
 yyyy年MM月dd日
 yyyy-MM-dd HH:mm
 yyy年MM月dd日 HH时mm分
 yyyy-MM-dd HH:mm:ss
 yyy年MM月dd日 HH时mm分ss秒
 
 @param interval 时间戳
 @param formDate 日期格式样式(yyyy-MM-dd HH:mm & yyyy-MM-dd)
 @return 时间结果
 */
NSString *YHDateStringWithTimeInterval(NSString *interval, NSString *formDate) {
    if (0 >= [interval length]) {
        return @"";
    }
    else {
        return YHStringFromDate([NSDate dateWithTimeIntervalSince1970:[interval doubleValue]], formDate);
    }
}

/** 时间日期转换 - 当前周*/
NSString * YHNumDaysWeeks(NSDate *nowDate) {
    NSArray * arrWeek=[NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    
    comps = [calendar components:unitFlags fromDate:nowDate];
    
    NSString *dateString = [arrWeek objectAtIndex:[comps weekday] - 1];
    
    return dateString;
}

/** 时间日期转换 - 当前月*/
NSString *YHNumDaysMonth(NSDate *nowDate) {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    
    comps = [calendar components:unitFlags fromDate:nowDate];
    
    int dateStr = (int)[comps month];
    NSString *dateString = [NSString stringWithFormat:@"%d", dateStr];
    
    return dateString;
}

/**
 日期的比较

 @param date        时间1
 @param anotherDate 时间2
 @param dateForm    日期格式样式(yyyy-MM-dd HH:mm & yyyy-MM-dd)
 @return 时间是否一致的结果
 */
BOOL YHComparisonDateTimeIsOneDay(NSDate *date, NSDate *anotherDate, NSString *dateForm) {
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:dateForm];

    NSString *strDate = [fm stringFromDate:date];
    NSString *strAnotherDate = [fm stringFromDate:anotherDate];

    if ([strDate isEqualToString:strAnotherDate]) {
        return YES;
    }
    else {
        return NO;
    }
}

/**
 指定时间距当前时间的时间差
 
 @param date 指定时间
 @return 时间差值
 */
NSInteger YHSpecifiesDifferenceBetweenTimeAndCcurrentTime(NSDate *date) {
    return [[NSNumber numberWithDouble:[date timeIntervalSinceNow]] integerValue];
}

/**
 时间差值计算(时间格式一样)
 
 @param date        时间1
 @param anotherDate 时间2
 @param dateForm    日期格式样式(yyyy/MM/dd/HH:mm:ss & yyyy-MM-dd HH:mm & yyyy-MM-dd)
 @return 时间差值
 */
NSInteger YHComparisonDateTimeDifference(NSDate *date, NSDate *anotherDate, NSString *dateForm) {
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:dateForm];
    
    return [[NSNumber numberWithDouble:[date timeIntervalSinceDate:anotherDate]] integerValue];
}




#pragma mark - ************************************** File(Local) to do somethings
/**
 获取资源全路径

 @param fileName 资源文件名称
 @return 资源文件路径
 */
NSString *YHGetResourcePath(NSString* fileName) {
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingFormat:@"/%@", fileName];
}

/**
 本地文件 - 创建
 
 @param filePath 文件路径
 */
void YHCreateLocalFileWithPath(NSString *filePath) {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:filePath]) {// 校验
            NSError *error;
            
            if ([fileManager createDirectoryAtPath:filePath
                       withIntermediateDirectories:YES
                                        attributes:nil
                                             error:&error]) {
                NSLog(@"本地文件 --- 创建成功\n%@", filePath);
            }
            else {
                NSLog(@"本地文件 --- 创建失败\n%@", error.localizedDescription);
            }
        }
    });
}

/**
 本地文件 - 删除
 
 @param filePath 文件路径
 */
void YHDeleteLocalFileWithPath(NSString *filePath) {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSError *error;
        
        if ([[NSFileManager defaultManager] removeItemAtPath:filePath error:&error]) {
            NSLog(@"本地文件 --- 删除成功");
        }
        else {
            NSLog(@"本地文件 --- 删除失败\n%@", error.localizedDescription);
        }
    });
}

/**
 本地生成 plist 文件(字典 Dic)
 
 @param dataSource      写入数据源
 @param fileName        文件名称
 @param filePath        文件路径
 */
void YHCreateLocalPlistFile(NSMutableDictionary *dataSource, NSString *fileName, NSString *filePath) {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSFileManager *manager = [NSFileManager defaultManager];
        //    [manager createFileAtPath:documentPath contents:[NSJSONSerialization dataWithJSONObject:dataSource options:NSJSONWritingPrettyPrinted error:nil] attributes:nil];
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        NSError *error;
        if ([manager createDirectoryAtPath:[documentPath stringByAppendingPathComponent:filePath] withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"本地生成 plist 文件 --- 创建 --- 成功");
            //将字典对象归档存入文件
            if ([dataSource writeToFile:[[documentPath stringByAppendingPathComponent:filePath] stringByAppendingPathComponent:fileName] atomically:YES]) {
                NSLog(@"本地生成 plist 文件 --- 写入 --- 成功");
                
                //将文件内容读成字典对象
                NSDictionary *plistInfo = [NSDictionary dictionaryWithContentsOfFile:[documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", filePath, fileName]]];
                NSLog(@"The Plist File\nInfo --- %@\nPath --- %@", plistInfo, [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", filePath, fileName]]);
            }
            else {
                NSLog(@"本地生成 plist 文件 --- 写入 --- 失败\nError:%@", error.localizedDescription);
            }
        }
        else {
            NSLog(@"本地生成 plist 文件 --- 创建 --- 失败\nError:%@\nPath:%@", error.localizedDescription, filePath);
        }
    });
}

/**
 插入对象至本地 plist 文件
 
 @param dataSource  数据源
 @param fileName    文件名称
 @param filePath    文件路径
 */
void YHInsertObjectToLocalPlistFile(NSMutableDictionary *dataSource, NSString *fileName, NSString *filePath) {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *docPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", filePath, fileName]];
        
        if ([fileManager fileExistsAtPath:docPath]) {// 文件存在
            NSLog(@"本地 plist 文件 --- 存在");
            
            NSMutableDictionary *result = [NSMutableDictionary dictionaryWithContentsOfFile:docPath];
            [result addEntriesFromDictionary:dataSource];
            
            [result writeToFile:[[documentPath stringByAppendingPathComponent:filePath] stringByAppendingPathComponent:fileName] atomically:YES];
        }
        else {// 文件不存在
            NSLog(@"本地 plist 文件 --- 不存在");
            YHCreateLocalPlistFile(dataSource, fileName, filePath);
        }
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//        });
    });
}

/**
 移除对象至本地 plist 文件
 
 @param key         关键参数
 @param fileName    文件名称
 @param filePath    文件路径
 */
void YHRemoveObjectKeyToLocalPlistFile(NSString *key, NSString *fileName, NSString *filePath) {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *docPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", filePath, fileName]];
        
        if ([fileManager fileExistsAtPath:docPath]) {
            NSMutableDictionary *configInfo = [NSMutableDictionary dictionaryWithContentsOfFile:docPath];
            [configInfo removeObjectForKey:key];
            [configInfo writeToFile:[[documentPath stringByAppendingPathComponent:filePath] stringByAppendingPathComponent:fileName] atomically:YES];
        }
    });
}

/**
 获取对象数据从本地 plist 文件
 
 @param fileName 文件名称
 @param filePath 文件路径
 */
NSMutableDictionary *YHGetObjectDataFormLocalPlistFile(NSString *fileName, NSString *filePath) {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", filePath, fileName]];
    
    NSMutableDictionary *configInfo = [NSMutableDictionary dictionary];
    if ([fileManager fileExistsAtPath:docPath]) {
        configInfo = [NSMutableDictionary dictionaryWithContentsOfFile:docPath];
    }
    return configInfo;
}

/**
 检查文件是否存在：此是ExistAtConfigPath和ExistAtTemporaryPath的综合，但不负责创建路径
 
 @param fileFullPath 文件绝对路径
 @return 结果状态
 */
BOOL YHExistAtPath(NSString* fileFullPath) {
    return [[fileFullPath pathExtension] length] > 0 &&
    [[NSFileManager defaultManager] fileExistsAtPath:fileFullPath];
}



#pragma mark - ************************************** Image to do some things
/**
 将图片存储至本地并返回当前图片路径
 
 @param image       图片资源
 @param imageName   图片名称
 @param imageType   图片类型(png & jpeg)
 @return            存储所在路径
 */
NSString *YHSaveImgFromLocal(UIImage *image, NSString *imageName, NSString *imageType) {
//    if (!image) {  //防止image不存在，存一个占位图
//        image = [UIImage imageNamed:@"posters_default_horizontal"];
//    }
//    if (!imgName) { //防止imgName不存在,获取一个随机字符串
//        imgName = [NSString uuid];
//    }
    
    NSData *imgData;
    if ([imageType isEqualToString:@"png"]) {
        // png
        imgData = UIImagePNGRepresentation(image);
    }
    else {
        // jpeg
        imgData = UIImageJPEGRepresentation(image, 1.0);
    }
    
    // save
    NSString *imgPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, imageType]];
    [imgData writeToFile:imgPath atomically:YES];
    
    return imgPath;
}

/**
 设置颜色的色值
 
 @param color 色值
 @return 处理结果
 */
UIColor *YHColorWithHexString(NSString *color) {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

/**
 根据图片路径加载图片
 
 @param imageName 图片路径
 @return 处理结果
 */
UIImage *YHBUndleImage(NSString* imageName) {
    return [UIImage imageNamed:imageName];
}

/**
 根据图片颜色和尺寸生成图片
 
 @param color   色值
 @param size    尺寸
 @return 处理结果
 */
UIImage *YHCreateImage (UIColor *color, CGSize size) {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 给 UIImage 添加生成圆角图片的扩展API(gView.image = [[UIImage imageNamed:@"test"] YHImageWithCornerRadius:4 , 1.0f];)
 
 @param radius  圆角设置
 @param size    切割比例
 @return 处理结果
 */
UIImage *YHImageWithCornerRadius(CGFloat radius, CGSize size) {
    CGRect rect = (CGRect){0.f, 0.f, size};
    
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 创建圆角矩形路径对象并设置圆角半径
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                    cornerRadius:radius];
//    path.lineWidth = 5.f;
//    path.lineCapStyle = kCGLineCapRound;
//    path.lineJoinStyle = kCGLineCapRound;
    [path stroke];
    
    return image;
}



#pragma mark - ************************************** Text to do some things
/** 计算文字实际宽度*/
float YHCalcTextWidth(UIFont *font, NSString* text, CGFloat width) {
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text
                                                                         attributes:@{NSFontAttributeName:font}];
    
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    
    return ceilf(rect.size.width);
}

/** 计算文字实际高度*/
float YHCalcTextHight(UIFont *font, NSString* text, CGFloat width) {
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text
                                                                         attributes:@{NSFontAttributeName:font}];
    
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    
    return ceilf(rect.size.height);
}

/** 获取拼音首字母(传入汉字字串,返回大写拼音首字母)*/
NSString *firstCharactor(NSString *string) {
    /** 将 string 转成可变字串*/
    NSMutableString *str = [NSMutableString stringWithString:string];
    /** 转为带声调拼音*/
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    /** 转为不带声调拼音*/
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    /** 转为大写拼音*/
    NSString *pinYin = [str capitalizedString];
    /** 获取并返回首字母*/
    return [pinYin substringToIndex:1];
}
