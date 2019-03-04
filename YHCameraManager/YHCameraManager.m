//
//  YHCameraManager.m
//  Integration
//
//  Created by survivors on 2018/8/29.
//  Copyright © 2018年 survivors. All rights reserved.
//

#import "YHCameraManager.h"
#import <AssetsLibrary/AssetsLibrary.h>// 资源库

@interface YHCameraManager () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation YHCameraManager

#pragma mark - ****************************** Base
+ (instancetype)shareInstance {
    static YHCameraManager *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[YHCameraManager alloc] init];
    });
    
    return singleton;
}

#pragma mark - ****************************** Interface methods
/**
 调用相机功能
 
 @param cameraType 相机类型
 @param deviceType 设备类型
 @param controller 控件 VC
 */
- (void)callCameraWithCameraType:(NSString *)cameraType AndDeviceType:(NSString *)deviceType AndController:(UIViewController *)controller {
    if ([cameraType isEqualToString:@"Camera"]) {// 相机
        [self openCameraWithCameraDeviceType:deviceType
                               AndController:controller];
    }
    else if ([cameraType isEqualToString:@"PhotoLib"]) {// 相册
        [self openPhotoLibraryWithController:controller];
    }
    else {// 通用
        [self openCameraOrPhotoLibraryWithCameraDeviceType:deviceType AndController:controller];
    }
}



/**
 调用相机或相册(默认后置摄像头,前置摄像头需将 deviceType 初始值设置为 @"Front")

 @param deviceType  摄像头设备类型
 @param controller  当前 VC 控件
 */
- (void)openCameraOrPhotoLibraryWithCameraDeviceType:(NSString *)deviceType AndController:(UIViewController *)controller {
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:nil
                                                                      message:nil
                                                               preferredStyle:UIAlertControllerStyleActionSheet];
    
    kWeakSelf(self);
    [alertCon addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        [weakself openCameraWithCameraDeviceType:deviceType AndController:controller];
        
    }]];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself openPhotoLibraryWithController:controller];
        
    }]];
    
    [alertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [controller presentViewController:alertCon animated:YES completion:^{
        
    }];
}



/**
 调用相机拍照(默认后置摄像头,前置摄像头需将 deviceType 初始值设置为 @"Front")

 @param deviceType 摄像头设备类型
 @param controller 当前 VC 控件
 */
- (void)openCameraWithCameraDeviceType:(NSString *)deviceType AndController:(UIViewController *)controller {
    // 判断是否可以打开照相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *pickerCon = [[UIImagePickerController alloc] init];
        pickerCon.delegate = self;
        pickerCon.allowsEditing = YES;// 设置拍摄的照片是否允许编辑
        
        // 摄像头
        pickerCon.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerCon.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;// 设置拍照类型(拍照 & 摄像)
        pickerCon.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;// 闪光灯,默认:关闭状态
        if ([deviceType isEqualToString:@"Front"]) {// 设置使用手机摄像头类型
            pickerCon.cameraDevice = UIImagePickerControllerCameraDeviceFront;// 设置使用手机前置摄像头
        }
        else {
            pickerCon.cameraDevice = UIImagePickerControllerCameraDeviceRear;// 设置使用手机后置摄像头
        }
        
        [controller presentViewController:pickerCon animated:YES completion:^{
            NSLog(@"调用了 --- 摄像头");
        }];
    }
    else {
        [MBProgressHUD showCommonHudWithAlertString:@"当前未开启相机权限" afterDelay:2.0 toView:controller.view];
    }
}

/**
 调用相机拍摄
 
 @param deviceType deviceType 摄像头设备类型(默认后置摄像头,前置摄像头需将 deviceType 初始值设置为 @"Front")
 @param controller controller 当前 VC 控件
 */
- (void)openCameraVideoWithCameraDeviceType:(NSString *)deviceType AndController:(UIViewController *)controller {
    // 判断是否可以打开照相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *pickerCon = [[UIImagePickerController alloc] init];
        pickerCon.delegate = self;
        pickerCon.allowsEditing = YES;// 设置拍摄的照片是否允许编辑
        
        // 摄像头
        pickerCon.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerCon.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];// 将 mediaType 设置为所有支持的媒体类型
        pickerCon.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;// 设置拍照类型(拍照 & 摄像)
        pickerCon.videoQuality = UIImagePickerControllerQualityTypeHigh;// 设置拍摄视频的清晰度,高清模式
        if ([deviceType isEqualToString:@"Front"]) {// 设置使用手机摄像头类型
            pickerCon.cameraDevice = UIImagePickerControllerCameraDeviceFront;// 设置使用手机前置摄像头
        }
        else {
            pickerCon.cameraDevice = UIImagePickerControllerCameraDeviceRear;// 设置使用手机后置摄像头
        }
        
        [controller presentViewController:pickerCon animated:YES completion:^{
            NSLog(@"调用了 --- 摄像头");
        }];
    }
    else {
        [MBProgressHUD showCommonHudWithAlertString:@"当前未开启相机权限" afterDelay:2.0 toView:controller.view];
    }
}

/**
 调用相册
 
 @param controller 当前 VC 控件
 */
- (void)openPhotoLibraryWithController:(UIViewController *)controller {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        
        [controller presentViewController:imagePicker animated:YES completion:^{
            NSLog(@"调用了 --- 相册");
        }];
    }
    else {
        [MBProgressHUD showCommonHudWithAlertString:@"无法打开相册" afterDelay:2.0 toView:controller.view];
    }
}



#pragma mark - ****************************** UIImagePickerControllerDelegate
/**
 拍照完成回调

 @param picker  控件
 @param info    数据
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"UIImagePickerControllerDelegate --- FinishPickingMedia");
    
    // 获取拍摄数据的类型(照片 or 视频)
//    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera || picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {// 图片 [mediaType isEqualToString:(NSString *)kUTTypeImage]
        UIImage *theImg = nil;
        if ([picker allowsEditing]) {// 判断图片是否允许修改
            // 获取用户编辑之后的图像
            theImg = [info objectForKey:UIImagePickerControllerEditedImage];
        }
        else {// 获取原图
            theImg = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        // 保存图片至相册中
        UIImageWriteToSavedPhotosAlbum(theImg, self, nil, nil);
        
        // 图片后续处理相关
        if ([self.delegate respondsToSelector:@selector(YHCameraCallBack:)]) {
            [self.delegate YHCameraCallBack:theImg];
        }
    }
    else {// 视频
        // 获取视频文件 url
        NSURL *urlMedia = [info objectForKey:UIImagePickerControllerMediaType];
        // 创建 ALAssetsLibrary 对象并将视频保存到媒体库
        ALAssetsLibrary *assetsLib = [[ALAssetsLibrary alloc] init];
        // 将视频保存至相册
        [assetsLib writeVideoAtPathToSavedPhotosAlbum:urlMedia completionBlock:^(NSURL *assetURL, NSError *error) {
            if (error) {
                NSLog(@"视频拍摄 --- 写入失败:%@", error);
            }
            else {
                NSLog(@"视频拍摄 --- 写入成功");
            }
        }];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];// 通过 key 值获取相片
//    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);// 图片存入相册
//
//        // 图片后续处理相关
//        if ([self.delegate respondsToSelector:@selector(YHCameraCallBack:)]) {
//            [self.delegate YHCameraCallBack:image];
//        }
//
//    }
//    else if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
//        // 图片后续处理相关
//        if ([self.delegate respondsToSelector:@selector(YHCameraCallBack:)]) {
//            [self.delegate YHCameraCallBack:image];
//        }
//
//    }
//
//    [picker dismissViewControllerAnimated:YES completion:^{
//
//    }];
}

/**
 拍照页面取消选择的时候,调用该方法

 @param picker 当前控件
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}



#pragma mark - ****************************** Expand
/**
 获取图片详细信息
 
 图片名称、唯一标示、路径 URL
 
 @param imgUrl 当前图片资源
 */
- (void)getImageDetailInfo:(NSURL *)imgUrl {
    __block NSString *imgFileName;
    ALAssetsLibrary *assetsLib = [[ALAssetsLibrary alloc] init];
    [assetsLib assetForURL:imgUrl resultBlock:^(ALAsset *asset) {
        ALAssetRepresentation *representation = [asset defaultRepresentation];
        imgFileName = [representation filename];
        NSLog(@"Image info:\nImage UTI --- %@\nImage URL --- %@\nFile Path --- %@", [representation UTI], [representation url], imgFileName);
        
    } failureBlock:^(NSError *error) {
        NSLog(@"GetImageDetailInfo --- Error\n%@", error);
    }];
    
}



/**
 图片转 Base64
 
 @param img     原图片
 @param type    图片类型(PNG 或 JPEG)
 @return        处理结果
 */
+ (NSString *)imageBase64EncodedWithImage:(UIImage *)img AndImageType:(NSString *)type {
    NSString *callBack = nil;
    if ([img isKindOfClass:[UIImage class]]) {
        NSData *data = [NSData data];
        if ([type isEqualToString:@"PNG"]) {
            data = UIImagePNGRepresentation(img);
        }
        else {
            data = UIImageJPEGRepresentation(img, 1.0f);
        }
        
        NSString *encodedImgStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        NSLog(@"YHCameraManager\nencodedImgStr: %@", encodedImgStr);
        return encodedImgStr;
    }
    else {
        return callBack;
    }
}

/**
 Base64 图片转 UImage
 
 @param str 原 Base64 图片
 @return    处理结果
 */
+ (UIImage *)imageBase64DecodedWithImageStr:(NSString *)str {
    if (str == nil) {
        return nil;
    }
    else {
        NSData *decodedImageData = [[NSData alloc] initWithBase64EncodedString:str
                                                                       options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *decodedImg = [UIImage imageWithData:decodedImageData];
        
        NSLog(@"YHCameraManager\ndecodedImgStr: %@", decodedImg);
        return decodedImg;
    }
}


@end
