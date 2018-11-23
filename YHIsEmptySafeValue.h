//
//  YHIsEmptySafeValue.h
//  Integration
//
//  Created by survivors on 2018/8/30.
//  Copyright © 2018年 survivors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YHIsEmptySafeValue : NSObject

/**
 过滤 value 中空值

 [NSString stringWithFormat:@"%@", SafeValue([dicCommand objectForKey:@"command"])]
 
 @param value   需要判断过滤的 value 值
 @return        处理后的结果
 */
extern NSString *SafeValue(id value);

/**
 将接口返回数据中的空值默认转为字符串

 @param dataObj     数据源
 @return            结果集
 */
extern id changeType(id dataObj);


@end
