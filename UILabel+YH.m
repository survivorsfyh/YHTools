//
//  UILabel+YH.m
//  Integration
//
//  Created by survivors on 2019/10/28.
//  Copyright © 2019年 survivors. All rights reserved.
//

#import "UILabel+YH.h"

@implementation UILabel (YH)

+ (void)YHLabelAttributedString:(UILabel *)label firstText:(NSString *)oneIndex toEndText:(NSString *)endIndex textColor:(UIColor *)color textSize:(CGFloat)size {
    // 创建 Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:label.text];
    // 需要改变的首位文字位置
    NSUInteger firstLoc = [[noteStr string] rangeOfString:oneIndex].location;
    // 需要改变的末位文字位置
//    NSUInteger endLoc = [[noteStr string] rangeOfString:endIndex].location + 1;
    NSUInteger endLoc = [[noteStr string] rangeOfString:endIndex].location + [[noteStr string] rangeOfString:endIndex].length;
    // 需要改变的区间
    NSRange range = NSMakeRange(firstLoc, endLoc - firstLoc);
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    // 改变字体大小及类型
    [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:size] range:range];
    // 为 label 添加 Attributed
    [label setAttributedText:noteStr];
}


@end
