//
//  UIImage+FYH.m
//  Integration
//
//  Created by survivors on 2018/8/16.
//  Copyright © 2018年 survivors. All rights reserved.
//

#import "UIImage+FYH.h"

@implementation UIImage (FYH)

/**
 将图片 Image 数组生成 gif 格式图片

 @param arrImgName      图片资源
 @param imgViewFrame    控件尺寸(ImageView)
 @param view            当前视图
 */
+ (void)createGifImageWithImageName:(NSArray *)arrImgName AndImageViewFrame:(CGRect)imgViewFrame AndCurrentView:(UIView *)view {
    UIImageView *imgViewAnimated = [[UIImageView alloc] initWithFrame:imgViewFrame];
    imgViewAnimated.animationImages = arrImgName;
    
    imgViewAnimated.animationDuration = 1.f;
    imgViewAnimated.animationRepeatCount = 0;
    
    [view addSubview:imgViewAnimated];
    [imgViewAnimated startAnimating];
}

#pragma mark - 生成图片,根据特定的颜色
+ (UIImage *)createImageColor:(UIColor *)color size:(CGSize)size {
    // 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(size, false, 0);
    // 绘制颜色区域
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
    [color setFill];
    [path fill];
    // 通过图形上下文获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 压缩图片比例
+ (UIImage *)scaleImage:(UIImage *)image sclase:(CGFloat)scale {
    // 设置压缩后的尺寸
    CGFloat scaleWith = image.size.width * scale;
    CGFloat scaleHeight = image.size.height * scale;
    CGSize scaleSize = CGSizeMake(scaleWith, scaleHeight);
    // 开启图形上下文
    UIGraphicsBeginImageContext(scaleSize);
    // 绘制图片
    [image drawInRect:CGRectMake(0, 0, scaleWith, scaleHeight)];
    // 通过图形上下文获取图片
    UIImage *imageResult = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return imageResult;
}

#pragma mark - 绘制水印 - 文字水印
+ (UIImage *)waterAtImage:(UIImage *)image content:(NSString *)content point:(CGPoint)point attributes:(NSDictionary *)attributes {
    // 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(image.size, false, 0);
    // 绘制图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    // 添加文字内容
    [content drawAtPoint:point withAttributes:attributes];
    // 获取图片
    UIImage *imageResult = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return imageResult;
}

#pragma mark - 绘制水印 - 图片水印
+ (UIImage *)waterAtImage:(UIImage *)image waterImgae:(UIImage *)waterImage rect:(CGRect)rect {
    // 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(image.size, false, 0);
    // 绘制原图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    // 添加图片内容
    [waterImage drawInRect:rect];
    // 获取图片
    UIImage *imageResult = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return imageResult;
}

#pragma mark - 截屏
+ (void)cutView:(UIView *)view success:(void(^)(UIImage *image))success {
    // 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0);
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 渲染
    [view.layer renderInContext:ctx];
    // 获取图片
    UIImage *imageResult = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    success(imageResult);
}

#pragma mark - 图片裁剪
+ (UIImage *)cutImage:(UIImage *)image imageViewSize:(CGSize)size clipRect:(CGRect)rect {
    // 设置图片大小和实际显示大小的比例
    CGFloat scaleWidth = image.size.width / size.width;
    CGFloat scaleHeight = image.size.height / size.height;
    // 设置裁剪区域
    CGRect clipRect = CGRectMake(rect.origin.x * scaleWidth, rect.origin.y * scaleHeight, rect.size.width * scaleWidth, rect.size.height * scaleHeight);
    // 开启图形上下文
    UIGraphicsBeginImageContext(clipRect.size);
    // 渲染
    [image drawAtPoint:CGPointMake(-clipRect.origin.x, -clipRect.origin.y)];
    // 获取图片
    UIImage *imageResult = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return imageResult;
}

#pragma mark - 自定义图片裁剪(通过点连线的方式)
+ (UIImage *)cutImage:(UIImage *)image imageViewSize:(CGSize)size clipPoints:(NSArray *)points {
    /*
     1.将自定义点变换到在图片上的点
     2.计算出自定义点所在的区域 rect
     3.开始图形上下文 rect.size
     4.绘制 path 机型剪裁
     5.绘图 drawAtPoint (x: -rect.origin.x and y: -rect.origin.y)
     6.从图形上下文获取图片
     7.关闭图形上下文
     */
    // 设置图片大小和实际显示大小的比例
    CGFloat scaleWidth = image.size.width / size.width;
    CGFloat scaleHeight = image.size.height / size.height;
    // 获取裁剪焦点
    NSArray *arrPoints = [UIImage points:points scalex:scaleWidth scaleY:scaleHeight];
    
    // 确定上下左右边缘点
    // x 升序数组
    NSArray *arrPointX = [arrPoints sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        CGPoint point1 = [obj1 CGPointValue];
        CGPoint point2 = [obj2 CGPointValue];
        return point1.x > point2.x;
    }];
    // y 升序数组
    NSArray *arrPointY = [arrPoints sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        CGPoint point1 = [obj1 CGPointValue];
        CGPoint point2 = [obj2 CGPointValue];
        return point1.y > point2.y;
    }];
    
    // 设置裁剪区域
    CGRect clipRect = CGRectMake([arrPointX.firstObject CGPointValue].x, [arrPointY.firstObject CGPointValue].y, [arrPointX.lastObject CGPointValue].x - [arrPointX.firstObject CGPointValue].x, [arrPointY.lastObject CGPointValue].y - [arrPointY.firstObject CGPointValue].y);
    // 开启图形上下文
    UIGraphicsBeginImageContext(clipRect.size);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSInteger i = 0; i < arrPoints.count; i ++) {
        CGPoint point = [arrPoints[i] CGPointValue];
        if (0 == i) {
            [path moveToPoint:point];
        }
        else {
            [path addLineToPoint:point];
        }
    }
    [path closePath];
    [path addClip];
    // 渲染
    [image drawAtPoint:CGPointMake(-clipRect.origin.x, -clipRect.origin.y)];
    // 获取图片
    UIImage *imageResult = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return imageResult;
}
+ (NSArray *)points:(NSArray *)points scalex:(CGFloat)scalex scaleY:(CGFloat)scaley {
    NSMutableArray *newPoints = [NSMutableArray arrayWithCapacity:points.count];
    for (NSInteger i = 0; i < points.count; i ++) {
        CGPoint point = [[points objectAtIndex:i] CGPointValue];
        CGPoint newPoint = CGPointMake(point.x * scalex, point.y * scaley);
        [newPoints addObject:[NSValue valueWithCGPoint:newPoint]];
    }
    return newPoints;
}

#pragma mark - 图片擦除效果,即在样式图片上覆盖一层图片蒙版,通过擦除效果显示下方图片内容
+ (UIImage *)wipeView:(UIView *)view point:(CGPoint)point size:(CGSize)size {
    // 开启图形上下文
    UIGraphicsBeginImageContext(view.bounds.size);
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 渲染
    [view.layer renderInContext:ctx];
    // 设置将要擦除区域的矩阵
    CGFloat clipX = point.x - size.width / 2;
    CGFloat clipY = point.y - size.height / 2;
    CGRect clipRect = CGRectMake(clipX, clipY, size.width, size.height);
    // 将擦除区域设置透明
    CGContextClearRect(ctx, clipRect);
    // 获取图片
    UIImage *imageResult = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return imageResult;
}

#pragma mark - 特定形状剪切
+ (UIImage *)maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    CGImageRef maskRef = maskImage.CGImage;
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef),
                                        NULL, false);
    CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
    return [UIImage imageWithCGImage:masked];
}
















@end
