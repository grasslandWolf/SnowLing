//
//  SnowLing.h
//  SnowLing
//
//  Created by 刘新乐 on 16/10/24.
//  Copyright © 2016年 lxl. All rights reserved.
//

#ifndef SnowLing_h
#define SnowLing_h

// 积分变动的时候调用
#define NotificationIntegralChange @"NotificationIntegralChange"
#define userInfoNotification @"userInfoNotification"

// 定义版本号
#define IOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)



#define TokenKey @"TokenKey"

#define PassWordKey @"PassWordKey"

#define phoneKey @"phoneKey"

#define BuglyKEY @"4bcde65b69"

#define SCREEN_WIDH [UIScreen mainScreen].bounds.size.width


#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define CCPRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define CRColor(r) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:1.0]

#define COLOR_CLEAR [UIColor clearColor]


#define TEST
//#define Formal

#ifdef TEST
#define KURL @"http://api.maijiaxiu88.com"
#endif

#ifdef Formal
#define KURL @"http://app.maijiaxiu88.com"
#endif



typedef int  (^IntBlock) ();
typedef id   (^IDBlock)  ();

typedef void (^VoidBlock_int)(int);
typedef int  (^IntBlock_int) (int);
typedef id   (^IDBlock_int)  (int);



typedef void (^VoidBlock_id)(id);
typedef int  (^IntBlock_id) (id);
typedef id   (^IDBlock_id)  (id);


typedef void (^VoidBlock_Two_Params_id)(id, id);


#define COLOR_141 [UIColor colorWithRed:141/255.0 green:141/255.0 blue:141/255.0 alpha:1.0] 
#define COLOR_Theme [UIColor colorWithRed:251 / 255. green:75 / 255. blue:96 / 255. alpha:1.]
#define COLOR_BACK [UIColor colorWithRed:241 / 255. green:242 / 255. blue:247 / 255. alpha:1.]
#define COLOR_174 [UIColor colorWithRed:174/255.0 green:174/255.0 blue:174/255.0 alpha:1.0]
#define COLOR_50 [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0]
#define COLOR_222 [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1.0]


#endif /* SnowLing_h */
