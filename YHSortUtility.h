//
//  YHSortUtility.h
//  Integration
//
//  Created by survivors on 2018/9/12.
//  Copyright © 2018年 survivors. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSortUtility : NSObject

/**
 冒泡排序

 @param array   数据源
 @return        结果集
 */
+ (NSMutableArray *)bubbleSort:(NSMutableArray *)array;

/**
  选择排序

 @param array   数据源
 @return        结果集
 */
+ (NSMutableArray *)selectSort:(NSMutableArray *)array;

/**
 插入排序

 @param array   数据源
 @return        结果集
 */
+ (NSMutableArray *)insertSort:(NSMutableArray *)array;

/**
 快速排序

 @param array   数据源
 @param low     低
 @param high    高
 @return        结果集
 */
+ (NSMutableArray *)quickSort:(NSMutableArray *)array low:(int)low high:(int)high;


@end
