//
//  HqMyPayCodeView.m
//  QRCode
//
//  Created by macpro on 2018/1/19.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqMyPayCodeView.h"
#import "SGQRCodeGenerateManager.h"
@interface HqMyPayCodeView()

@property (nonatomic,strong) NSTimer *codeAvailabilityTimer;
@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) UILabel *titelLab;
@property (nonatomic,strong) UILabel *infoLab;
@property (nonatomic,strong) UIImageView *payCodeImageView;

@property (nonatomic,assign) int tempCount;

@property (nonatomic,assign) BOOL isPaying;//是否正在支付


@end

@implementation HqMyPayCodeView
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
        [self setup];
    }
    return self;
}
- (NSTimer *)codeAvailabilityTimer{
    if (!_codeAvailabilityTimer) {
        _codeAvailabilityTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countTime) userInfo:nil repeats:YES];
    }
    return _codeAvailabilityTimer;
    
}
- (void)destoryTimer{
    _tempCount = 0;
    [_codeAvailabilityTimer invalidate];
    _codeAvailabilityTimer = nil;
}
- (void)countTime{
    _tempCount++;
    if (_tempCount==60) {
        _tempCount =0;
    }
    NSLog(@"+++==%d",_tempCount);
}
- (void)setup{
    
    UILabel *titleLab  = [[UILabel alloc]init];
    titleLab.text = @"This bar code is limited to payment to merchants";
    titleLab.font = [UIFont systemFontOfSize:kZoomValue(16)];
    titleLab.textColor = COLORA(168,168,168);
    titleLab.numberOfLines = 0;
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(kZoomValue(86));
    }];
    
    /*
    _contentView = [[UIView alloc]init];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kZoomValue(290), kZoomValue(290)));
    }];
    */
    _payCodeImageView = [[UIImageView alloc]init];
    _payCodeImageView.backgroundColor = [UIColor grayColor];
    [self addSubview:_payCodeImageView];
    [_payCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kZoomValue(190), kZoomValue(190)));
    }];
    
    UIView *xline = [[UIView alloc] init];
    [xline.layer addSublayer:[self dotteViewLayer]];
    [self addSubview:xline];
    [xline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kZoomValue(50));
        make.right.equalTo(self).offset(kZoomValue(-50));
        make.top.equalTo(_payCodeImageView.mas_bottom).offset(kZoomValue(41));
        make.height.mas_equalTo(10);
    }];
    
    _infoLab = [[UILabel alloc]init];
    _infoLab.text = @"Please scan the above MQR Code for payment";
    _infoLab.font = [UIFont systemFontOfSize:kZoomValue(17)];
    _infoLab.numberOfLines = 0;
    _infoLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_infoLab];
    [_infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_payCodeImageView.mas_bottom).offset(kZoomValue(58));
    }];
    
}
- (CALayer *)dotteViewLayer{
    
    CAShapeLayer *dotteShapeLayer = [CAShapeLayer layer];
    dotteShapeLayer.fillColor = [UIColor clearColor].CGColor;
    dotteShapeLayer.strokeColor = COLOR(194,82,30,1).CGColor;
    dotteShapeLayer.lineWidth = LineHeight ;
    NSArray *dotteShapeArr = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:3],[NSNumber numberWithInt:2], nil];
    dotteShapeLayer.lineDashPattern = dotteShapeArr;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, 0)];
    [bezierPath addLineToPoint:CGPointMake(SCREEN_WIDTH-kZoomValue(50)*2, 0)];
    dotteShapeLayer.path = bezierPath.CGPath;

    return dotteShapeLayer;
}

- (void)generateCode{
    
//    UIImage *codeImage = [SGQRCodeGenerateManager  generateWithLogoQRCodeData:self.payCodeInfo logoImageName:@"csjz_log" logoScaleToSuperView:0.2];
    UIImage *codeImage = [SGQRCodeGenerateManager  generateWithDefaultQRCodeData:self.payCodeInfo imageViewWidth:kZoomValue(240)];
    _payCodeImageView.image = codeImage;
}
- (void)setPayCodeInfo:(NSString *)payCodeInfo{
    _payCodeInfo = payCodeInfo;
    if (_payCodeInfo) {
        [self generateCode];
    }
}

- (void)queryPayStatusWithCode:(NSString *)code{
    /*NSString *url = [NSString stringWithFormat:@"%@",code];

    [HqAFHttpClient starRequestWithHeaders:nil withURLString:url withParam:nil requestIsNeedJson:YES responseIsNeedJson:YES method:Get wihtCompleBlock:^(NSHTTPURLResponse *response, id responseObject) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (response.statusCode == 200) {
                NSDictionary *data = [responseObject hq_objectForKey:@"data"];
                
                //根据返回数据来判断
                BOOL isPaySuc = [[data hq_objectForKey:@"isPay"] boolValue];
                if (isPaySuc) {
                    //支付成功
                }else{
                    if (_isPaying) {
                        [self queryPayStatusWithCode:code];
                    }
                }
            }else{
                
            }
        });
    }];
    */
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
