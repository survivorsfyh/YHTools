//
//  CLLocationManager+YHExtend.m
//  Integration
//
//  Created by survivors on 2019/9/16.
//  Copyright © 2019年 survivors. All rights reserved.
//

#import "CLLocationManager+YHExtend.h"
#import <objc/runtime.h>

@implementation CLLocationManager (YHExtend)

+ (void)load {
    if (9.0 <= [UIDevice currentDevice].systemVersion.floatValue) {
        method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"swizzledSetAllowsBackgroundLocationUpdates:")),
                class_getInstanceMethod(self.class, @selector(swizzledSetAllowsBackgroundLocationUpdates:)));
    }
}

- (void)swizzledSetAllowsBackgroundLocationUpdates:(BOOL)allow {
    if (allow) {
        NSArray *backgroundModes = [[NSBundle mainBundle].infoDictionary objectForKey:@"UIBackgroundModes"];
        if (backgroundModes && [backgroundModes containsObject:@"location"]) {
            [self swizzledSetAllowsBackgroundLocationUpdates:allow];
        } else {
            NSLog(@"App 想设置后台定位，但 App 的 info.plist 里并没有后台定位权限");
        }
    } else {
        [self swizzledSetAllowsBackgroundLocationUpdates:allow];
    }
}

@end
