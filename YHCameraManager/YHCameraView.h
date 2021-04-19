//
//  YHCameraView.h
//  Integration
//
//  Created by fyh survivors on 2021/4/15.
//  Copyright © 2021 survivors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreVideo/CoreVideo.h>
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHCameraView : UIView <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, weak) UIImageView *cameraImageView;
@property (strong, nonatomic) AVCaptureDevice* device;
@property (strong, nonatomic) AVCaptureSession* captureSession;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer* previewLayer;
@property (strong, nonatomic) UIImage* cameraImage;

@end

NS_ASSUME_NONNULL_END
