//
//  YHUtility.h
//  Integration
//
//  Created by survivors on 2019/8/30.
//  Copyright © 2019年 survivors. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHUtility : NSObject

/**
 *  是否越狱设备
 */
+ (BOOL)YHIsJailBreakDevice;

/**
 获取设备颜色

 @return 结果集
 */
+ (NSMutableDictionary *)YHGetDeviceColors;

/**
 Web 服务搭建与配置

 1、需要集成 pod 'GCDWebServer' 第三方库
 2、引入头文件
 #import <GCDWebServer.h>
 #import <GCDWebServerDataResponse.h>
 
 @param port 端口号
 @param name 端口名
 */
- (void)YHCreateWebServerWithPort:(NSUInteger)port AndBonjourName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
