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
    
static inline void pg_swizzleSelector(Class theClass, SEL originalSelector, SEL swizzledSelector) {
    Method originaMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    method_exchangeImplementations(originaMethod, swizzledMethod);
}

+ (void)load {
    if (9 <= [UIDevice currentDevice].systemVersion.floatValue) {
        pg_swizzleSelector(UIDevice.class,
                           @selector(endGeneratingDeviceOrientationNotifications),
                           @selector(pgEndGeneratingDeviceOrientationNotifications));
    }
    
//     if (9.0 <= [UIDevice currentDevice].systemVersion.floatValue) {
//         method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"swizzledSetAllowsBackgroundLocationUpdates:")),
//                 class_getInstanceMethod(self.class, @selector(swizzledSetAllowsBackgroundLocationUpdates:)));
//     }
}

- (void)pgEndGeneratingDeviceOrientationNotifications {
    NSLog(@"swizzledSetAllowsBackgroundLocationUpdates isMainThread:%d", [NSThread isMainThread]);
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self pgEndGeneratingDeviceOrientationNotifications];
        });
        return;
    }
    [self pgEndGeneratingDeviceOrientationNotifications];
}

// - (void)swizzledSetAllowsBackgroundLocationUpdates:(BOOL)allow {
//     if (allow) {
//         NSArray *backgroundModes = [[NSBundle mainBundle].infoDictionary objectForKey:@"UIBackgroundModes"];
//         if (backgroundModes && [backgroundModes containsObject:@"location"]) {
//             [self swizzledSetAllowsBackgroundLocationUpdates:allow];
//         } else {
//             NSLog(@"App 想设置后台定位，但 App 的 info.plist 里并没有后台定位权限");
//         }
//     } else {
//         [self swizzledSetAllowsBackgroundLocationUpdates:allow];
//     }
// }

@end
