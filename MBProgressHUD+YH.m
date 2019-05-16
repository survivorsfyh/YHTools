//
//  MBProgressHUD+YH.m
//  WesternMedicineLZ
//
//  Created by survivors on 2019/5/16.
//  Copyright © 2019年 survivorsfyh. All rights reserved.
//

#import "MBProgressHUD+YH.h"
//#import <MBProgressHUD.h>

@implementation MBProgressHUD (YH)

#pragma mark - 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:0.7];
}

#pragma mark - 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view {
    [self show:error icon:@"error.png" view:view];
}


+ (void)showError:(NSString *)error afterDelay:(int)time toView:(UIView *)view callback:(void (^)(BOOL, NSError *))callback {
    [self showCommonHudWithAlertString:error afterDelay:time toView:view];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(handleHideTimer:) userInfo:nil repeats:NO];//[NSTimer timerWithTimeInterval:time target:self selector:@selector(handleHideTimer:) userInfo:@(YES) repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    //    [self show:error icon:@"error.png" view:view];
}
- (void)handleHideTimer:(NSTimer *)timer {
    [self hideAnimated:[timer.userInfo boolValue]];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view {
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}

#pragma mark - 设置展示时间
+ (void)showCommonHudWithAlertString:(NSString *)aString afterDelay:(int)time toView:(UIView *)view {
    MBProgressHUD *commonHud;
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    if (commonHud) {
        [commonHud hideAnimated:YES];
        commonHud = nil;
    }
    commonHud = [[MBProgressHUD alloc] initWithView:view];
    commonHud.label.text = aString;
    commonHud.mode = MBProgressHUDModeText;
//    commonHud.removeFromSuperViewOnHide = YES;
    [view addSubview:commonHud];
    [view bringSubviewToFront:commonHud];
    [commonHud showAnimated:YES];
    [commonHud hideAnimated:YES afterDelay:time];
}

@end
