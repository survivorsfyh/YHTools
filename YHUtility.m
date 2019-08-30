//
//  YHUtility.m
//  Integration
//
//  Created by survivors on 2019/8/30.
//  Copyright © 2019年 survivors. All rights reserved.
//

#import "YHUtility.h"
// Web 服务搭建与配置相关
#import <GCDWebServer.h>
#import <GCDWebServerDataResponse.h>

#define kDocumentPath       [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

@interface YHUtility() {
    /** Web 服务*/
    GCDWebServer *webServer;
}

@end

@implementation YHUtility

#pragma mark - ****************************** 是否越狱设备
+ (BOOL)YHIsJailBreakDevice {
    __block BOOL jailBreak = NO;
    /*
     "/Applications/Cydia.app" 存在 越狱
     "/private/var/lib/apt" 存在 越狱
     "/usr/lib/system/libsystem_kernel.dylib"  不存在 越狱
     "Library/MobileSubstrate/MobileSubstrate.dylib" 存在 越狱
     "/etc/apt" 存在 越狱
     */
    NSArray *arr = @[@"/Applications/Cydia.app",
                     @"/private/var/lib/apt",
                     @"/usr/lib/system/libsystem_kernel.dylib",
                     @"Library/MobileSubstrate/MobileSubstrate.dylib",
                     @"/etc/apt"];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:obj];
        if ([obj isEqualToString:@"/usr/lib/system/libsystem_kernel.dylib"]) {
            jailBreak |= fileExist;
        } else {
            jailBreak |= fileExist;
        }
    }];
    
    return jailBreak;
}



#pragma mark - ****************************** 获取设备颜色
+ (NSMutableDictionary *)YHGetDeviceColors {
    NSMutableDictionary *dicResult = [NSMutableDictionary dictionary];
    
    UIDevice *device = [UIDevice currentDevice];
    SEL selector = NSSelectorFromString(@"deviceInfoForKey:");
    if ([device respondsToSelector:selector]) {
        IMP imp = [device methodForSelector:selector];
        NSString *(*func)(id, SEL, NSString *) = (void *)imp;
        
        NSString *deviceColor = func(device, selector, @"DeviceColor");
        NSString *deviceEncolsureColor = func(device, selector, @"DeviceEnclosureColor");
        NSLog(@"Device Color:%@\nDevice encolsure color:%@", deviceColor, deviceEncolsureColor);
        
        [dicResult setValue:deviceColor forKey:@"deviceColor"];
        [dicResult setValue:deviceEncolsureColor forKey:@"deviceEnclosureColor"];
    } else {
        selector = NSSelectorFromString(@"_deviceInfoForKey:");
    }
    return dicResult;
}



#pragma mark - ****************************** Web 服务搭建与配置
- (void)YHCreateWebServerWithPort:(NSUInteger)port AndBonjourName:(nonnull NSString *)name {
    // server init
    webServer = [[GCDWebServer alloc] init];
    // serving a static website
    [webServer addGETHandlerForBasePath:@"/"
                          directoryPath:kDocumentPath
                          indexFilename:nil
                               cacheAge:3600
                     allowRangeRequests:YES];// 服务于静态网站，添加一个程序响应 Get 请求任何的 URL
    // setting port and start server
    [webServer startWithPort:port bonjourName:name];
    NSLog(@"The local web browser link is:\nServerURL:%@\nServerPort:%lu\nServerName:%@", webServer.serverURL, (unsigned long)webServer.port, webServer.bonjourName);
}

@end
