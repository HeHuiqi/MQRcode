//
//  HqGenerateCodeView.m
//  MQRcode
//
//  Created by macpro on 2018/2/13.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqGenerateCodeView.h"
#import "HqPayCodeView.h"

@interface HqGenerateCodeView()
@property (nonatomic,strong) UILabel *titelLab;
@property (nonatomic,strong) UILabel *infoLab;
@property (nonatomic,assign) BOOL isPaying;//是否正在支付

@property (nonatomic,strong) HqPayCodeView *payCodeView;
@end

@implementation HqGenerateCodeView
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
    
    
    _payCodeView = [[HqPayCodeView alloc]init];
    _payCodeView.backgroundColor = [UIColor redColor];
    [self addSubview:_payCodeView];
    [_payCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(titleLab.mas_bottom).offset(kZoomValue(41));
        make.size.mas_equalTo(CGSizeMake(kZoomValue(190), kZoomValue(190)));
    }];
    
    UIView *xline = [[UIView alloc] init];
    [xline.layer addSublayer:[self dotteViewLayer]];
    [self addSubview:xline];
    [xline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kZoomValue(50));
        make.right.equalTo(self).offset(kZoomValue(-50));
        make.top.equalTo(_payCodeView.mas_bottom).offset(kZoomValue(41));
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
        make.top.equalTo(_payCodeView.mas_bottom).offset(kZoomValue(58));
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
- (void)setCodeUrl:(NSString *)codeUrl{
    _payCodeView.codeUrl = codeUrl;
}
- (void)setAutoRefresh:(BOOL)autoRefresh{
    _payCodeView.autoRefresh = autoRefresh;
}
- (void)stopGetPayCode{
    [_payCodeView stopGetPayCode];
}
- (void)startGetPayCode{
    [_payCodeView startGetPayCode];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
