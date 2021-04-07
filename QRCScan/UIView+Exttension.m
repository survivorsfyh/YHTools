//
//  UIView+Exttension.m
//  autoLayout
//
//  Created by liuhonghao on 16/3/7.
//  Copyright © 2016年 cyberzone. All rights reserved.
//

#import "UIView+Exttension.h"

@implementation UIView (Exttension)

/*
 分类只能扩充方法，不能扩展属性和成员变量（如果包含成员变量会直接报错）。
 如果分类中声明了一个属性，那么分类只会生成这个属性的set、get方法声明，也就是不会有实现。
 
 能为某个类附加额外的属性，成员变量，方法声明
 一般的类扩展写到.m文件中
 一般的私有属性写到类扩展
 */

- (void)setX:(CGFloat)x
{
    CGRect fram = self.frame;
    fram.origin.x = x;
    self.frame = fram;
}
- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect fram = self.frame;
    fram.origin.y = y;
    self.frame = fram;
}
- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect fram = self.frame;
    fram.size.width = width;
    self.frame = fram;
}
- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect fram = self.frame;
    fram.size.height = height;
    self.frame = fram;
}
- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect fram = self.frame;
    fram.size = size;
    self.frame = fram;
}
- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect fram = self.frame;
    fram.origin = origin;
    self.frame = fram;
}
- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY
{
    return self.center.y;
}


@end
