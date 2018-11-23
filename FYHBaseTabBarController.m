//
//  FYHBaseTabBarController.m
//  Integration
//
//  Created by survivors on 2018/1/30.
//  Copyright © 2018年 survivors. All rights reserved.
//

#import "FYHBaseTabBarController.h"
#import "FYHBaseNavigationController.h"
#import "UIImage+FYH.h"
// Plan B
#import "FYHCustomTabbar.h"
// 跳转 VC 相关
#import "YTHIntegrationVC.h"
#import "YTHIMedVC.h"
#import "YTHStudyVC.h"
#import "YTHExamSystemVC.h"
#import "YTHAssessVC.h"

@interface FYHBaseTabBarController ()

@end

@implementation FYHBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.tintColor = [UIColor colorWithHexString:@"#cc3333"];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.selectedIndex = 0;
    
    UIImage *bgImg = createImage([UIColor clearColor], CGSizeMake(SCREEN_WIDTH, 1));
    
//    [[UITabBar appearance] setShadowImage:bgImg];
    [[UITabBar appearance] setBackgroundImage:bgImg];
    
    // Plan A
    [self createUI];
    
    // Plan B
//    [self setUpTabBar];
//    [self addCenterButton];
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



#pragma mark - Basic config
#pragma mark - ************************************** Setting tabbar height
//- (void)viewWillLayoutSubviews {
//    CGRect tabFrame = self.tabBar.frame;
//    tabFrame.size.height = 44;
//    tabFrame.origin.y = self.view.frame.size.height - 44;
//    self.tabBar.frame = tabFrame;
//}



#pragma mark - Plan A
#pragma mark - ************************************** UI
- (void)createUI {
    // Study_tabbar_Normal_Image    Study_tabbar_Select_Image
    [self addViewControllerWithString:@"YTHStudyVC"
                                title:@"首页"
                                image:@"homePage_tabBar_Normal_Image"
                     andSelectedImage:@"homePage_tabBar_Select_Image"];
    // IMed_tabbar_Normal_Image     IMed_tabbar_Select_Image
    [self addViewControllerWithString:@"YTHIMedVC"
                                title:@"书架"
                                image:@"BookShelf_tabBar_Normal_Image"
                     andSelectedImage:@"BookShelf_tabBar_Select_Image"];
    
    [self addViewControllerWithString:@"YTHExamSystemVC"
                                title:@"考试"
                                image:@"Exam_tabbar_Normal_Image"
                     andSelectedImage:@"Exam_tabbar_Select_Image"];
    
    [self addViewControllerWithString:@"YTHIntegrationVC"
                                title:@"教学"
                                image:@"Integration_tabbar_Normal_Image"
                     andSelectedImage:@"Integration_tabbar_Select_Image"];
    
    [self addViewControllerWithString:@"YTHAssessVC"
                                title:@"我的"
                                image:@"my_tabBar_Normal_Image"
                     andSelectedImage:@"my_tabBar_Select_Image"];
}

#pragma mark - ************************************** The custom method
/**
 VC Add To Tabber Method
 
 @param nameVC      当前 VC 名称
 @param title       当前 VC Title
 @param image       当前 VC 未选中图片样式
 @param select      当前 VC 选中后图片样式
 @return            返回结果 VC
 */
- (UIViewController *)addViewControllerWithString:(NSString *)nameVC title:(NSString *)title image:(NSString *)image andSelectedImage:(NSString *)select {
    Class controllerName = NSClassFromString(nameVC);
    
    UIViewController *tempController = [[controllerName alloc] init];
    tempController.title = title;
    tempController.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tempController.tabBarItem.selectedImage = [[UIImage imageNamed:select] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    FYHBaseNavigationController *nav = [[FYHBaseNavigationController alloc] initWithRootViewController:tempController];
    
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:self.viewControllers];
//    [tempArr addObject:tempController];
    [tempArr addObject:nav];
    self.viewControllers = tempArr;
    
    return tempController;
}



#pragma mark - Plan B
//// Init
//- (void)addCenterButton {
//    FYHCustomTabbar *tabBar = [[FYHCustomTabbar alloc] init];
//    tabBar.tintColor = [UIColor colorWithHexString:@"#cc3333"];
//    tabBar.backgroundColor = [UIColor greenColor];
//    // 通过 KVC 修改系统 tabBar
//    [self setValue:tabBar forKey:@"tabBar"];
//}
//
//// Set tabBar
//- (void)setUpTabBar {
//    // 如下数据可以固定写在项目中,也可以通过接口动态获取
//    NSArray *arrTabBar = @[@{@"title":@"首页", @"image":@"homePage_tabBar_Normal_Image", @"selectedImage":@"homePage_tabBar_Select_Image", @"cls":@"YTHStudyVC"},
//                           @{@"title":@"书架", @"image":@"BookShelf_tabBar_Normal_Image", @"selectedImage":@"BookShelf_tabBar_Select_Image", @"cls":@"YTHIMedVC"},
//                           @{@"title":@"考试", @"image":@"Exam_tabbar_Normal_Image", @"selectedImage":@"Exam_tabbar_Select_Image", @"cls":@"YTHExamSystemVC"},
//                           @{@"title":@"教学", @"image":@"Integration_tabbar_Normal_Image", @"selectedImage":@"Integration_tabbar_Select_Image", @"cls":@"YTHIntegrationVC"},
//                           @{@"title":@"我的", @"image":@"my_tabBar_Normal_Image", @"selectedImage":@"my_tabBar_Select_Image", @"cls":@"YTHAssessVC"}
//                           ];
//    NSMutableArray *arrController = [NSMutableArray arrayWithCapacity:arrTabBar.count];
//    for (NSDictionary *dic in arrTabBar) {
//        [arrController addObject:[self contrllers:dic]];
//    }
//    self.viewControllers = arrController;
//}
//
///**
// 给个字典 返回一个控制器
//
// @param dict 传入创建控制器的字典
// @return 返回的控制器
// */
//- (UIViewController *)contrllers:(NSDictionary *)dict {
//    NSString *title = [NSString stringWithFormat:@"%@", [dict objectForKey:@"title"]];
//    NSString *imgName = [NSString stringWithFormat:@"%@", [dict objectForKey:@"image"]];
//    NSString *selectImgName = [NSString stringWithFormat:@"%@", [dict objectForKey:@"selectedImage"]];
//    NSString *clsName = [NSString stringWithFormat:@"%@", [dict objectForKey:@"cls"]];
//
//    // 基类控制器
//    Class controllerName = NSClassFromString(clsName);
//
////    UIViewController *tempController = [[controllerName alloc] init];
//    FYHBaseViewController *baseVC = [[controllerName alloc] init];
//    baseVC.title = title;
//    [baseVC.tabBarItem setImage:[[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    [baseVC.tabBarItem setSelectedImage:[[UIImage imageNamed:selectImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//
//    [baseVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}
//                                     forState:UIControlStateSelected];
//
//    return baseVC;
//}

































@end
