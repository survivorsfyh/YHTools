//
//  UILabel+YH.h
//  Integration
//
//  Created by survivors on 2019/10/28.
//  Copyright © 2019年 survivors. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (YH)

/**
 改变 label 文字中某段文字的颜色和大小
 label      传入的文本内容（注：传入前要有文字）
 oneIndex   从首位文字开始
 endIndex   至末位文字结束
 color      字体颜色
 size       字体字号
 */
+ (void)YHLabelAttributedString:(UILabel *)label firstText:(NSString *)oneIndex toEndText:(NSString *)endIndex textColor:(UIColor *)color textSize:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
