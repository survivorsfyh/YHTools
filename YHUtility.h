//
//  YHUtility.h
//  YHTestDemo
//
//  Created by survivors on 2019/2/21.
//  Copyright © 2019年 survivorsfyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - ************************************** Basic
/**
 * 捕获程序异常
 * 调用：NSSetUncaughtExceptionHandler(&YHGetException);
 */
extern void YHGetException(NSException *exception);



#pragma mark - ************************************** MD5
/** MD5 加密*/
extern NSString *YHGenerateMD5KeyNew(NSString *originalString);
/** MD5 加密*/
extern NSString *YHStringGenerateMD5(NSString *originalString);



#pragma mark - ************************************** Dic & json to conversion method
/**
 *  Dictionaryic -> Json to conversion method
 */
extern NSString *YHDictionaryToJsonString(NSDictionary *dic);
/**
 *  Json -> Dictionary to conversion method
 */
extern NSDictionary *YHJsonStringToDictionary(NSString *jsonString);



#pragma mark - ************************************** Alert 弹框
/**
 弹出消息框来显示消息
 
 @param alertVC 当前视图
 @param message 提示语
 */
extern void YHShowMessage(UIViewController *alertVC, NSString *title, NSString *message);



#pragma mark - ************************************** Times
/**
 获取当前时间(时间戳:[NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]])

 @param dateFormat 日期格式(例如:@"yyyy-MM-dd HH:mm:ss")
 @return 时间结果
 */
extern NSString *YHGetCurrentTime(NSString *dateFormat);

/**
 Date 转 Str

 @param date        日期
 @param dateFormat  日期格式
 @return 处理结果
 */
extern NSString *YHStringFromDate(NSDate *date, NSString *dateFormat);

/**
 Str 转 Date

 @param strDate     日期
 @param dateFormat  日期格式
 @return 处理结果
 */
extern NSDate *YHDateFromString(NSString *strDate, NSString *dateFormat);

/**
 Str 转 Date(自定义区域)
 
 @param strDate     日期
 @param dateFormat  日期格式
 @param zone        所处区域(八小时时差: [NSTimeZone timeZoneWithAbbreviation:@"UTC"])
 @return 处理结果
 */
extern NSDate *YHDateFromStringAndZone(NSString *strDate, NSString *dateFormat, NSTimeZone *zone);

/**
 时间戳转时间(NSDate)

 @param interval 时间戳
 @return 时间
 */
extern NSDate *YHIntervalToTime(NSString *interval);

/**
 时间戳转换时间,时间格式自定义(例如:yyyy-MM-dd HH:mm & yyyy-MM-dd)
 
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
extern NSString *YHDateStringWithTimeInterval(NSString *interval, NSString *formDate);

/** 时间日期转换 - 当前周*/
extern NSString * YHNumDaysWeeks(NSDate *nowDate);

/** 时间日期转换 - 当前月*/
extern NSString *YHNumDaysMonth(NSDate *nowDate);

/**
 日期的比较

 @param date        时间1
 @param anotherDate 时间2
 @param dateForm    日期格式样式(yyyy-MM-dd HH:mm & yyyy-MM-dd)
 @return 时间是否一致的结果
 */
extern BOOL YHComparisonDateTimeIsOneDay(NSDate *date, NSDate *anotherDate, NSString *dateForm);

/**
 指定时间距当前时间的时间差
 
 @param date 指定时间
 @return 时间差值
 */
extern NSInteger YHSpecifiesDifferenceBetweenTimeAndCcurrentTime(NSDate *date);

/**
 时间差值计算(时间格式一样)
 
 @param date        时间1
 @param anotherDate 时间2
 @param dateForm    日期格式样式(yyyy-MM-dd HH:mm & yyyy-MM-dd)
 @return 时间差值
 */
extern NSInteger YHComparisonDateTimeDifference(NSDate *date, NSDate *anotherDate, NSString *dateForm);



#pragma mark - ************************************** File(Local) to do somethings
/** 获取资源全路径*/
extern NSString *YHGetResourcePath(NSString* fileName);

/**
 本地文件 - 创建
 
 @param filePath 文件路径
 */
extern void YHCreateLocalFileWithPath(NSString *filePath);

/**
 本地文件 - 删除
 
 @param filePath 文件路径
 */
extern void YHDeleteLocalFileWithPath(NSString *filePath);

/**
 本地生成 plist 文件(字典 Dic)
 
 @param dataSource      写入数据源
 @param fileName        文件名称
 @param filePath        文件路径
 */
extern void YHCreateLocalPlistFile(NSMutableDictionary *dataSource, NSString *fileName, NSString *filePath);

/**
 插入对象至本地 plist 文件
 
 @param dataSource  数据源
 @param fileName    文件名称
 @param filePath    文件路径
 */
extern void YHInsertObjectToLocalPlistFile(NSMutableDictionary *dataSource, NSString *fileName, NSString *filePath);

/**
 移除对象至本地 plist 文件
 
 @param key         关键参数
 @param fileName    文件名称
 @param filePath    文件路径
 */
extern void YHRemoveObjectKeyToLocalPlistFile(NSString *key, NSString *fileName, NSString *filePath);

/**
 获取对象数据从本地 plist 文件
 
 @param fileName 文件名称
 @param filePath 文件路径
 */
extern NSMutableDictionary *YHGetObjectDataFormLocalPlistFile(NSString *fileName, NSString *filePath);

/**
 检查文件是否存在：此是ExistAtConfigPath和ExistAtTemporaryPath的综合，但不负责创建路径

 @param fileFullPath 文件绝对路径
 @return 结果状态
 */
extern BOOL YHExistAtPath(NSString* fileFullPath);



#pragma mark - ************************************** Image to do some things
/**
 将图片存储至本地并返回当前图片路径
 
 @param image       图片资源
 @param imageName   图片名称
 @param imageType   图片类型(png & jpeg)
 @return            存储所在路径
 */
extern NSString *YHSaveImgFromLocal(UIImage *image, NSString *imageName, NSString *imageType);

/**
 设置颜色的色值

 @param color 色值
 @return 处理结果
 */
extern UIColor *YHColorWithHexString(NSString *color);

/**
 根据图片路径加载图片

 @param imageName 图片路径
 @return 处理结果
 */
extern UIImage *YHBUndleImage(NSString* imageName);

/**
 根据图片颜色和尺寸生成图片

 @param color   色值
 @param size    尺寸
 @return 处理结果
 */
extern UIImage *YHCreateImage(UIColor *color, CGSize size);

/**
 给 UIImage 添加生成圆角图片的扩展API(gView.image = [[UIImage imageNamed:@"test"] YHImageWithCornerRadius:4 , 1.0f];)

 @param radius  圆角设置
 @param size    切割比例
 @return 处理结果
 */
extern UIImage *YHImageWithCornerRadius(CGFloat radius, CGSize size);



#pragma mark - ************************************** Text to do some things
/** 计算文字实际宽度*/
extern float YHCalcTextWidth(UIFont *font, NSString* text, CGFloat width);
/** 计算文字实际高度*/
extern float YHCalcTextHight(UIFont *font, NSString* text, CGFloat width);
/** 获取拼音首字母(传入汉字字串,返回大写拼音首字母)*/
extern NSString *firstCharactor(NSString *string);
