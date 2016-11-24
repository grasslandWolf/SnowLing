//
//  AppDelegate.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/24.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "AppDelegate.h"

#import "MainTabbarViewController.h"

#define WINDOW_Width 375
// self.window.bounds.size.width

#define WINDOW_Height 568
// self.window.bounds.size.height



@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@property (nonatomic,strong) NSMutableArray * imageArray;

@property (nonatomic,strong) UIScrollView  * guidePageScrollView;

@property (nonatomic,strong) BMKMapManager * mapManager;


@end

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
 
//    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
//        
//       [self setUp];
//        
//    }else{
//        
//        MainTabbarViewController * mainTabbarVC = [[MainTabbarViewController alloc] init];
//        self.window.rootViewController = mainTabbarVC;
//        
//    }
    MainTabbarViewController * mainTabbarVC = [[MainTabbarViewController alloc] init];
    self.window.rootViewController = mainTabbarVC;
    // 统计
    [Bugly startWithAppId:BuglyKEY];
    
   // BeeCloud支付
    
    [BeeCloud initWithAppID:@"3d36882e-3b70-47ee-9fd4-74502323ae93" andAppSecret:@"277e79f2-fca8-42bc-8ab5-5079a3bd748a"];
   // [BeeCloud setSandboxMode:YES]; //测试环境
    

    [BeeCloud initWeChatPay:@"wxf1aa465362b4c8f1"];
   // [BeeCloud initBCWXPay:@""];
    
    // 注册友盟推送
    [self registerNotification:launchOptions];
   // 友盟分享
    [[UMSocialManager defaultManager] openLog:YES];
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"582b10ffb27b0a217400114f"];
    
    // 集成QQ和微信分享
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105751801" appSecret:nil redirectURL:@"www.316fuwu.com"]; // qq
    // 百度地图
    
    self.mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [self.mapManager start:@"qzf6uLP0oiDH5KQG76H5HBQBBgGPnSNA" generalDelegate:nil];
    if (!ret) {
        [SLProressHUD showErrorMessage:@"百度地图打开失败" afterDelay:2.0];
    }
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)registerNotification:(NSDictionary*)launchOptions {

    [UMessage startWithAppkey:@"582b10ffb27b0a217400114f" launchOptions:launchOptions];
    [UMessage registerForRemoteNotifications];

    if (IOS10_OR_LATER ) {

        UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge|UNAuthorizationOptionSound|UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
            if (!error && granted) {
                
            } else {
            
            }
            [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                
            }];
            
        }];
    } else if (IOS8_OR_LATER){
        //iOS 8 - iOS 10系统
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else{
        //iOS 8.0系统以下
       [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
//        [[UIApplication sharedApplication] ];
    }
//
//    [[UIApplication sharedApplication] registerForRemoteNotifications];
//    [self createLocalizedUserNotification];
    [UMessage setLogEnabled:YES]; // 打印日志内容
    
}

-(void)setUp {
    
    NSMutableArray * images = [NSMutableArray arrayWithObjects:@"640-960.png",@"640-960.png",@"640-960.png",@"640-960.png", nil];
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.window.bounds];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDH * images.count, SCREEN_HEIGHT);
    self.guidePageScrollView = scrollView;
    [self.window addSubview:scrollView];
    
    for (int i = 0 ; i < images.count; i++) {
        
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(WINDOW_Width * i, 0, WINDOW_Width, WINDOW_Height);
        NSString * name = images[i];
        imageView.image = [UIImage imageNamed:name];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [scrollView addSubview:imageView];
        
        NSInteger  index =  images.count ;
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(WINDOW_Width * (index - 0.5) - 50, WINDOW_Height - 50, 100, 20);
        [button setTitle:@"进入应用" forState:UIControlStateNormal];
        
        button.layer.cornerRadius = 5.0f;
        button.layer.masksToBounds = YES;
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        button.layer.borderWidth = 1.0f;
        
        button.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(centerMain) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:button];
    }


}

-(void)centerMain {

    [self.guidePageScrollView removeFromSuperview];
    
    MainTabbarViewController * mainTabbarVC = [[MainTabbarViewController alloc] init];
    self.window.rootViewController = mainTabbarVC;
    

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//为保证从支付宝，微信返回本应用，须绑定openUrl. 用于iOS9之前版本
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    if (![BeeCloud handleOpenUrl:url]) {
        //handle其他类型的url
    }
    return YES;
}
// ios9 以后的版本
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {

    if (![BeeCloud handleOpenUrl:url]) {
        
    }
    return YES;
}

// 通知的代理方法
-(void)application:(UIApplication*)app didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken {
    
    [UMessage registerDeviceToken:deviceToken];


}
// iOS10一下用这个方法
-(void)application:(UIApplication*)app didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo {

    //关闭友盟自带的弹出框
    [UMessage setAutoAlert:NO];
    [UMessage didReceiveRemoteNotification:userInfo];
}

// 远程推送APP在前台
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler {


}
//-(void)application:(UIApplication*)app didFailToRegisterForRemoteNotificationsWithError:(nonnull NSError *)error {
//
//}
-(void)application:(UIApplication*)application  didFailToRegisterForRemoteNotificationsWithError:(nonnull NSError *)error {


}
// ios10 以后的方法
-(void)userNotificationCenter:(UNUserNotificationCenter*)center willPresentNotification:(nonnull UNNotification *)notification withCompletionHandler:(nonnull void (^)(UNNotificationPresentationOptions))completionHandler {
    //收到推送的请求
    UNNotificationRequest *request = notification.request;
    
    //收到推送的内容
    UNNotificationContent *content = request.content;
    
    //收到用户的基本信息
    NSDictionary *userInfo = content.userInfo;
    
    //收到推送消息的角标
    NSNumber *badge = content.badge;
    
    //收到推送消息body
    NSString *body = content.body;
    
    //推送消息的声音
    UNNotificationSound *sound = content.sound;
    
    // 推送消息的副标题
    NSString *subtitle = content.subtitle;
    
    // 推送消息的标题
    NSString *title = content.title;
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭友盟自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        [[NSNotificationCenter defaultCenter] postNotificationName:userInfoNotification object:userInfo];

        
    }else {
        // 判断为本地通知
        //此处省略一万行需求代码。。。。。。
        NSLog(@"iOS10 收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
        [SLProressHUD showSuccessMessage:@"收到了本地通知" afterDelay:2.0];
    }
    
    
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    completionHandler(UNNotificationPresentationOptionBadge|
                      UNNotificationPresentationOptionSound|
                      UNNotificationPresentationOptionAlert);


}
-(void)userNotificationCenter:(UNUserNotificationCenter*)center didReceiveNotificationResponse:(nonnull UNNotificationResponse *)response withCompletionHandler:(nonnull void (^)())completionHandler {
    //收到推送的请求
    UNNotificationRequest *request = response.notification.request;
    
    //收到推送的内容
    UNNotificationContent *content = request.content;
    
    //收到用户的基本信息
    NSDictionary *userInfo = content.userInfo;
    
    //收到推送消息的角标
    NSNumber *badge = content.badge;
    
    //收到推送消息body
    NSString *body = content.body;
    
    //推送消息的声音
    UNNotificationSound *sound = content.sound;
    
    // 推送消息的副标题
    NSString *subtitle = content.subtitle;
    
    // 推送消息的标题
    NSString *title = content.title;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        [[NSNotificationCenter defaultCenter] postNotificationName:userInfoNotification object:userInfo];
 
    }else {
        // 判断为本地通知
        //此处省略一万行需求代码。。。。。。
        NSLog(@"iOS10 收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
        [[NSNotificationCenter defaultCenter] postNotificationName:userInfoNotification object:userInfo];
        [SLProressHUD showSuccessMessage:@"点击了通知方法" afterDelay:2.0];
    }
    

    completionHandler(); // 系统要求执行这个方法

}



//定时推送
-(void)createLocalizedUserNotification{
    
    // 设置触发条件 UNNotificationTrigger
    UNTimeIntervalNotificationTrigger *timeTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5.0f repeats:NO];
    
    // 创建通知内容 UNMutableNotificationContent, 注意不是 UNNotificationContent ,此对象为不可变对象。
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"Dely 时间提醒 - title";
    content.subtitle = [NSString stringWithFormat:@"Dely 装逼大会竞选时间提醒 - subtitle"];
    content.body = @"Dely 装逼大会总决赛时间到，欢迎你参加总决赛！希望你一统X界 - body";
    content.badge = @666;
    content.sound = [UNNotificationSound defaultSound];
    content.userInfo = @{@"key1":@"value1",@"key2":@"value2"};
    
    // 创建通知标示
    NSString *requestIdentifier = @"Dely.X.time";
    
    // 创建通知请求 UNNotificationRequest 将触发条件和通知内容添加到请求中
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:timeTrigger];
    
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    // 将通知请求 add 到 UNUserNotificationCenter
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
           // NSLog(@"推送已添加成功 %@", requestIdentifier);
            //你自己的需求例如下面：
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"本地通知" message:@"成功添加推送" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
            //此处省略一万行需求。。。。
        }
    }];
    
}

@end
