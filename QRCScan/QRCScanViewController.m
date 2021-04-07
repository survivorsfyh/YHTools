//
//  QRCScanViewController.m
//  rcp
//
//  Created by liuhonghao on 16/7/25.
//  Copyright © 2016年 mvwchina. All rights reserved.
//

#import "QRCScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIView+Exttension.h"
#import "UIImage+FYH.h"
#import "YHCameraManager.h"

@interface QRCScanViewController () <AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate, YHCameraManagerDelegate>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) UIImageView *scanLineImageView;
@property (nonatomic, strong) UIView *scanWindow;
@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, copy) NSString *result;
@end

@implementation QRCScanViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
//    [self leftNavButtonType:NavLeftButtonTypeBack];
    [self basicConfig];
    [self resumeAnimation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMaskView];
    [self setupScanWindow];
    [self beginScanning];
    [kNotificationCenter addObserver:self
                            selector:@selector(resumeAnimation)
                                name:@"EnterForeground"
                              object:nil];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)basicConfig {
//    self.tabBarController.hidesBottomBarWhenPushed = YES;
//    [self setupNavView]; // 自定义导航
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]]
                                                  forBarMetrics:UIBarMetricsDefault];
    [self leftNavButtonType:NavButtonStyleBackWhite];
    [self settingNavRightButton];
}

- (void)settingNavRightButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [btn setTitle:@"相册" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClickSelPhoto:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)btnClickSelPhoto:(UIButton *)btn {
    NSLog(@"调用系统相册");
    YHCameraManager *cameraMag = [YHCameraManager shareInstance];
    cameraMag.delegate = self;
    [cameraMag openPhotoLibraryWithController:self];
}

- (void)dealloc {
    [kNotificationCenter removeObserver:self name:@"EnterForeground" object:nil];
}



#pragma mark - 自定义导航视图 Btn（注：若不需要相册二维码识别，也可使用该方法）
-(void)setupNavView {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    bgView.userInteractionEnabled = YES;
    //1.返回
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(20, 30, 25, 25);
    [backBtn setBackgroundImage:[[UIImage imageNamed:@"navBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                       forState:UIControlStateNormal];
//    backBtn.contentMode = UIViewContentModeScaleAspectFit;
    [backBtn addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:backBtn];
    [self.view addSubview:bgView];
}



#pragma mark - UI
- (void)setupMaskView {
    CGFloat Margin = 30; //
    CGFloat scanWindowH = self.view.width - 30 * 2;
//    CGFloat scanWindowW = self.view.height - 30 * 2;
    
//    UIView *topBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, 100)]; // 无系统导航版本
    UIView *topBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 100)];
    topBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.view addSubview:topBackgroundView];
    
    UIView *leftBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topBackgroundView.frame), Margin, scanWindowH)];
    leftBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.view addSubview:leftBackgroundView];
    
    UIView *rightBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(self.view.width - Margin, leftBackgroundView.y, leftBackgroundView.width, leftBackgroundView.height)];
    rightBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.view addSubview:rightBackgroundView];
    
    UIView *bottmBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(rightBackgroundView.frame), self.view.width, self.view.height - CGRectGetMaxY(rightBackgroundView.frame))];
    bottmBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.view addSubview:bottmBackgroundView];
}



#pragma mark - 设置相机 UI
- (void)setupScanWindow {
    CGFloat kMargin = 30;
    CGFloat scanWindowH = self.view.width - kMargin * 2;
    CGFloat scanWindowW = self.view.width - kMargin * 2;
    _scanWindow = [[UIView alloc] initWithFrame:CGRectMake(kMargin, 100, scanWindowW, scanWindowH)];
    _scanWindow.clipsToBounds = YES;
    [self.view addSubview:_scanWindow];
    
    self.scanLineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_net"]];
    CGFloat buttonWH = 18;
    
    UIButton *topLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWH, buttonWH)];
    [topLeft setImage:[UIImage imageNamed:@"scan_1"] forState:UIControlStateNormal];
    [_scanWindow addSubview:topLeft];
    
    UIButton *topRight = [[UIButton alloc] initWithFrame:CGRectMake(scanWindowW - buttonWH, 0, buttonWH, buttonWH)];
    [topRight setImage:[UIImage imageNamed:@"scan_2"] forState:UIControlStateNormal];
    [_scanWindow addSubview:topRight];
    
    UIButton *bottomLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, scanWindowH - buttonWH, buttonWH, buttonWH)];
    [bottomLeft setImage:[UIImage imageNamed:@"scan_3"] forState:UIControlStateNormal];
    [_scanWindow addSubview:bottomLeft];
    
    UIButton *bottomRight = [[UIButton alloc] initWithFrame:CGRectMake(topRight.x, bottomLeft.y, buttonWH, buttonWH)];
    [bottomRight setImage:[UIImage imageNamed:@"scan_4"] forState:UIControlStateNormal];
    [_scanWindow addSubview:bottomRight];
    
    UILabel * tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_scanWindow.frame) + 20, self.view.bounds.size.width, 12)];
    tipLabel.text = @"将取景框对准二维码，即可自动扫描";
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.lineBreakMode = NSLineBreakByWordWrapping;
    tipLabel.numberOfLines = 2;
    tipLabel.font=[UIFont systemFontOfSize:12];
    tipLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tipLabel];
}

- (void)resumeAnimation {
    CAAnimation *anim = [self.scanLineImageView.layer animationForKey:@"translationAnimation"];
    if(anim){
        // 1. 将动画的时间偏移量作为暂停时的时间点
        CFTimeInterval pauseTime = self.scanLineImageView.layer.timeOffset;
        // 2. 根据媒体时间计算出准确的启动动画时间，对之前暂停动画的时间进行修正
        CFTimeInterval beginTime = CACurrentMediaTime() - pauseTime;
        
        // 3. 要把偏移时间清零
        [self.scanLineImageView.layer setTimeOffset:0.0];
        // 4. 设置图层的开始动画时间
        [self.scanLineImageView.layer setBeginTime:beginTime];
        
        [self.scanLineImageView.layer setSpeed:1.0];
    } else {
        CGFloat scanNetImageViewH = 241;
        CGFloat scanWindowH = self.view.width - 30 * 2;
        CGFloat scanNetImageViewW = _scanWindow.width;
        
        self.scanLineImageView.frame = CGRectMake(0, -scanNetImageViewH, scanNetImageViewW, scanNetImageViewH);
        CABasicAnimation *scanNetAnimation = [CABasicAnimation animation];
        scanNetAnimation.keyPath = @"transform.translation.y";
        scanNetAnimation.byValue = @(scanWindowH);
        scanNetAnimation.duration = 1.5;
        scanNetAnimation.repeatCount = MAXFLOAT;
        [self.scanLineImageView.layer addAnimation:scanNetAnimation forKey:@"translationAnimation"];
        [_scanWindow addSubview:self.scanLineImageView];
    }
}



#pragma mark - 扫描
- (void)beginScanning {
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if (!input) return;
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //设置有效扫描区域
    CGRect scanCrop=[self getScanCrop:_scanWindow.bounds readerViewBounds:self.view.frame];
    output.rectOfInterest = scanCrop;
    //初始化链接对象
    _session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [_session addInput:input];
    [_session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                   AVMetadataObjectTypeEAN13Code,
                                   AVMetadataObjectTypeEAN8Code,
                                   AVMetadataObjectTypeCode128Code
    ];
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [_session startRunning];
}



#pragma mark - 获取扫描区域的比例关系
- (CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds {
    CGFloat x,y,width,height;
    x = (CGRectGetHeight(readerViewBounds)-CGRectGetHeight(rect))/2/CGRectGetHeight(readerViewBounds);
    y = (CGRectGetWidth(readerViewBounds)-CGRectGetWidth(rect))/2/CGRectGetWidth(readerViewBounds);
    width = CGRectGetHeight(rect)/CGRectGetHeight(readerViewBounds);
    height = CGRectGetWidth(rect)/CGRectGetWidth(readerViewBounds);
    
    return CGRectMake(x, y, width, height);
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count > 0) {
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        self.result = metadataObject.stringValue;
//        self.QRCScanRsultBlock(metadataObject.stringValue);
//        [self.Args setValue:self.result forKey:@"QrCode"];
        [self disMiss];
        [self.Args setValue:self.result forKey:@"QrCode"];
        if (self.delegate && [self.delegate respondsToSelector:@selector(QRCScanCallBack:)]) {
            [self.delegate QRCScanCallBack:self.Args];
        }
    }
}

//- (void)setArgs:(NSMutableDictionary *)Args
//{
//    if (self.Args != Args)
//    {
//        self.Args = Args;
//    }
//
//}

- (void)setQRCScanRsultBlock:(returnQRCScanRsultBlock)QRCScanRsultBlock {
    if (self.QRCScanRsultBlock != QRCScanRsultBlock) {
        self.QRCScanRsultBlock = QRCScanRsultBlock;
    }
}

- (returnQRCScanRsultBlock)QRCScanRsultBlock {
    return self.QRCScanRsultBlock;
}

- (void)disMiss {
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - 提示框
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [_session startRunning];
    } else if (buttonIndex == 1) {
        [self disMiss];
        [self.Args setValue:self.result forKey:@"QrCode"];
        if (self.delegate && [self.delegate respondsToSelector:@selector(QRCScanCallBack:)]) {
            [self.delegate QRCScanCallBack:self.Args];
        }
    }
}



#pragma mark - Delegate
- (void)YHCameraCallBack:(UIImage *)image {
    NSLog(@"相册回调：%@", image);
    // 初始化检测器
    CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    // 监测到的结果数组
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    if (features.count >=1) {
        /** 结果对象 */
        CIQRCodeFeature *feature = [features objectAtIndex:0];
        NSString *scannedRes = feature.messageString;
        [self disMiss];
        NSLog(@"二维码扫码结果：%@", scannedRes);
        [self.Args setValue:scannedRes forKey:@"QrCode"];
        if (self.delegate && [self.delegate respondsToSelector:@selector(QRCScanCallBack:)]) {
            [self.delegate QRCScanCallBack:self.Args];
        }
    } else {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该图片没有包含一个二维码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

@end
