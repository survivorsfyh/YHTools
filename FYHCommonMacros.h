//
//  FYHCommonMacros.h
//  Integration
//
//  Created by survivors on 2018/1/30.
//  Copyright © 2018年 survivors. All rights reserved.
//

/**
 *  开发常用宏相关
 *
 *  网络诊断    http://t.moji.com/
 */

#ifndef FYHCommonMacros_h
#define FYHCommonMacros_h

//开发的时候打印，但是发布的时候不打印的NSLog
#ifdef DEBUG
//#define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#define NSLog(FORMAT, ...) fprintf(stderr,"\n %s: 第%d行  %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__, [[[NSString alloc] initWithData:[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] dataUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding] UTF8String]);
#else
#define NSLog(...)
#endif



//#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_10_3
//    // 系统版本大于 iOS XX 的新特性代码
//    // __IPHONE_OS_VERSION_MAX_ALLOWED 允许最高的系统版本
//    // __IPHONE_OS_VERSION_MIN_REQUIRED 支持最低的系统版本
//#endif



#pragma mark - Base
/** 弱引用*/
#define kWeakSelf(type)   __weak typeof(type) weak##type = type;
/** 强引用*/
#define kStrongSelf(type) __strong typeof(type) type = weak##type;
/** 由角度转换弧度*/
#define kDegreesToRadian(x)      (M_PI * (x) / 180.0)
/** 由弧度转换角度*/
#define kRadianToDegrees(radian) (radian * 180.0) / (M_PI)

/** 获取一段时间间隔*/
#define kStartTime  CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime    NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)



#pragma mark - Size
//获取屏幕宽度与高度
#define kScreenWidth    \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreenmainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width)
#define kScreenHeight   \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreenmainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height)
#define kScreenSize     \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? CGSizeMake([UIScreenmainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreenmainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale) : [UIScreen mainScreen].bounds.size)

//屏幕 rect
#define SCREEN_RECT     ([UIScreen mainScreen].bounds)

#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height)

#define CONTENT_HEIGHT  (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)


#pragma mark - Color
/** 颜色*/
#define kRGBColor(r, g, b)      [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define kRGBAColor(r, g, b, a)  [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
#define kRandomColor            KRGBColor(arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)
/** RGB*/
#define Main_Color      [UIColor colorWithRed:(3)/255.0 green:(160)/255.0 blue:(235)/255.0 alpha:1.0]
#define RGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b)      RGBA(r,g,b,1.0f)

#define kColorWithHex(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]



#pragma mark - Check
/** 字符串是否为空*/
#define kStringIsEmpty(str)     ([str isKindOfClass:[NSNull class]] || str == nil || str == NULL || [str isEqualToString:@"null"] || [str isEqualToString:@"<null>"] || [str isEqualToString:@"(null)"] || [str isEqualToString:@"nil"] || [str length] < 1 ? YES : NO )
/** 数组是否为空*/
#define kArrayIsEmpty(array)    (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
/** 字典是否为空*/
#define kDictIsEmpty(dic)       (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
/** 是否是空对象*/
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
/** 判断是否为iPhone*/
#define kISiPhone   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
/** 判断是否为iPad*/
#define kISiPad     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/** 判断是真机还是模拟器*/
#if TARGET_OS_IPHONE
//真机
#endif
#if TARGET_IPHONE_SIMULATOR
//模拟器
#endif


#pragma mark - 缩写
#define kApplication        [UIApplication sharedApplication]
#define kKeyWindow          [UIApplication sharedApplication].keyWindow
#define kAppDelegate        ((AppDelegate*)[UIApplication sharedApplication].delegate)
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]



#pragma mark - 获取相关资料

/** 获取bundle Id信息*/
#define kGetBundleId        [[NSBundle mainBundle] bundleIdentifier]
/** 获取 App 名称*/
#define kGetAppDisplayName  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
/** APP版本号 Version*/
#define kAppVersion         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/** APP包版本号 BundleVersion*/
#define kAppBundle          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
/** 获取设备名称：手机别名(即：用户定义的名称)*/
#define kGetDeviceName      [[UIDevice currentDevice] name]
/** 获取设备类型*/
#define kGetDeviceModel     [[UIDevice currentDevice] model]
/** 获取设备 UUID*/
#define kGetDeviceUUID      [[UIDevice currentDevice].identifierForVendor UUIDString]
/** 获取系统名称*/
#define kSystemName         [[UIDevice currentDevice] systemName]
/** 系统版本号*/
#define kSystemVersion      [[UIDevice currentDevice] systemVersion]
/** 获取地方型号(即：国际化区域名称)*/
#define kLocalPhoneModel    [[UIDevice currentDevice] localizedModel]
/** 获取当前语言*/
#define kCurrentLanguage    ([[NSLocale preferredLanguages] objectAtIndex:0])
/** 获取沙盒 Document 路径*/
#define kDocumentPath       [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
/** 获取沙盒 Library 路径*/
#define kLibraryPath        [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]
/** 获取沙盒 temp 路径(注:iPhone 重启会清空)*/
#define kTempPath           NSTemporaryDirectory()
/** 获取沙盒 Cache 路径*/
#define kCachePath          [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
/** 获取程序包中程序路径*/
#define kResource(f, t)     [[NSBundle mainBundle] pathForResource:(f) ofType:(t)];
/** 获取系统时间戳*/
#define getCurrentTime      [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]
/** 屏幕分辨率*/
#define SCREEN_RESOLUTION   (SCREEN_WIDTH * SCREEN_HEIGHT * ([UIScreen mainScreen].scale))

#endif /* FYHCommonMacros_h */
