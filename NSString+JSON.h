//
//  NSString+JSON.h
//  Trip2013
//
//  Created by shenghua on 7/22/13.
//  Copyright (c) 2013 xunhai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSON)

- (id)jsonObject;

/** dic -> json*/
- (NSString *)dictionaryToJson:(NSDictionary *)dic;

@end
