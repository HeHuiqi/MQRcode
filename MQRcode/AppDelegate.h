//
//  AppDelegate.h
//  MQRcode
//
//  Created by macpro on 2018/1/4.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

typedef NS_ENUM(NSUInteger, HqSetRootVC) {
    HqSetRootVCWecome,
    HqSetRootVCLogin,
    HqSetRootVCHome,
};

@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)shareApp;
+ (void)setRootVC:(HqSetRootVC)type;

@property (nonatomic,assign) BOOL isInputGesturePassword;
@property (nonatomic,assign) BOOL isScanRecive;//是否主动扫码收款

@end


