//
//  YHAccessAuthorization.h
//  Integration
//
//  Created by survivors on 2019/2/25.
//  Copyright © 2019年 survivors. All rights reserved.
//

/**
 *  授权管理
 */

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>// 定位

NS_ASSUME_NONNULL_BEGIN

@protocol YHAccessAuthorizationDelegate <NSObject>

- (void)YHLocationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations;

- (void)YHLocationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;

@end



@interface YHAccessAuthorization : NSObject

@property (nonatomic, weak) id <YHAccessAuthorizationDelegate> delegate;

+ (instancetype)shareInstance;

/**
 获取位置验证权限(作用域: 地图 & 定位相关)
 
 @param vc 当前视图控件
 */
- (void)YHGetLocationPermissionVerifcationWithController:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
