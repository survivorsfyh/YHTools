//
//  WKWebView+Callback.h
//  Integration
//
//  Created by survivors on 2018/2/1.
//  Copyright © 2018年 survivors. All rights reserved.
//

#import <WebKit/WebKit.h>

typedef enum {
    JSONTypeToNormal,
    JSONTypeToString
} JSONType;

@interface WKWebView (Callback)

#pragma mark - Callback
/** AppCallWeb With Dic*/
+ (void)appCallWebWithSn:(NSString *)sn AndParameterDic:(NSDictionary *)dataSource WithWKWebView:(WKWebView *)wkWebView;

/** AppCallWeb With Object(Base)*/
+ (void)appCallWebWithServiceResultSn:(NSString *)sn AndDataSourceObject:(NSObject *)obj WithWKView:(WKWebView *)webView;

/** AppCallWeb With Object(JSON)*/
+ (void)appCallWebWithServiceResultToJsonSn:(NSString *)sn AndDataSourceObject:(NSObject *)obj WithWKView:(WKWebView *)webView;


/** AppCallWeb With Error*/
+ (void)appCallWebErrorMessageWithSn:(NSString *)sn AndErrorMessage:(NSString *)error WithWKWebView:(WKWebView *)webView;

/**
 AppCallWeb With Object(Up)
 
 @param sn              标识
 @param flag            状态
 @param errorMessage    异常
 @param obj             数据源
 @param dataType        数据格式
 @param webView         控件
 */
+ (void)appCallWebWithServiceResultSn:(NSString *)sn AndFlag:(NSString *)flag AndErrorMessage:(NSString *)errorMessage AndDataSourceObject:(NSObject *)obj AndDataModelType:(JSONType)dataType WithWKView:(WKWebView *)webView;

#pragma mark - Pack data
/**
 回调数据样式组装
 
 @param obj             数据源
 @param flag            状态
 @param errorMessage    异常
 @param type            数据对象转 json
 @return    结果集
 */
+ (NSMutableDictionary *)packDataSourceWithObject:(NSObject *)obj AndFlag:(NSString *)flag AndErrorMessage:(NSString *)errorMessage AndDataToJSON:(JSONType)type;

@end
