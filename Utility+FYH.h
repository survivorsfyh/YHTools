//
//  Utility+FYH.h
//  Integration
//
//  Created by survivors on 2018/1/24.
//  Copyright © 2018年 survivors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** 获取资源全路径*/
extern NSString* ResourcePath(NSString* fileName);
/** 弹出消息框来显示消息*/
extern void ShowMessage(UIViewController *alertVC, NSString* message);


/**
 本地文件 - 创建

 @param filePath 文件路径
 */
extern void CreateLocalFileWithPath(NSString *filePath);

/**
 本地文件 - 删除
 
 @param filePath 文件路径
 */
extern void DeleteLocalFileWithPath(NSString *filePath);

/**
 本地生成 plist 文件(字典 Dic)
 
 @param dataSource      写入数据源
 @param fileName        文件名称
 @param filePath        文件路径
 */
extern void CreateLocalPlistFile(NSMutableDictionary *dataSource, NSString *fileName, NSString *filePath);

/**
 插入对象至本地 plist 文件
 
 @param dataSource  数据源
 @param fileName    文件名称
 @param filePath    文件路径
 */
extern void InsertObjectToLocalPlistFile(NSMutableDictionary *dataSource, NSString *fileName, NSString *filePath);

/**
 移除对象至本地 plist 文件
 
 @param key         关键参数
 @param fileName    文件名称
 @param filePath    文件路径
 */
extern void RemoveObjectKeyToLocalPlistFile(NSString *key, NSString *fileName, NSString *filePath);

/**
 获取对象数据从本地 plist 文件
 
 @param fileName 文件名称
 @param filePath 文件路径
 */
extern NSMutableDictionary* GetObjectDataFormLocalPlistFile(NSString *fileName, NSString *filePath);


/**
 将图片存储至本地并返回当前图片路径

 @param image       图片资源
 @param imageName   图片名称
 @return            存储所在路径
 */
extern NSString* saveImgFromLocal(UIImage *image, NSString *imageName);

//根据图片路径加载图片
extern UIColor* colorWithHexString(NSString *color);
extern UIImage* BUndleImage(NSString* imageName);

/** 删除文件*/
extern BOOL RemoveFile(NSString* fileName);
/** 检查文件是否存在：此是ExistAtConfigPath和ExistAtTemporaryPath的综合，但不负责创建路径*/
extern BOOL ExistAtPath(NSString* fileFullPath);

//计算文字实际高度
extern float CalcTextHight(UIFont *font, NSString* text, CGFloat width);
extern float CalcTextWidth(UIFont *font, NSString* text, CGFloat width);

//时间日期转换
extern NSString* DateStringWithTimeInterval(NSNumber* secs);
extern NSString* DateStringWithTimeIntervalOnlyDay(NSNumber* secs);

/** str 转 date*/
extern NSString* StringFromDate(NSDate* aDate, NSString *aFormat);
/** date 转 str*/
extern NSDate*   DateFromString(NSString* string, NSString* aFormat);

/** md5加密*/
extern NSString *GenerateMD5KeyNew(NSString *originalString);
extern NSString *stringGenerateMD5(NSString *originalString);

/** str 转 date - 当前周*/
extern NSString *numDaysWeeks(NSDate *nowDate);
/** str 转 date - 当前月*/
extern NSString *numDaysMonth(NSDate *nowDate);

/** 根据图片颜色和尺寸生成图片*/
extern UIImage *createImage (UIColor *color, CGSize size);
/** 给 UIImage 添加生成圆角图片的扩展API(gView.image = [[UIImage imageNamed:@"test"] hyb_imageWithCornerRadius:4 , 1.0f];)*/
extern UIImage *fyh_imageWithCornerRadius(CGFloat radius, CGSize size);

/** frame适配*/
extern CGRect YQRectMake (CGFloat x, CGFloat y, CGFloat width, CGFloat height);
extern CGSize YQSizeMake (CGFloat width, CGFloat height);

/** 获取拼音首字母(传入汉字字串,返回大写拼音首字母)*/
extern NSString *firstCharactor(NSString *string);

/**
 *  日期的比较
 */
extern BOOL DatePastToday(NSString *string, NSString *aFormat);

/**
 *  Dictionaryic -> Json to conversion method
 */
extern NSString *dictionaryToJson(NSDictionary *dic);
/**
 *  Json -> Dictionary to conversion method
 */
extern NSDictionary *dictionaryWithJsonString(NSString *jsonString);

// 当前网络监听
extern NSString *AFStringFromNetWorkReachabilityStatus(AFNetworkReachabilityStatus status);


