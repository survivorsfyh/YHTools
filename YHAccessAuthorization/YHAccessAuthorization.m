//
//  YHAccessAuthorization.m
//  Integration
//
//  Created by survivors on 2019/2/25.
//  Copyright © 2019年 survivors. All rights reserved.
//

#import "YHAccessAuthorization.h"
#import <CoreLocation/CoreLocation.h>// 定位

@interface YHAccessAuthorization () <CLLocationManagerDelegate> {
    /** 位置管理*/
    CLLocationManager *locationManager;
}

@end

@implementation YHAccessAuthorization

+ (instancetype)shareInstance {
    static YHAccessAuthorization *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    
    return shareInstance;
}

#pragma mark - ****************************** 获取位置验证权限
/**
 获取位置验证权限(作用域: 地图 & 定位相关)

 @param vc 当前视图控件
 */
- (void)YHGetLocationPermissionVerifcationWithController:(UIViewController *)vc {
    BOOL enable = [CLLocationManager locationServicesEnabled];
    NSInteger state = [CLLocationManager authorizationStatus];
    
    if (!enable || 2 > state) {
        // 尚未授权位置权限
        if (8 <= [[UIDevice currentDevice].systemVersion floatValue]) {
            NSLog(@"系统位置权限授权弹窗");
            // 系统位置权限授权弹窗
            locationManager = [[CLLocationManager alloc] init];
            locationManager.delegate = self;
            [locationManager requestAlwaysAuthorization];
            [locationManager requestWhenInUseAuthorization];
        }
    }
    else {
        if (state == kCLAuthorizationStatusDenied) {
            NSLog(@"授权位置权限被拒绝");
            // 授权位置权限被拒绝
            UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示"
                                                                              message:@"访问位置权限暂未开启"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
            [alertCon addAction:[UIAlertAction actionWithTitle:@"暂不设置" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            [alertCon addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                dispatch_after(0.2, dispatch_get_main_queue(), ^{
                    NSURL *url = [[NSURL alloc] initWithString:UIApplicationOpenSettingsURLString];// 跳转至定位
                    if( [[UIApplication sharedApplication] canOpenURL:url]) {
                        [[UIApplication sharedApplication] openURL:url];
                    }
                });
            }]];
            
            [vc presentViewController:alertCon animated:YES completion:^{
                
            }];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"获取定位信息 --- 成功");
    
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"获取定位信息 --- 失败");
}


@end
