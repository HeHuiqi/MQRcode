//
//  HqPayCodeView.h
//  QRCode
//
//  Created by macpro on 2018/2/11.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HqPayCodeView : UIView

@property (nonatomic,copy) NSString *codeUrl;
@property (nonatomic,assign) BOOL autoRefresh;
@property (nonatomic,assign) BOOL isGetRequest;

@property (nonatomic,strong) NSDictionary *params;

@property (nonatomic,copy) NSString *payCodeInfo;
@property (nonatomic,copy) NSString *password;


- (void)startGetPayCode;
- (void)stopGetPayCode;

@end
