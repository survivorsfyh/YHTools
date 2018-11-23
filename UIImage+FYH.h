//
//  UIImage+FYH.h
//  Integration
//
//  Created by survivors on 2018/8/16.
//  Copyright © 2018年 survivors. All rights reserved.
//

/*
 一.CALayer => cornerRadius
 对 contents 为空的视图设置圆角
 view.backgroundColor = [UIColor redColor];
 view.layer.cornerRadius = 25;
 
 //UILabel设置backgroundColor的行为被更改，不再是设定layer的背景色而是为contents设置背景色
 label.layer.backgroundColor = aColor
 label.layer.cornerRadius = 5
 
 对 contents 不为空的视图设置圆角
 imageView.image = [UIImage imageNamed:@"img"];
 imageView.image.layer.cornerRadius = 5;
 imageView.image.layer.masksToBounds = YES;
 
 二.CALayer => mask
 // 通过图片生成遮罩，
 UIImage *maskImage = [UIImage imageNamed:@"someimg"];
 CALayer *mask = [CALayer new];
 mask.frame = CGRectMake(0, 0, maskImage.size.width, maskImage.size.height);
 mask.contents = (__bridge id _Nullable)(maskImage.CGImage);
 view.layer.mask = mask;
 
 //通过贝塞尔曲线生成
 CAShapeLayer *mask = [CAShapeLayer new];
 mask.path = [UIBezierPath bezierPathWithOvalInRect:view.bounds].CGPath;
 view.layer.mask = mask;
 
 三.UIBezierPath
 https://www.jianshu.com/p/6c9aa9c5dd68
 
 https://blog.csdn.net/u012716788/article/details/49564027
 */

#import <UIKit/UIKit.h>

@interface UIImage (FYH)

/**
 生成图片,根据特定的颜色

 @param color   色值
 @param size    尺寸
 @return        结果样式
 */
+ (UIImage *)createImageColor:(UIColor *)color size:(CGSize)size;

/**
 压缩图片比例

 @param image   图片素材
 @param scale   压缩比例
 @return        结果样式
 */
+ (UIImage *)scaleImage:(UIImage *)image sclase:(CGFloat)scale;

/**
 绘制水印 - 文字水印

 @param image       图片素材
 @param content     文字内容
 @param point       区域
 @param attributes  属性
 @return            结果样式
 */
+ (UIImage *)waterAtImage:(UIImage *)image content:(NSString *)content point:(CGPoint)point attributes:(NSDictionary *)attributes;

/**
 绘制水印 - 图片水印

 @param image       图片素材
 @param waterImage  图片内容
 @param rect        矩阵
 @return            结果样式
 */
+ (UIImage *)waterAtImage:(UIImage *)image waterImgae:(UIImage *)waterImage rect:(CGRect)rect;

/**
 截屏

 @param view    当前图层
 @param success 结果样式
 */
+ (void)cutView:(UIView *)view success:(void(^)(UIImage *image))success;

/**
 图片裁剪

 1.假设一张图片的 size 是(600,600)
 2.imageView 的 size 是(300,300)
 3.选择的裁剪区域是(10,10,150,150)
 4.而为了能够保持原来图片的分辨率,在图片不拉伸的情况下在原图片上进行剪裁,所以实际在图片上的剪裁区域即(20,20,300,300)
 5.图片绘制在画布上的点就是(-20,-20),这样不需要进行裁剪就能获得想要得到的图片样式
 
 @param image   图片素材
 @param size    裁剪尺寸
 @param rect    裁剪区域
 @return        结果样式
 */
+ (UIImage *)cutImage:(UIImage *)image imageViewSize:(CGSize)size clipRect:(CGRect)rect;

/**
 自定义图片裁剪(通过点连线的方式)

 1.将自定义点变换到在图片上的点
 2.计算出自定义点所在的区域rect
 3.开始图形上下文 rect.size
 4.绘制 path 机型剪裁
 5.绘图 drawAtPoint(x: -rect.origin.x and y: -rect.origin.y)
 
 @param image   图片素材
 @param size    裁剪尺寸
 @param points  裁剪区域
 @return        结果样式
 */
+ (UIImage *)cutImage:(UIImage *)image imageViewSize:(CGSize)size clipPoints:(NSArray *)points;

/**
 特定形状剪切

 @param image       图片素材
 @param maskImage   裁剪样式
 @return            结果样式
 */
+ (UIImage *)maskImage:(UIImage *)image withMask:(UIImage *)maskImage;

/**
 图片擦除效果,即在样式图片上覆盖一层图片蒙版,通过擦除效果显示下方图片内容

 @param view    当前图层
 @param point   擦除区域
 @param size    区域大小
 @return        结果样式
 */
+ (UIImage *)wipeView:(UIView *)view point:(CGPoint)point size:(CGSize)size;




@end
