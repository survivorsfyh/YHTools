    //
//  WKWebView+Callback.m
//  Integration
//
//  Created by survivors on 2018/2/1.
//  Copyright © 2018年 survivors. All rights reserved.
//

#import "WKWebView+Callback.h"
#import "NSDictionary+JSON.h"

@implementation WKWebView (Callback)

/**
 AppCallWeb With Base

 @param sn          相互握手间的协议
 @param dataSource  数据源(Dic)
 @param wkWebView   当前 webView 控件
 */
+ (void)appCallWebWithSn:(NSString *)sn AndParameterDic:(NSDictionary *)dataSource WithWKWebView:(WKWebView *)wkWebView {
    if (kDictIsEmpty(dataSource)) {
        dataSource = [NSDictionary dictionary];
    }
    // URL 编码
    NSString *appCallWeb = [NSString stringWithFormat:@"Elf.AppCallWeb('%@','%@');", sn, [[dataSource jsonString] URLEncodedString]];
    
    [wkWebView evaluateJavaScript:appCallWeb completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        if (error) {
            NSLog(@"AppCallWeb With Base:\nResult --- %@\nError --- %@",result, error);
        }
    }];
}

/**
 AppCallWeb With Service Result_Base

 @param sn      相互握手间的协议
 @param obj     数据源
 @param webView 当前 webView 控件
 */
+ (void)appCallWebWithServiceResultSn:(NSString *)sn AndDataSourceObject:(NSObject *)obj WithWKView:(WKWebView *)webView {
//    if (kObjectIsEmpty(obj)) {
//        if ([obj isKindOfClass:[NSString class]]) {
//            obj = [NSString string];
//        }
//        else if ([obj isKindOfClass:[NSDictionary class]]) {
//            obj = [NSDictionary dictionary];
//        }
//        else if ([obj isKindOfClass:[NSMutableDictionary class]]) {
//            obj = [NSMutableDictionary dictionary];
//        }
//        else if ([obj isKindOfClass:[NSArray class]]) {
//            obj = [NSArray array];
//        }
//        else if ([obj isKindOfClass:[NSMutableArray class]]) {
//            obj = [NSMutableArray array];
//        }
//        else {
//            obj = @"";
//        }
//    }
    
//    // 拼接 H5 样式
//    NSDictionary *dicServiceResult = @{
//                                       @"flag"  :@"",
//                                       @"result":obj
//                                       };
//    NSDictionary *dicCallWeb = @{
//                                 @"errorMessage"    :@"",
//                                 @"opFlag"          :@"true",
//                                 @"serviceResult"   :dicServiceResult,
//                                 @"timestamp"       :getCurrentTime
//                                 };
    NSDictionary *dicCallWeb = [self packDataSourceWithObject:obj
                                                      AndFlag:@"true"
                                              AndErrorMessage:@""
                                                AndDataToJSON:JSONTypeToNormal];
    
    [self appCallWebWithSn:sn AndParameterDic:dicCallWeb WithWKWebView:webView];
}

/**
 AppCallWeb With Service Result_JSON

 @param sn      相互握手间的协议
 @param obj     数据源
 @param webView 当前 webView 控件
 */
+ (void)appCallWebWithServiceResultToJsonSn:(NSString *)sn AndDataSourceObject:(NSObject *)obj WithWKView:(WKWebView *)webView {
//    if (kObjectIsEmpty(obj)) {
//        if ([obj isKindOfClass:[NSString class]]) {
//            obj = [NSString string];
//        }
//        else if ([obj isKindOfClass:[NSDictionary class]]) {
//            obj = [NSDictionary dictionary];
//        }
//        else if ([obj isKindOfClass:[NSMutableDictionary class]]) {
//            obj = [NSMutableDictionary dictionary];
//        }
//        else if ([obj isKindOfClass:[NSArray class]]) {
//            obj = [NSArray array];
//        }
//        else if ([obj isKindOfClass:[NSMutableArray class]]) {
//            obj = [NSMutableArray array];
//        }
//        else {
//            obj = @"";
//        }
//    }
    
    // 拼接 H5 样式
//    NSDictionary *dicServiceResult = @{
//                                       @"flag"          :@"true",
//                                       @"errorMessage"  :@"",
//                                       @"result"        :obj
//                                       };
//    NSDictionary *dicCallWeb = @{
//                                 @"errorMessage"    :@"",
//                                 @"opFlag"          :@"true",
//                                 @"timestamp"       :getCurrentTime,
//                                 @"serviceResult"   :[dicServiceResult jsonString]
//                                 };
    NSMutableDictionary *dicCallWeb = [self packDataSourceWithObject:obj
                                                             AndFlag:@"true"
                                                     AndErrorMessage:@""
                                                       AndDataToJSON:JSONTypeToString];
    
    [self appCallWebWithSn:sn AndParameterDic:dicCallWeb WithWKWebView:webView];
}



/**
 AppCallWeb
 
 @param sn              标识
 @param flag            状态
 @param errorMessage    异常
 @param obj             数据源
 @param dataType        数据格式
 @param webView         控件
 */
+ (void)appCallWebWithServiceResultSn:(NSString *)sn AndFlag:(NSString *)flag AndErrorMessage:(NSString *)errorMessage AndDataSourceObject:(NSObject *)obj AndDataModelType:(JSONType)dataType WithWKView:(WKWebView *)webView {
    NSMutableDictionary *dicCallback = [self packDataSourceWithObject:obj
                                                              AndFlag:flag
                                                      AndErrorMessage:errorMessage
                                                        AndDataToJSON:dataType];
    
    // Callback
    [self appCallWebWithSn:sn AndParameterDic:dicCallback WithWKWebView:webView];
}



/**
 AppCallWeb With Error

 @param sn      相互握手间的协议
 @param error   异常信息提示
 @param webView 当前 WebView 控件
 */
+ (void)appCallWebErrorMessageWithSn:(NSString *)sn AndErrorMessage:(NSString *)error WithWKWebView:(WKWebView *)webView {
    NSString *errorMsg = error;
    NSMutableDictionary *serviceResult = [NSMutableDictionary dictionary];
    [serviceResult setValue:errorMsg forKey:@"errorMessage"];
    [serviceResult setValue:@"false" forKey:@"result"];
    [serviceResult setValue:@"false" forKey:@"flag"];
    NSMutableDictionary *dicCallWeb = [NSMutableDictionary dictionary];
    [dicCallWeb setValue:getCurrentTime forKey:@"timestamp"];
    [dicCallWeb setValue:errorMsg forKey:@"errorMessage"];
    [dicCallWeb setValue:@"false" forKey:@"opFlag"];
    [dicCallWeb setObject:serviceResult forKey:@"serviceResult"];
    
    [self appCallWebWithSn:sn AndParameterDic:dicCallWeb WithWKWebView:webView];
}



/**
 回调数据样式组装

 @param obj             数据源
 @param flag            状态
 @param errorMessage    异常
 @param type            数据对象转 json
 @return    结果集
 */
+ (NSMutableDictionary *)packDataSourceWithObject:(NSObject *)obj AndFlag:(NSString *)flag AndErrorMessage:(NSString *)errorMessage AndDataToJSON:(JSONType)type {
    if (kObjectIsEmpty(obj)) {
        if ([obj isKindOfClass:[NSString class]]) {
            obj = [NSString string];
        }
        else if ([obj isKindOfClass:[NSDictionary class]]) {
            obj = [NSDictionary dictionary];
        }
        else if ([obj isKindOfClass:[NSMutableDictionary class]]) {
            obj = [NSMutableDictionary dictionary];
        }
        else if ([obj isKindOfClass:[NSArray class]]) {
            obj = [NSArray array];
        }
        else if ([obj isKindOfClass:[NSMutableArray class]]) {
            obj = [NSMutableArray array];
        }
        else {
            obj = @"";
        }
    }
    
    /** CallBack*/
    NSMutableDictionary *dicCallBack = [NSMutableDictionary dictionary];
    
    // Packing data
    NSMutableDictionary *dicServiceResult = [NSMutableDictionary dictionary];
    [dicServiceResult setValue:flag forKey:@"flag"];
    [dicServiceResult setValue:errorMessage forKey:@"errorMessage"];
    [dicServiceResult setObject:obj forKey:@"result"];
    
    [dicCallBack setValue:errorMessage forKey:@"errorMessage"];
    [dicCallBack setValue:flag forKey:@"opFlag"];
    [dicCallBack setValue:getCurrentTime forKey:@"timestamp"];
    
    if (type == JSONTypeToNormal) {
        [dicCallBack setObject:dicServiceResult forKey:@"serviceResult"];
    }
    else if (type == JSONTypeToString) {
        [dicCallBack setObject:dictionaryToJson(dicServiceResult) forKey:@"serviceResult"];
    }
    else {
        [dicCallBack setObject:dicServiceResult forKey:@"serviceResult"];
    }
    
    return dicCallBack;
}


@end
