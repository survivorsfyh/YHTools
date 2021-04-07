//
//  QRCScanViewController.h
//  rcp
//
//  Created by liuhonghao on 16/7/25.
//  Copyright © 2016年 mvwchina. All rights reserved.
//

/*
    相机扫码相关
 */
//#import <UIKit/UIKit.h>
#import "FYHBaseViewController.h"
typedef void(^returnQRCScanRsultBlock)(NSString *result);
@protocol QRCScanViewControllerDelegate <NSObject>

- (void)QRCScanCallBack:(NSMutableDictionary *)Dic;

@end
@interface QRCScanViewController : FYHBaseViewController

@property (nonatomic, strong) NSMutableDictionary *Args;
@property (nonatomic, assign) id<QRCScanViewControllerDelegate>delegate;
@property (nonatomic, copy) returnQRCScanRsultBlock QRCScanRsultBlock;

- (void)setQRCScanRsultBlock:(returnQRCScanRsultBlock)QRCScanRsultBlock;
- (returnQRCScanRsultBlock)QRCScanRsultBlock;

@end
