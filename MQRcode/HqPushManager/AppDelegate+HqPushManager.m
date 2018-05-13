//
//  AppDelegate+HqPushManager.m
//  QRCode
//
//  Created by hehuiqi on 2018/5/12.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "AppDelegate+HqPushManager.h"
#define kPushAppkey @"b5c33278c3c65090650db7e1"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#import <UserNotifications/UserNotifications.h>

@implementation AppDelegate (HqPushManager)


- (void)hqRegisterRemotePushWithLanOption:(NSDictionary *)dic{
    
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        
        [center requestAuthorizationWithOptions:UNAuthorizationOptionCarPlay | UNAuthorizationOptionSound | UNAuthorizationOptionBadge | UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
            if (granted) {
                NSLog(@" iOS 10 request notification success");
            }else{
                NSLog(@" iOS 10 request notification fail");
            }
        }];
    } else {
        CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (version >= 8.0)
        {
            UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound | UIUserNotificationTypeBadge | UIUserNotificationTypeAlert categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
        }
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
            [HqHttpUtil hqPut:@{@"deviceType":@"iOS",@"token":hqDevicetoken} url:@"/users/tokens" complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
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
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)){
    
    NSDictionary * userInfo = notification.request.content.userInfo;

    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
    
    NSLog(@"iOS10 前台收到远程通知:%@", userInfo);

}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = response.notification.request.content.userInfo;

    completionHandler();
    NSLog(@"iOS101 收到远程通知:%@", userInfo);
}

@end
