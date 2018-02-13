//
//  HqPayCodeView.m
//  QRCode
//
//  Created by macpro on 2018/2/11.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqPayCodeView.h"
#import "SGQRCodeGenerateManager.h"
#define HqAllCount 30
@interface HqPayCodeView()

@property (nonatomic,strong) NSTimer *codeAvailabilityTimer;
@property (nonatomic,strong) UIImageView *payCodeImageView;
@property (nonatomic,assign) int tempCount;
@property (nonatomic,assign) BOOL isPaying;//是否正在支付

@end

@implementation HqPayCodeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _isPaying = YES;
        
        [self setup];
    }
    return self;
}
- (instancetype)init{
    if (self = [super init]) {
        _isPaying = YES;
        _autoRefresh = YES;
        [self setup];
    }
    return self;
}
- (NSTimer *)codeAvailabilityTimer{
    if (self.autoRefresh) {
        if (!_codeAvailabilityTimer) {
            _codeAvailabilityTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countTime) userInfo:nil repeats:YES];
        }
        return _codeAvailabilityTimer;
    }
    return nil;
    
}

- (void)destoryTimer{
    _tempCount = 0;
    [_codeAvailabilityTimer invalidate];
    _codeAvailabilityTimer = nil;
}
- (void)countTime{
    _tempCount++;
    if (_tempCount==HqAllCount) {
        _tempCount =0;
        [self startGetPayCode];
    }
//    NSLog(@"+++==%d",_tempCount);
}
- (void)stopGetPayCode{
    [self destoryTimer];
}
- (void)setup{
    
    _payCodeImageView = [[UIImageView alloc]init];
    _payCodeImageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_payCodeImageView];
    [_payCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);

    }];
}


- (void)generateCode{

    UIImage *codeImage = [SGQRCodeGenerateManager  generateWithLogoQRCodeData:self.payCodeInfo logoImageName:@"mrcode_icon" logoScaleToSuperView:0.2];
//    UIImage *codeImage = [SGQRCodeGenerateManager  generateWithDefaultQRCodeData:self.payCodeInfo imageViewWidth:kZoomValue(240)];
    _payCodeImageView.image = codeImage;
}
- (void)setPayCodeInfo:(NSString *)payCodeInfo{
    _payCodeInfo = payCodeInfo;
    if (_payCodeInfo) {
        [self generateCode];
    }
}
- (void)setCodeUrl:(NSString *)codeUrl{
    _codeUrl = codeUrl;
}
- (void)startGetPayCode{
    [self codeAvailabilityTimer];
    NSString *title = @"Please wait";
   
    [self getPayCodeWithUrl:self.codeUrl title:title];
}
- (void)setParams:(NSDictionary *)params{
    _params = params;
}
- (void)getPayCodeWithUrl:(NSString *)url title:(NSString *)title{

    [HqHttpUtil hqGetShowHudTitle:nil param:nil url:url complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"==%@",responseObject);
        
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                NSString *payCode = [responseObject hq_objectForKey:@"collectCode"];
                if (payCode.length>0) {
                    self.payCodeInfo = payCode;
                }
            }else{
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
    }];
    
}
- (void)queryPayStatusWithCode:(NSString *)code{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
