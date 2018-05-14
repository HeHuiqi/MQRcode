//
//  AppDelegate+HqPushManager.m
//  QRCode
//
//  Created by hehuiqi on 2018/5/12.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "AppDelegate+HqPushManager.h"
#define kPushAppkey @"a3bf6ed12a499a33759bcdc3"
#import "HqPaySuccessVC.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#import <UserNotifications/UserNotifications.h>

@implementation AppDelegate (HqPushManager)


- (void)hqRegisterRemotePushWithLanOption:(NSDictionary *)dic{
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        //        center.delegate = self;
        [center requestAuthorizationWithOptions:UNAuthorizationOptionCarPlay | UNAuthorizationOptionSound | UNAuthorizationOptionBadge | UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
            if (granted) {
                NSLog(@" iOS 10 request notification success");
            }else{
                NSLog(@" iOS 10 request notification fail");
            }
        }];
        
    } else  if (version >= 8.0){
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound | UIUserNotificationTypeBadge | UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
    //注册通知
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    [JPUSHService setupWithOption:dic appKey:kPushAppkey channel:@"app_store" apsForProduction:NO];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken{
    NSLog(@"devicetoken==%@",deviceToken);
    [JPUSHService registerDeviceToken:deviceToken];
    NSString *hqDevicetoken = [NSString stringWithFormat:@"%@",deviceToken];
    hqDevicetoken = [hqDevicetoken stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hqDevicetoken =[hqDevicetoken stringByReplacingOccurrencesOfString:@">" withString:@""];
    hqDevicetoken = [hqDevicetoken stringByReplacingOccurrencesOfString:@" " withString:@""];
    SetUserDefault(hqDevicetoken, kDeviceToken);
    NSString *access_token = GetUserDefault(kToken);
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if (access_token.length>0) {
            [HqHttpUtil hqPut:@{@"deviceType":@"iOS",@"token":registrationID} url:@"/users/tokens" complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
                NSLog(@"上传PushToken==%@",responseObject);
                if (response.statusCode==200) {
                    
                }
                
            }];
        }
    }];
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(nonnull NSError *)error{
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
    
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    NSLog(@"pushMessage==%@",userInfo);
    [JPUSHService handleRemoteNotification:userInfo];
    
    NSString *payOrderNo = [userInfo hq_objectForKey:@"merchantOrderNo"];
    [self getPushOrderInfoWithOrder:payOrderNo];
    
}
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    /*
    if (notificationSettings.types == UIUserNotificationTypeNone) {
        HqAlertView *alert = [[HqAlertView alloc] initWithTitle:@"Push Notify Closed" message:@"Open it?"];
        alert.btnTitles = @[@"Cancel",@"Confirm"];
        [alert showVC:self.window.rootViewController callBack:^(UIAlertAction *action, int index) {
            if (index == 1) {
                NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
    }
    */
}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)){
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    completionHandler(UNNotificationPresentationOptionSound);
    
    NSLog(@"iOS10 前台收到远程通知:%@", userInfo);
    
}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    completionHandler();
    NSLog(@"iOS101 点击收到远程通知:%@", userInfo);
}

- (void)getPushOrderInfoWithOrder:(NSString *)orderNo{
    //主动首款不显示推送界面
    if ([AppDelegate shareApp].isScanRecive) {
        [AppDelegate shareApp].isScanRecive = NO;
        return;
    }
    NSString *url = [NSString stringWithFormat:@"/transactions/orders/%@",orderNo];
    [HqHttpUtil hqGetShowHudTitle:nil param:nil url:url complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"推送账单==%@",responseObject);
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                HqPaySuccessVC *paySuccessVC = [[HqPaySuccessVC alloc] init];
                paySuccessVC.payInfo = responseObject;
                paySuccessVC.isPushShow = YES;
                UIViewController *rootVC = [AppDelegate shareApp].window.rootViewController;
                [rootVC presentViewController:paySuccessVC animated:YES completion:nil];
                
            }else{
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }

    }];
}

@end
