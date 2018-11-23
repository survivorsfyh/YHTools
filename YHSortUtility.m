//
//  YHSortUtility.m
//  Integration
//
//  Created by survivors on 2018/9/12.
//  Copyright © 2018年 survivors. All rights reserved.
//

#import "YHSortUtility.h"

@implementation YHSortUtility

/**
 冒泡排序
 
 @param array   数据源
 @return        结果集
 */
+ (NSMutableArray *)bubbleSort:(NSMutableArray *)array {
    // Check
    if (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0) {
        return [NSMutableArray array];
    }
    else {
        // Sort
        for (NSInteger i = 1; i < array.count; i++) {
            for (NSInteger j = 0; j < array.count - i; j++) {
                if ([array[j] compare:array[1 + j]] == NSOrderedDescending) {
                    [array exchangeObjectAtIndex:j withObjectAtIndex:1 + j];
                }
                
                [self printArray:array];
            }
        }
        // Callback
        return array;
    }
}

/**
 选择排序
 
 @param array   数据源
 @return        结果集
 */
+ (NSMutableArray *)selectSort:(NSMutableArray *)array {
    // Check
    if (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0) {
        return [NSMutableArray array];
    }
    else {
        // Sort
        NSInteger minIndex;
        for (NSInteger i = 0; i < array.count; i++) {
            minIndex = i;
            for (NSInteger j = 1 + i; j < array.count; j++) {
                if ([array[j] compare:array[minIndex]] == NSOrderedAscending) {
                    [array exchangeObjectAtIndex:j withObjectAtIndex:minIndex];
                }
                
                [self printArray:array];
            }
        }
        // Callback
        return array;
    }
}

/**
 插入排序
 
 @param array   数据源
 @return        结果集
 */
+ (NSMutableArray *)insertSort:(NSMutableArray *)array {
    // Check
    if (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0) {
        return [NSMutableArray array];
    }
    else {
        // Sort
        for (NSInteger i = 0; i < array.count; i++) {
            NSNumber *temp = array[i];
            NSInteger j = i - 1;
            
            while (0 <= j && [array[j] compare:temp] == NSOrderedDescending) {
                [array replaceObjectAtIndex:1 + j withObject:array[j]];
                j--;
                
                [self printArray:array];
            }
            
            [array replaceObjectAtIndex:1 + j withObject:temp];
        }
        // Callback
        return array;
    }
}

/**
 快捷排序
 
 @param array   数据源
 @return        结果集
 */
+ (NSMutableArray *)quickSort:(NSMutableArray *)array low:(int)low high:(int)high {
    // Check
    if (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0 || low >= high) {
        return [NSMutableArray array];
    }
    else {
        // Sort
        int middle = low + (high - low) / 2;
        NSNumber *prmt = array[middle];
        int i = low;
        int j = high;
        
        while (i <= j) {
            while ([array[i] intValue] < [prmt intValue]) {
                i++;
            }
            
            while ([array[j] intValue] > [prmt intValue]) {
                j--;
            }
            
            if (i <= j) {
                [array exchangeObjectAtIndex:i withObjectAtIndex:j];
                i++;
                j--;
            }
            
            [self quickSort:array low:low high:j];
        }
        // Callback
        return array;
    }
}



+ (void)printArray:(NSMutableArray *)array {
    for (NSNumber *number in array) {
        NSLog(@"%d", [number intValue]);
    }
    
    NSLog(@"\n");
}

@end
