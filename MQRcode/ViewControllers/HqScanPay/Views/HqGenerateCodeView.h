//
//  HqGenerateCodeView.h
//  MQRcode
//
//  Created by macpro on 2018/2/13.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HqGenerateCodeView : UIView

@property (nonatomic,assign) BOOL autoRefresh;
@property (nonatomic,copy) NSString *codeUrl;
@property (nonatomic,strong) NSDictionary *params;

- (void)startGetPayCode;
- (void)stopGetPayCode;


@end
