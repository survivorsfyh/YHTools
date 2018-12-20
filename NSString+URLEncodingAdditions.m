//
//  NSString+URLEncodingAdditions.m
//  rcp
//
//  Created by 卢杰文 on 16/1/6.
//  Copyright © 2016年 mvwchina. All rights reserved.
//

#import "NSString+URLEncodingAdditions.h"

@implementation NSString (URLEncodingAdditions)
//通讯编码
- (NSString *)URLEncodedString {
    NSString *result = (NSString *)
            CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                    (CFStringRef) self,
                    NULL,
                    CFSTR("!*'();:@&=+$,/?%#[] "),
                    kCFStringEncodingUTF8));

    return result;
}
//通讯解码
- (NSString *)URLDecodedString {
    NSString *result = (NSString *)
            CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                    (CFStringRef) self,
                    CFSTR(""),
                    kCFStringEncodingUTF8));
    return result;
}

@end
