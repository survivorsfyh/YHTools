//
//  UIView+FYH.m
//  Integration
//
//  Created by survivors on 2018/1/24.
//  Copyright © 2018年 survivors. All rights reserved.
//


#import "UIView+FYH.h"

@implementation UIView (FYH)

- (void)cornerSideType:(LQQSideType)sideType withCornerRadius:(CGFloat)cornerRadius
{
    CGSize cornerSize = CGSizeMake(cornerRadius, cornerRadius);
    UIBezierPath *maskPath;
    
    switch (sideType) {
        case kLQQSideTypeTop:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)
                                                   cornerRadii:cornerSize];
        }
            break;
        case kLQQSideTypeLeft:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerBottomLeft)
                                                   cornerRadii:cornerSize];
        }
            break;
        case kLQQSideTypeBottom:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight)
                                                   cornerRadii:cornerSize];
        }
            break;
        case kLQQSideTypeRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight)
                                                   cornerRadii:cornerSize];
        }
            break;
        default:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:UIRectCornerAllCorners
                                                   cornerRadii:cornerSize];
        }
            break;
    }
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    // Set the newly created shape layer as the mask for the image view's layer
    self.layer.mask = maskLayer;
    
    [self.layer setMasksToBounds:YES];
}


- (void)cornerSideAngleType:(LQQSideAngleType)sideType withCornerRadius:(CGFloat)cornerRadius
{
    CGSize cornerSize = CGSizeMake(cornerRadius, cornerRadius);
    UIBezierPath *maskPath;
    
    switch (sideType) {
        case kLQQSideAngleTypeTopLeft:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:(UIRectCornerTopLeft)
                                                   cornerRadii:cornerSize];
        }
            break;
        case kLQQSideAngleTypeTopRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:(UIRectCornerTopRight)
                                                   cornerRadii:cornerSize];
        }
            break;
        case kLQQSideAngleTypeBottomLeft:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:(UIRectCornerBottomLeft)
                                                   cornerRadii:cornerSize];
        }
            break;
        case kLQQSideAngleTypeBottomRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:(UIRectCornerBottomRight)
                                                   cornerRadii:cornerSize];
        }
            break;
        default:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:UIRectCornerAllCorners
                                                   cornerRadii:cornerSize];
        }
            break;
    }
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    // Set the newly created shape layer as the mask for the image view's layer
    self.layer.mask = maskLayer;
    
    [self.layer setMasksToBounds:YES];
}

- (void)cornerSideType:(LQQSideType)sideType lineColor:(UIColor *)color lineWidth:(CGFloat)width
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    
    switch (sideType) {
        case kLQQSideTypeTop:
        {
            [aPath moveToPoint:CGPointMake(0.0, 0.0)];
            [aPath addLineToPoint:CGPointMake(self.frame.size.width, 0.0)];
        }
            break;
        case kLQQSideTypeLeft:
        {
            [aPath moveToPoint:CGPointMake(0.0, 0.0)];
            [aPath addLineToPoint:CGPointMake(0.0, self.frame.size.height)];
        }
            break;
        case kLQQSideTypeBottom:
        {
            [aPath moveToPoint:CGPointMake(0.0, self.frame.size.height)];
            [aPath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
        }
            break;
        case kLQQSideTypeRight:
        {
            [aPath moveToPoint:CGPointMake(self.frame.size.width,0.0)];
            [aPath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
            
        }
            break;
        default:
        {
            
        }
            break;
    }
    
    layer.path = aPath.CGPath;
    layer.strokeColor = color.CGColor;
    layer.lineWidth = width;
    [self.layer addSublayer:layer];
}

@end
