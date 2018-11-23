//
//  UIColor+FYH.h
//  Integration
//
//  Created by survivors on 2018/1/24.
//  Copyright © 2018年 survivors. All rights reserved.
//

/*
    为控件设置色值
 */
#import <UIKit/UIKit.h>

@interface UIColor (FYH)


/**
 根据RGB颜色值生成UIColor

 @param rgbValue    颜色值
 @param alpha       透明度（0-1）之间
 @return            结果样式
 */
+ (UIColor *)colorFromRGB:(NSInteger)rgbValue withAlpha:(CGFloat)alpha;
+ (UIColor *)colorFromRGB:(NSInteger)rgbValue;



/**
 根据十六进制颜色值生成UIColor

 @param hexString   十六进制色值
 @return            结果样式
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;



/**
 根据十六进制颜色值生成UIColor

 @param hexString   十六进制色值
 @param alpha       透明度（0-1）之间
 @return            结果样式
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexStringWithAlpha:(NSString *)hexString;

@end
