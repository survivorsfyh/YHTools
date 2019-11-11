//
//  YHCameraManager.h
//  Integration
//
//  Created by survivors on 2018/8/29.
//  Copyright © 2018年 survivors. All rights reserved.
//

/*
 相机管理
 
 1.cameraType(相机类型)
 通用:universal   相机 Camera   相册 PhotoLib
 2.deviceType(设备类型)
 前置 Front 或者后置 Rear
 */

#import <Foundation/Foundation.h>

@protocol YHCameraManagerDelegate <NSObject>

/** 事件回调*/
- (void)YHCameraCallBack:(UIImage *)image;

@end



@interface YHCameraManager : NSObject

@property (nonatomic, assign) id <YHCameraManagerDelegate> delegate;

/** 导航条颜色 */
@property(nonatomic, strong) UIColor *navBarBgColor;
/** item的tintcolor */
@property(nonatomic, strong) UIColor *navBarTintColor;
/** titleView的字体颜色 */
@property(nonatomic, strong) UIColor *navBarTitleColor;
/** 图片是否可以编辑 */
@property(nonatomic, assign) BOOL allowsEditing;



/** 单例对象*/
+ (instancetype)shareInstance;

/**
 调用相机功能

 @param cameraType 相机类型
 @param deviceType 设备类型
 @param controller 控件 VC
 */
- (void)callCameraWithCameraType:(NSString *)cameraType AndDeviceType:(NSString *)deviceType AndController:(UIViewController *)controller;

/**
 调用相机或相册
 
 @param deviceType  摄像头设备类型(默认后置摄像头,前置摄像头需将 deviceType 初始值设置为 @"Front")
 @param controller  当前 VC 控件
 */
- (void)openCameraOrPhotoLibraryWithCameraDeviceType:(NSString *)deviceType AndController:(UIViewController *)controller;

/**
 调用相机拍照
 
 @param deviceType 摄像头设备类型(默认后置摄像头,前置摄像头需将 deviceType 初始值设置为 @"Front")
 @param controller 当前 VC 控件
 */
- (void)openCameraWithCameraDeviceType:(NSString *)deviceType AndController:(UIViewController *)controller;

/**
 调用相机拍摄

 @param deviceType deviceType 摄像头设备类型(默认后置摄像头,前置摄像头需将 deviceType 初始值设置为 @"Front")
 @param controller controller 当前 VC 控件
 */
- (void)openCameraVideoWithCameraDeviceType:(NSString *)deviceType AndController:(UIViewController *)controller;

/**
 调用相册

 @param controller 当前 VC 控件
 */
- (void)openPhotoLibraryWithController:(UIViewController *)controller;



/**
 图片转 Base64

 @param img     原图片
 @param type    图片类型(PNG 或 JPEG)
 @return        处理结果
 */
+ (NSString *)imageBase64EncodedWithImage:(UIImage *)img AndImageType:(NSString *)type;

/**
 Base64 图片转 UImage

 @param str 原 Base64 图片
 @return    处理结果
 */
+ (UIImage *)imageBase64DecodedWithImageStr:(NSString *)str;

@end
