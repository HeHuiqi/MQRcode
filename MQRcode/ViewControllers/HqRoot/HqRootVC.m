//
//  ViewController.m
//  HqSlider
//
//  Created by hehuiqi on 2018/1/4.
//  Copyright © 2018年 hehuiqi. All rights reserved.
//

#import "HqRootVC.h"
#import "HqLeftView.h"
#import "HqButton.h"
#import "HqHomeCell.h"
#import "HqScanPayVC.h"
#import "HqScanPayAndCodeVC.h"
#import "HqCardsVC.h"

#import "HqGesturePasswordVC.h"
#import "PCCircleViewConst.h"

#import "HqTradeRecordVC.h"
#import "HqHomeNews.h"
#import "HqProductVC.h"
#import "HqChangePasswordVC.h"


#define LeftWidth (SCREEN_WIDTH - kZoomValue(52))
#define LeftAlpha 0.7
#define  HqFuctionViewHeight 100

@interface HqRootVC ()<UITableViewDelegate,UITableViewDataSource,HqLeftViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) HqLeftView *leftView;//左侧视图
@property (nonatomic,strong) UIView *mainOverView;//覆盖视图
@property (nonatomic,assign) BOOL isOpen;//左侧视图是否打开
@property (nonatomic,strong) UIImageView *topHeaderView;
@property (nonatomic,strong) UIView *functionHeaderView;//功能视图


@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) HqUser *user;

@property (nonatomic,strong) NSMutableArray *homeDatas;

@end

@implementation HqRootVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    self.title = @"Home";
    self.leftBtnImageName = @"home_menu_icon";
    
    [self headerView];
    self.topHeaderView.image = [UIImage imageNamed:@"home_header_bg"];

    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    
    [self.view addSubview:self.mainOverView];
    [self.view addSubview:self.leftView];
    [self addGesture];
   
    NSString *token = GetUserDefault(kToken);
    NSLog(@"token==%@",token);
}
#pragma mark - Bill
- (void)homeBill:(UIButton *)btn{
    HqTradeRecordVC *recordVC = [[HqTradeRecordVC alloc] init];
    Push(recordVC);
}
- (void)initData{
    self.isOpen = NO;
//    if ([AppDelegate shareApp].isInputGesturePassword) {
//        [self requestUerInfo];
//    }
    _homeDatas = [[NSMutableArray alloc] init];
    HqHomeNews *hms = [[HqHomeNews alloc] init];
    hms.title = @"Sliver and plan";
    hms.subTitle = @"Join us in disrupting traditional finance";
    hms.type =  1;
    hms.iconName = @"home_cell1_icon";
    
    HqHomeNews *hms1 = [[HqHomeNews alloc] init];
    hms1.title = @"Fund security";
    hms1.subTitle = @"Join us in disrupting traditional finance";
    hms1.iconName = @"home_cell3_icon";

    HqHomeNews *hms2 = [[HqHomeNews alloc] init];
    hms2.title = @"Fund security";
    hms2.subTitle = @"Join us in disrupting traditional finance";
    hms2.iconName = @"home_cell3_icon";

    [_homeDatas addObject:hms];
    [_homeDatas addObject:hms1];

}
- (UIImageView *)topHeaderView{
    if(!_topHeaderView){
        _topHeaderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navBarView.frame), SCREEN_WIDTH, 200)];
    }
    return _topHeaderView;
}
- (void)headerView{
    [self.view addSubview:self.topHeaderView];
    [self.topHeaderView sendSubviewToBack:self.navBarView];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topHeaderView.frame), SCREEN_WIDTH, kZoomValue(HqFuctionViewHeight))];
    header.backgroundColor = AppMainColor;
    NSArray *titles = @[@"Messages",@"Scan QR",@"Generate QR"];
    NSArray *images = @[@"messages_icon",@"scan_qr_icon",@"generate_qr_icon"];
    int temp = 0;
    CGFloat width = SCREEN_WIDTH/titles.count;

    for (int i = 0; i<titles.count; i++) {
        temp = i;
        HqButton *button = [[HqButton alloc] initWithFrame:CGRectMake(i*width, 0, width, kZoomValue(HqFuctionViewHeight))];
        button.iconImage = [UIImage imageNamed:images[i]];
        button.title = titles[i];
        
        [button addTarget:self action:@selector(headerClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+1;
        [header addSubview:button];
        
    }
    for (int i = 1; i<3; i++) {
        UIView *yline = [[UIView alloc] init];
        CGFloat lineY = kZoomValue(15);
        yline.frame = CGRectMake(width*i, lineY, LineHeight, kZoomValue(HqFuctionViewHeight)-2*lineY);
        yline.backgroundColor = COLORA(229,233,234);
        [header addSubview:yline];
    }
    header.layer.borderWidth = 1.0;
    header.layer.borderColor = COLOR(186,186,187,0.21).CGColor;
   
    [self.view addSubview:header];
    self.functionHeaderView = header;
}
#pragma mark - 头部点击事件
- (void)headerClick:(HqButton *)btn{

    switch (btn.tag) {
        case 1:
        {
//            HqScanPayVC *scanVC = [[HqScanPayVC alloc] init];
//            Push(scanVC);
        }
            break;
        case 2:
        {
//            [Dialog simpleToast:@"This feature is not complete yet"];
            
            HqProductVC *productVC = [[HqProductVC alloc] init];
            productVC.productType = HqProductTypeScanPay;
            Push(productVC);
        }
            break;
        case 3:
        {
            HqProductVC *productVC = [[HqProductVC alloc] init];
            productVC.productType = HqProductTypeGenerateCode;
            Push(productVC);
        }
            break;
        case 4:
        {
//            HqCardsVC *cardsVC = [[HqCardsVC alloc] init];
//            Push(cardsVC);
        }
            break;
            
        default:
            break;
    }
}
- (void)addGesture{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    UITapGestureRecognizer *overTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOver:)];
    [self.mainOverView addGestureRecognizer:overTap];
}
- (void)tapOver:(UITapGestureRecognizer *)tap{
    [self closeLeftView];
}
- (void)closeLeftView{
    [UIView animateWithDuration:0.1 animations:^{
        self.leftView.frame = CGRectMake(-LeftWidth, 0, LeftWidth, self.view.bounds.size.height);
        self.mainOverView.alpha = 0.0;
        self.isOpen = NO;
    }];
}
- (void)openLeftView{
    [UIView animateWithDuration:0.1 animations:^{
        self.leftView.frame = CGRectMake(0, 0, LeftWidth, self.view.frame.size.height);
        self.mainOverView.alpha = LeftAlpha;
        self.isOpen = YES;
    }];
}
#pragma mark -  处理Pan手势
- (void)panView:(UIPanGestureRecognizer *)panGesture{
    
    CGPoint point = [panGesture translationInView:self.view];
    CGFloat xOffset = point.x;
    //    NSLog(@"xOffset==%f",xOffset);
    
    if(!self.isOpen&&xOffset<0){
        return;
    }
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
        {
            
            if (xOffset>=LeftWidth) {
                return;
            }
            
            if (xOffset>0&&self.leftView.frame.origin.x==0) {
                return;
            }
            if (xOffset<0&&self.leftView.frame.origin.x==LeftWidth) {
                return;
            }
            if (xOffset<0&&self.leftView.frame.origin.x<=0) {
                self.leftView.frame = CGRectMake(xOffset, 0, LeftWidth, self.view.frame.size.height);
            }else{
                self.leftView.frame = CGRectMake(floor(xOffset)-LeftWidth, 0, LeftWidth, self.view.frame.size.height);
            }
            self.mainOverView.alpha = fabs(xOffset)/LeftWidth/2.0;
        }
            
            break;
        case UIGestureRecognizerStateEnded:{
            self.view.userInteractionEnabled = YES;
            
            [UIView animateWithDuration:0.1 animations:^{
                if (self.leftView.frame.origin.x>-LeftWidth/2.0) {
                    self.leftView.frame = CGRectMake(0, 0, LeftWidth, self.view.frame.size.height);
                    self.mainOverView.alpha = LeftAlpha;
                    self.isOpen = YES;
                }else{
                    self.leftView.frame = CGRectMake(-LeftWidth, 0, LeftWidth, self.view.frame.size.height);
                    self.mainOverView.alpha = 0.0;
                    self.isOpen = NO;
                }
            }];
            
        }
            break;
            
        default:
            break;
    }
    
    
}

- (HqLeftView *)leftView{
    if (!_leftView) {
        _leftView = [[HqLeftView alloc] initWithFrame:CGRectMake(-LeftWidth, 0, LeftWidth, self.view.bounds.size.height)];
        _leftView.delegate = self;
    }
    return _leftView;
}
- (UIView *)mainOverView{
    
    if (!_mainOverView) {
        _mainOverView = [[UIView alloc] initWithFrame:self.view.frame];
        _mainOverView.backgroundColor = [UIColor whiteColor];
        _mainOverView.alpha = 0.0;
    }
    return _mainOverView;
}
- (UITableView *)tableView{
    if(!_tableView){
        CGFloat  y = CGRectGetMaxY(self.functionHeaderView.frame);
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.height-y) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _homeDatas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kZoomValue(83);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentfier = @"HqHomeCell";
    HqHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentfier];
    if (!cell) {
        cell = [[HqHomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentfier];
    }
    HqHomeNews *hms = _homeDatas[indexPath.row];
    cell.titleLab.text = hms.title;
    cell.contentLab.text = hms.subTitle;
    cell.hotIcon.hidden = hms.type==1;
    cell.leftIcon.image = [UIImage imageNamed:hms.iconName];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - 获取用户信息
- (void)requestUerInfo{
    
    [HqHttpUtil hqGetShowHudTitle:nil param:nil url:@"/users"   complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        if (response.statusCode == 200) {
            NSLog(@"用户信息==%@",responseObject);
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                HqGesturePasswordVC *gesturePasswordVC = [[HqGesturePasswordVC alloc] init];
                _user = [HqUser mj_objectWithKeyValues:responseObject];
//                NSString *gesturePassword = [PCCircleViewConst getGestureWithKey:gestureFinalSaveKey];
                gesturePasswordVC.user = _user;
                if (_user.hasGesture) {
                    gesturePasswordVC.type = GestureViewControllerTypeLogin;
                }else{
                    gesturePasswordVC.type = GestureViewControllerTypeSetting;
                }
                
//                gesturePasswordVC.type = GestureViewControllerTypeSetting;


                Push(gesturePasswordVC);
            }else{
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
    }];
}


- (void)backClick{
    
    [self openLeftView];
}

#pragma mark - HqLeftViewDelegate
- (void)hqLeftView:(HqLeftView *)view index:(NSInteger)index{
    [self closeLeftView];
    
    NSLog(@"index==%@",@(index));
    
    switch (index) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            HqChangePasswordVC *password = [[HqChangePasswordVC alloc] init];
            Push(password);
        }
            break;
        case 3:
        {
            HqTradeRecordVC *tradeVC = [[HqTradeRecordVC alloc] init];
            Push(tradeVC);
        }
            break;
        case 4:
        {
            
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    BOOL isHqButton = [touch.view isKindOfClass: NSClassFromString(@"HqButton")];
    if(isHqButton) {
        return NO;
    }
    return  YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

