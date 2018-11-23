//
//  FYHBaseNavigationController.m
//  Integration
//
//  Created by survivors on 2018/1/30.
//  Copyright © 2018年 survivors. All rights reserved.
//



#import "FYHBaseNavigationController.h"

@interface FYHBaseNavigationController () <UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation FYHBaseNavigationController {
    /** 隐藏 nav 底部横线*/
    UIImageView *navBarHairLineImageView;
}

#pragma mark - ************************************** Setting navBar with tintColor
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {//nav background color:016ed2
        /** Change nav background color*/
//        [[UINavigationBar appearance] setBackgroundImage:createImage(colorWithHexString(@"016ed2"), YQSizeMake(320, 64)) forBarMetrics:UIBarMetricsDefault];
//        self.navigationBar.barTintColor = [UIColor colorWithRed:54/255.0 green:180/255.0 blue:254/255.0 alpha:1.0];
        self.navigationBar.barTintColor = [UIColor colorWithHexString:@"ffffff"];
//        [self.navigationBar cornerSideType:kLQQSideTypeBottom
//                                 lineColor:[UIColor colorWithHexString:@"36b4fe"]
//                                 lineWidth:1.0];
    }
    
    return self;
}



#pragma mark - ************************************** Base
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationBar.translucent = NO;
    self.navigationBar.barTintColor = [UIColor whiteColor];
    
//    navBarHairLineImageView.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak FYHBaseNavigationController *weakSelf = self;
    navBarHairLineImageView = [self findHairlineImageViewUnder:self.navigationBar];
    
    /** 边缘左划手势*/
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
        self.delegate = weakSelf;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    navBarHairLineImageView.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



#pragma mark - ************************************** 查询底部横线的函数
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}



#pragma mark - ************************************** 左边缘翻页
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
}



#pragma mark - ************************************** Delegate
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // Enable the gesture again once the new controller is shown
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

@end
