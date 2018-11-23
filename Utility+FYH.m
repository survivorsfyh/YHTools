//
//  Utility+FYH.m
//  Integration
//
//  Created by survivors on 2018/1/24.
//  Copyright © 2018年 survivors. All rights reserved.
//

#import "Utility+FYH.h"
#import <CommonCrypto/CommonDigest.h>

#pragma mark - 根据图片路径加载图片
extern UIImage* BundleImage(NSString* imageName) {
    return [UIImage imageNamed:imageName];
}

UIColor* colorWithHexString(NSString *color)
{
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

#pragma mark - 弹出消息框来显示消息
void ShowMessage(UIViewController *alertVC, NSString* message) {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *alertAction){
                                                           
                                                       }];
    [alertController addAction:sureAction];
    [alertVC presentViewController:alertController animated:YES completion:nil];
}



#pragma mark - 本地文件 - 创建
/**
 本地文件 - 创建

 @param filePath 文件路径
 */
void CreateLocalFileWithPath(NSString *filePath) {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) {// 校验
        NSError *error = nil;
        
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
}

#pragma mark - 本地文件 - 删除
/**
 本地文件 - 删除

 @param filePath 文件路径
 */
void DeleteLocalFileWithPath(NSString *filePath) {
    NSError *error = nil;
    
    if ([[NSFileManager defaultManager] removeItemAtPath:filePath error:&error]) {
        NSLog(@"本地文件 --- 删除成功");
    }
    else {
        NSLog(@"本地文件 --- 删除失败\n%@", error.localizedDescription);
    }
}



#pragma mark - 本地生成 plist 文件
/**
 本地生成 plist 文件(字典 Dic)

 @param dataSource  写入数据源
 @param fileName    文件名次
 @param filePath    文件路径
 */
void CreateLocalPlistFile(NSMutableDictionary *dataSource, NSString *fileName, NSString *filePath) {
    /*
     NSString*testPath = [testDirectorystringByAppendingPathComponent:@"mytest.txt"];
     
     NSString*string =@"IOS开发hello world";
     
     [fileManagercreateFileAtPath:testPath contents:[string dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
     
     NSString*testPath1 = [testDirectorystringByAppendingPathComponent:@"mytest1.json"];
     
     NSDictionary*dict1 =@{@"姓名":@"jcf",@"性别":@"男"};
     
     NSData*data1 = [NSJSONSerialization dataWithJSONObject:dict1 options:NSJSONWritingPrettyPrinted error:nil];
     
     [fileManager createFileAtPath:testPath1 contents:data1 attributes:nil];
     */
    NSFileManager *manager = [NSFileManager defaultManager];
    //    [manager createFileAtPath:documentPath contents:[NSJSONSerialization dataWithJSONObject:dataSource options:NSJSONWritingPrettyPrinted error:nil] attributes:nil];
    NSError *error;
    if ([manager createDirectoryAtPath:[kDocumentPath stringByAppendingPathComponent:filePath] withIntermediateDirectories:YES attributes:nil error:&error]) {
        NSLog(@"本地生成 plist 文件 --- 创建 --- 成功");
        //将字典对象归档存入文件
        if ([dataSource writeToFile:[[kDocumentPath stringByAppendingPathComponent:filePath] stringByAppendingPathComponent:fileName] atomically:YES]) {
            NSLog(@"本地生成 plist 文件 --- 写入 --- 成功");
            //将文件内容读成字典对象
            NSDictionary *plistInfo = [NSDictionary dictionaryWithContentsOfFile:[kDocumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", filePath, fileName]]];
            NSLog(@"The Plist File\nInfo --- %@\nPath --- %@", plistInfo, [kDocumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", filePath, fileName]]);
        }
        else {
            NSLog(@"本地生成 plist 文件 --- 写入 --- 失败\nError:%@", error.localizedDescription);
        }
    }
    else {
        NSLog(@"本地生成 plist 文件 --- 创建 --- 失败\nError:%@\nPath:%@", error.localizedDescription, filePath);
    }
}

/**
 插入对象至本地 plist 文件
 
 @param dataSource  数据源
 @param fileName    文件名称
 @param filePath    文件路径
 */
void InsertObjectToLocalPlistFile(NSMutableDictionary *dataSource, NSString *fileName, NSString *filePath) {
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//    });
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docPath = [kDocumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", filePath, fileName]];
    if ([fileManager fileExistsAtPath:docPath]) {// 文件存在
        NSLog(@"本地 plist 文件 --- 存在");
        NSMutableDictionary *result = [NSMutableDictionary dictionaryWithContentsOfFile:docPath];
        [result addEntriesFromDictionary:dataSource];
//        [NSString stringWithFormat:@"%@%@", [kDocumentPath stringByAppendingPathComponent:filePath], fileName]
        [result writeToFile:[[kDocumentPath stringByAppendingPathComponent:filePath] stringByAppendingPathComponent:fileName] atomically:YES];
    }
    else {// 文件不存在
        NSLog(@"本地 plist 文件 --- 不存在");
        CreateLocalPlistFile(dataSource, fileName, filePath);
    }
}

/**
 移除对象至本地 plist 文件

 @param key         关键参数
 @param fileName    文件名称
 @param filePath    文件路径
 */
void RemoveObjectKeyToLocalPlistFile(NSString *key, NSString *fileName, NSString *filePath) {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docPath = [kDocumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", filePath, fileName]];
    if ([fileManager fileExistsAtPath:docPath]) {
        NSMutableDictionary *configInfo = [NSMutableDictionary dictionaryWithContentsOfFile:docPath];
        [configInfo removeObjectForKey:key];
        [configInfo writeToFile:[[kDocumentPath stringByAppendingPathComponent:filePath] stringByAppendingPathComponent:fileName] atomically:YES];
    }
}

/**
 获取对象数据从本地 plist 文件

 @param fileName 文件名称
 @param filePath 文件路径
 */
NSMutableDictionary* GetObjectDataFormLocalPlistFile(NSString *fileName, NSString *filePath) {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docPath = [kDocumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", filePath, fileName]];
    NSMutableDictionary *configInfo = [NSMutableDictionary dictionary];
    if ([fileManager fileExistsAtPath:docPath]) {
        configInfo = [NSMutableDictionary dictionaryWithContentsOfFile:docPath];
    }
    return configInfo;
}



#pragma mark - 将图片存储至本地并返回当前图片路径
/**
 将图片存储至本地并返回当前图片路径
 
 @param image       图片资源
 @param imageName   图片名称
 @return            存储所在路径
 */
NSString* saveImgFromLocal(UIImage *image, NSString *imageName) {
//    if (!image) {  //防止image不存在，存一个占位图
//        image = [UIImage imageNamed:@"posters_default_horizontal"];
//    }
//    if (!imgName) { //防止imgName不存在,获取一个随机字符串
//        imgName = [NSString uuid];
//    }
    
    // png 格式
    NSData *imgPng = UIImagePNGRepresentation(image);
    // jepg 格式
//    NSData *imgJepg = UIImageJPEGRepresentation(image, 1.0);
    
    // 写入
    NSString *imgPath = [kCachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", imageName]];
    [imgPng writeToFile:imgPath atomically:YES];
    
    return imgPath;
}



#pragma mark - 获取资源全路径
NSString* ResourcePath(NSString* fileName) {
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingFormat:@"/%@", fileName];
}

#pragma mark - config目录：用来存放时间戳有效期内的景区下载文件:返回全路径
NSString* CatchPath(NSString* fileName) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *mcPaths = [[paths objectAtIndex:0] stringByAppendingString:@"/config_cache"];
    //    [manager createDirectoryAtPath:mcPaths attributes:nil];
    [manager createDirectoryAtPath:mcPaths withIntermediateDirectories:NO attributes:nil error:nil];
    
    return mcPaths;
}

#pragma mark - 检查文件是否存在：此是ExistAtConfigPath和ExistAtTemporaryPath的综合
BOOL ExistAtPath(NSString* fileFullPath) {
    return [[fileFullPath pathExtension] length] > 0 &&
    [[NSFileManager defaultManager] fileExistsAtPath:fileFullPath];
}

NSString* templateFilePathWithUrl(NSString* url) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *mcPaths = [[paths objectAtIndex:0] stringByAppendingString:@"/config_cache"];
    //    [manager createDirectoryAtPath:mcPaths attributes:nil];
    [manager createDirectoryAtPath:mcPaths withIntermediateDirectories:NO attributes:nil error:nil];
    NSString* result = [NSString stringWithFormat:@"%@/%@",  mcPaths,url];
    return result;
}

#pragma mark - 计算文字实际高度
float CalcTextHight(UIFont *font, NSString* text, CGFloat width) {
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text
                                                                         attributes:@{NSFontAttributeName:font}];
    
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    
    return ceilf(rect.size.height);
}

#pragma mark - 计算文字实际宽度
float CalcTextWidth(UIFont *font, NSString* text, CGFloat width) {
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text
                                                                         attributes:@{NSFontAttributeName:font}];
    
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    
    return ceilf(rect.size.width);
}

#pragma mark - 时间日期转换
NSString*  DateStringWithTimeInterval(NSNumber* secs) {
    if ([secs intValue] <= 0) {
        return @"";
    } else {
        return StringFromDate([NSDate dateWithTimeIntervalSince1970:[secs doubleValue]], @"yyyy-MM-dd HH:mm");
    }
}

NSString* DateStringWithTimeIntervalOnlyDay(NSNumber* secs) {
    if ([secs intValue] <= 0) {
        return @"";
    } else {
        return StringFromDate([NSDate dateWithTimeIntervalSince1970:[secs doubleValue]], @"yyyy-MM-dd");
    }
}

#pragma mark - Str & Date 相互转换相关
NSString* StringFromDate(NSDate* aDate, NSString *aFormat) {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [formatter setDateFormat:aFormat];
    NSString *dateString = [formatter stringFromDate:aDate];
    return dateString;
}

NSDate* DateFromString(NSString* string, NSString* aFormat) {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [formatter setDateFormat:aFormat];
    NSDate *date = [formatter dateFromString:string];
    return date;
}

#pragma mark - md5加密
NSString *GenerateMD5KeyNew(NSString *originalString){
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
NSString *stringGenerateMD5(NSString *originalString) {
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
#pragma mark - 当前周
NSString *numDaysWeeks(NSDate *nowDate){
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

#pragma mark - 当前月
NSString *numDaysMonth(NSDate *nowDate) {
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

#pragma mark - 根据图片颜色和尺寸生成图片
UIImage *createImage (UIColor *color, CGSize size) {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
#pragma mark - 给 UIImage 添加生成圆角图片的扩展API
UIImage *fyh_imageWithCornerRadius(CGFloat radius, CGSize size) {
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



#pragma mark - 获取拼音首字母(传入汉字字串,返回大写拼音首字母)
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

#pragma mark - Dictionaryic -> Json to conversion method
NSString *dictionaryToJson(NSDictionary *dic) {
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma mark - Json -> Dictionary to conversion method
NSDictionary *dictionaryWithJsonString(NSString *jsonString) {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
}

#pragma mark - Monitor current network status(注:若需要则需要引用头文件"#import <AFNetworkReachabilityManager.h>")
NSString *AFStringFromNetWorkReachabilityStatus(AFNetworkReachabilityStatus status) {
    switch (status) {
        case AFNetworkReachabilityStatusNotReachable:
            return NSLocalizedStringFromTable(@"Not Reachable", @"AFNetworking", nil);
        case AFNetworkReachabilityStatusReachableViaWWAN:
            return NSLocalizedStringFromTable(@"Reachable via WWAN", @"AFNetworking", nil);
        case AFNetworkReachabilityStatusReachableViaWiFi:
            return NSLocalizedStringFromTable(@"Reachable via WiFi", @"AFNetworking", nil);
        case AFNetworkReachabilityStatusUnknown:
        default:
            return NSLocalizedStringFromTable(@"Unknow", @"AFNetworking", nil);;
    }
}






