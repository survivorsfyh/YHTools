//
//  MBProgressHUD+YH.h
//  WesternMedicineLZ
//
//  Created by survivors on 2019/5/16.
//  Copyright © 2019年 survivorsfyh. All rights reserved.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (YH)

+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view;



/** Hud 可设置滞留时间*/
+ (void)showCommonHudWithAlertString:(NSString *)aString afterDelay:(int)time toView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
