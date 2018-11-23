//
//  YHIsEmptySafeValue.m
//  Integration
//
//  Created by survivors on 2018/8/30.
//  Copyright © 2018年 survivors. All rights reserved.
//

#import "YHIsEmptySafeValue.h"

@implementation YHIsEmptySafeValue

#pragma mark - 过滤 value 中空值
/**
 过滤 value 中空值
 
 @param value   需要判断过滤的 value 值
 @return        处理后的结果
 */
NSString *SafeValue(id value) {
    if (!value) {
        return @"";
    }
    else if ([value isKindOfClass:[NSString class]]) {
        if ([value isEqualToString:@"<null>"] || [value isEqualToString:@"null"] || [value isEqualToString:@"(null)"] || [value isEqualToString:@"nil"]) {
            return @"";
        }
        else {
            return value;
        }
        
    }
    else {
        return [NSString stringWithFormat:@"%@", value];
    }
}

#pragma makr - 将接口返回数据中的空值默认转为字符串
/**
 将接口返回数据中的空值默认转为字符串
 
 @param dataObj     数据源
 @return            结果集
 */
id changeType(id dataObj) {
    if ([dataObj isKindOfClass:[NSDictionary class]]) {
        return nullDic(dataObj);
    }
    else if ([dataObj isKindOfClass:[NSArray class]]) {
        return nullArr(dataObj);
    }
    else if ([dataObj isKindOfClass:[NSString class]]) {
        return stringToString(dataObj);
    }
    else if ([dataObj isKindOfClass:[NSNull class]]) {
        return nullStr(dataObj);
    }
    else {
        return dataObj;
    }
}

/**
 将 NSDictionary 中的 null 类型转化为空字符串 @""

 @param dic     数据源
 @return        结果集
 */
NSDictionary *nullDic(NSDictionary *dic) {
    NSArray *arrKey = [dic allKeys];
    NSMutableDictionary *dicResult = [NSMutableDictionary dictionary];
    for (NSInteger i = 0; i < arrKey.count; i++) {
        id obj = [dic objectForKey:arrKey[i]];
        obj = changeType(obj);
        // Add
        [dicResult setObject:obj forKey:arrKey[i]];
    }
    // Callback
    return dicResult;
}

/**
 将 NSArray 中的 null 类型转化为空字符串 @""

 @param arr     数据源
 @return        结果集
 */
NSArray *nullArr(NSArray *arr) {
    NSMutableArray *arrResult = [NSMutableArray array];
    for (NSInteger i = 0; i < arr.count; i++) {
        id obj = arr[i];
        obj = changeType(obj);
        // Add
        [arrResult addObject:obj];
    }
    // Callback
    return arrResult;
}

/**
 将 NSString 中的 null 类型转化为空字符串 @""

 @param str 数据源
 @return    结果集
 */
NSString *nullStr(NSString *str) {
    return @"";
}

/**
 将 NSString 类型直接返回
 
 @param str 数据源
 @return    结果集
 */
NSString *stringToString(NSString *str) {
    return str;
}

@end
