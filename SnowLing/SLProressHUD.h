//
//  SLProressHUD.h
//  SnowLing
//
//  Created by 刘新乐 on 16/10/26.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLProressHUD : NSObject

+ (void)showSuccessMessage:(NSString*)msg afterDelay:(NSTimeInterval)delay;


+ (void)showErrorMessage:(NSString*)errMsg afterDelay:(NSTimeInterval)delay;

@end
