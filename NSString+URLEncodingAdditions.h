//
//  NSString+URLEncodingAdditions.h
//  rcp
//
//  Created by 卢杰文 on 16/1/6.
//  Copyright © 2016年 mvwchina. All rights reserved.
//

/*
    URL 编、解码
 */

#import <Foundation/Foundation.h>

@interface NSString (URLEncodingAdditions)
/** 编码*/
- (NSString *)URLEncodedString;
/** 解码*/
- (NSString *)URLDecodedString;

@end
