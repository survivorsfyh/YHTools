//
//  NSString+JSON.m
//  Trip2013
//
//  Created by shenghua on 7/22/13.
//  Copyright (c) 2013 xunhai. All rights reserved.
//

#import "NSString+JSON.h"

extern void dictionaryFilterNullNode(NSMutableDictionary*);
extern void arrayFilterNullNode(NSMutableArray*);

void inline dictionaryFilterNullNode(NSMutableDictionary *dic) {
    NSMutableArray *deleteKeys = [NSMutableArray array];
    [[dic allKeys] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id value = [dic objectForKey:obj];
        if ([value isKindOfClass:[NSNull class]]) {
            [deleteKeys addObject:obj];
        } else if([value isKindOfClass:[NSMutableArray class]]) {
            arrayFilterNullNode(value);
        } else if([value isKindOfClass:[NSMutableDictionary class]]) {
            dictionaryFilterNullNode(value);
        }
    }];
    [deleteKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [dic removeObjectForKey:obj];
    }];    
    deleteKeys;
}

void inline arrayFilterNullNode(NSMutableArray *array) {
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSMutableDictionary class]]) {
            dictionaryFilterNullNode(obj);
        }
    }];
}

@implementation NSString (JSON)
- (id)jsonObject {
    NSError *error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding]
                                                options:NSJSONReadingMutableContainers
                                                  error:&error];
    
    if (error || [NSJSONSerialization isValidJSONObject:result] == NO)
    {
        return self;
    }
    
    if ([result isKindOfClass:[NSMutableArray class]]) {
        arrayFilterNullNode(result);
        
    } else if([result isKindOfClass:[NSMutableDictionary class]]) {
        dictionaryFilterNullNode(result);
        
    }else if ([result isKindOfClass:[NSNull class]]){
//        result;
        NSLog(@"----->%@",result);
        return self;
    }
    
    return result;
}

//dic -> json
- (NSString *)dictionaryToJson:(NSDictionary *)dic {
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



//-(id)JSONValue;
//{
//    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
//    __autoreleasing NSError* error = nil;
//    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//    if (error != nil) return nil;
//    return result;
//}
@end
