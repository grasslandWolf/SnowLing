//
//  SLProressHUD.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/26.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "SLProressHUD.h"

#import "JGProgressHUD.h"

@implementation SLProressHUD

+ (void)showSuccessMessage:(NSString *)msg afterDelay:(NSTimeInterval)delay
{
    
    JGProgressHUD *hud = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    hud.layoutChangeAnimationDuration = 0.3;
    hud.indicatorView = [[JGProgressHUDSuccessIndicatorView alloc] init];
    hud.textLabel.text = msg;
    hud.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
    [hud showInView:[UIApplication sharedApplication].keyWindow];
    
    if (delay <= 0.0f) {
        delay = 2.0f;
    }
    
    [hud dismissAfterDelay:delay];
}


+ (void)showErrorMessage:(NSString *)errMsg afterDelay:(NSTimeInterval)delay
{
    JGProgressHUD *hud = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    hud.textLabel.text = errMsg;
    hud.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
    hud.layoutChangeAnimationDuration = 0.3;
    hud.indicatorView = [[JGProgressHUDErrorIndicatorView alloc] init];
    [hud showInView:[UIApplication sharedApplication].keyWindow];
    
    if (delay <= 0.0f) {
        delay = 2.0f;
    }
    
    [hud dismissAfterDelay:delay];
}


@end
