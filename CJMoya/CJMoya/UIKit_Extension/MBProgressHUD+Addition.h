//
//  MBProgressHUD+Addition.h
//  CJMoya
//
//  Created by 陈吉 on 2018/10/11.
//  Copyright © 2018年 陈吉. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (Addition)
//1.5s后自动消失
+ (void)showMessage:(NSString *)message;
+ (void)showMessage:(NSString *)message inView:(UIView *)view;

//自定义消失时间
+ (void)showMessage:(NSString *)message duration:(NSTimeInterval)duration;
+ (void)showMessage:(NSString *)message duration:(NSTimeInterval)duration inView:(UIView *)view;

+ (void)showLoading;
+ (void)showLoadingInView:(UIView *)view;

+ (void)showSuccessWithMessage:(NSString *)message;
+ (void)showSuccessWithMessage:(NSString *)message inView:(UIView *)view;

+ (void)dismiss;
+ (void)dismissFor:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
