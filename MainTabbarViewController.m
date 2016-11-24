//
//  MainTabbarViewController.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/24.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "MainTabbarViewController.h"
#import "HOMEViewController.h" // 首页
#import "MeViewController.h" // 我的
#import "TaskViewController.h" // 任务
#import "CarViewController.h" //购物车
#import "LoginViewController.h"

@interface MainTabbarViewController ()

@end

@implementation MainTabbarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupAllChildViewControllers];
}

-(void)setupAllChildViewControllers {
    
    HOMEViewController * homeVC = [[HOMEViewController alloc] init];
    [self setupChildViewController:homeVC title:@"首页" imageName:@"home_unselected@2x.png" selectedImageName:@"home_selected@2x.png"];
    
    TaskViewController * taskVC = [[TaskViewController alloc] init];
    [self setupChildViewController:taskVC title:@"任务" imageName:@"growup_unselected@2x.png" selectedImageName:@"growup_selected@2x.png"];
    
    CarViewController * carVC = [[CarViewController alloc] init];
    [self setupChildViewController:carVC title:@"购物车" imageName:@"message@2x.png" selectedImageName:@""];
    
    MeViewController * meVC = [[MeViewController alloc] init];
    [self setupChildViewController:meVC title:@"我的" imageName:@"mine_unselected@2x.png" selectedImageName:@"mine_selected@2x.png"];
    self.tabBar.tintColor = [UIColor redColor];
    
    self.tabBar.backgroundColor = [UIColor clearColor];

}

// 初始化主视图
/**
 *  初始化一个子控制器
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 2.包装一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
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

@end
