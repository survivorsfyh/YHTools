//
//  UIView+FYH.h
//  Integration
//
//  Created by survivors on 2018/1/24.
//  Copyright © 2018年 survivors. All rights reserved.
//

/*
 为控件添加边框样式_工具类
 */
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LQQSideType) {
    kLQQSideTypeTop    = 0,
    kLQQSideTypeLeft   = 1,
    kLQQSideTypeBottom = 2,
    kLQQSideTypeRight  = 3,
    kLQQSideTypeAll    = 4,
};

typedef NS_ENUM(NSInteger,LQQSideAngleType) {
    kLQQSideAngleTypeTopLeft         = 0,
    kLQQSideAngleTypeTopRight        = 1,
    kLQQSideAngleTypeBottomLeft      = 2,
    kLQQSideAngleTypeBottomRight     = 3,
    kLQQSideAngleTypeAll             = 4,
};



@interface UIView (FYH)

/**
 设置不同边的圆角

 @param sideType        圆角类型
 @param cornerRadius    圆角半径
 */
- (void)cornerSideType:(LQQSideType)sideType withCornerRadius:(CGFloat)cornerRadius;


/**
 设置不同角的圆角

 @param sideType        圆角类型
 @param cornerRadius    圆角半径
 */
- (void)cornerSideAngleType:(LQQSideAngleType)sideType withCornerRadius:(CGFloat)cornerRadius;


/**
 设置view某一边框

 @param sideType    哪个边
 @param color       边框颜色
 @param width       边框宽度
 */
- (void)cornerSideType:(LQQSideType)sideType lineColor:(UIColor *)color lineWidth:(CGFloat)width;

@end
