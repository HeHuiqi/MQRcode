//
//  HqTradeRecordVC.m
//  QRCode
//
//  Created by macpro on 2018/1/19.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqTradeRecordVC.h"
#import "HqBillCell.h"
#import "HqNoContentView.h"
#import "HqBillTypeChooseView.h"
#import "HqTradeStatusVC.h"

@interface HqTradeRecordVC ()<HqBillTypeChooseViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *contentView;
@property (nonatomic,strong) NSMutableArray *records;
@property (nonatomic,strong) NSMutableArray *successRecords;
@property (nonatomic,strong) NSMutableArray *failureRecords;

@property (nonatomic,strong) HqNoContentView *noContentView;
@property (nonatomic,strong) HqBillTypeChooseView *chooseView;

@property (nonatomic,strong) HqTradeStatusVC *allBillVC;
@property (nonatomic,strong) HqTradeStatusVC *succcessBillVC;
@property (nonatomic,strong) HqTradeStatusVC *failureBillVC;



@end

@implementation HqTradeRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Transaction record";
    _records = [[NSMutableArray alloc] init];
    _successRecords = [[NSMutableArray alloc] init];
    _failureRecords = [[NSMutableArray alloc] init];

    [self getBillList];
    [self initView];
}
- (void)getBillList{
    [HqHttpUtil hqGetShowHudTitle:nil param:nil url:@"/transactions/orders" complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"账单列表==%@",responseObject);
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                NSArray *orders = [responseObject hq_objectForKey:@"orders"];
                for (NSDictionary *dic in orders) {
                    HqBill *bill = [HqBill mj_objectWithKeyValues:dic];
                    [_records addObject:bill];
                    if(bill.status == 1){
                        [_successRecords addObject:bill];
                    }
                    if(bill.status == 0){
                        [_failureRecords addObject:bill];
                    }
                }
                self.allBillVC.records = _records;
                
                self.succcessBillVC.records = _successRecords;
                self.failureBillVC.records = _failureRecords;
            }else{
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
    }];
}
- (HqBillTypeChooseView *)chooseView{
    if(!_chooseView){
        _chooseView = [[HqBillTypeChooseView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 45)];
        _chooseView.backgroundColor = AppMainColor;
        _chooseView.delegate = self;
        _chooseView.titles = @[@"All",@"SUCCESSFUL",@"FAILURE"];
    }
    return _chooseView;
}
- (HqTradeStatusVC *)allBillVC{
    if(!_allBillVC){
        _allBillVC = [[HqTradeStatusVC alloc] init];
    }
   return  _allBillVC;
}
- (HqTradeStatusVC *)succcessBillVC{
    if(!_succcessBillVC){
        _succcessBillVC = [[HqTradeStatusVC alloc] init];
    }
    return _succcessBillVC;
}
- (HqTradeStatusVC *)failureBillVC{
    if(!_failureBillVC){
        _failureBillVC = [[HqTradeStatusVC alloc] init];
    }
   return  _failureBillVC;
}
- (void)initView{
    self.isShowBottomLine = YES;
    [self.view addSubview:self.chooseView];
    CGFloat ctnHeight = SCREEN_HEIGHT-64-self.chooseView.bounds.size.height;
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.chooseView.frame), SCREEN_WIDTH, ctnHeight)];
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    contentView.bounces = NO;
    contentView.contentSize = CGSizeMake(SCREEN_WIDTH*3, ctnHeight);
    [self.view addSubview:contentView];
    self.contentView = contentView;
    
    [self addChildViewController:self.allBillVC];
    [contentView addSubview:self.allBillVC.view];
    self.allBillVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, ctnHeight);
    
    [self addChildViewController:self.succcessBillVC];
    [contentView addSubview:self.succcessBillVC.view];
    self.succcessBillVC.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, ctnHeight);

    [self addChildViewController:self.failureBillVC];
    [contentView addSubview:self.failureBillVC.view];
    self.failureBillVC.view.frame = CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, ctnHeight);
}


#pragma mark -
- (void)hqBillTypeChooseView:(HqBillTypeChooseView *)view index:(NSInteger)index{
    
    NSLog(@"index==%@",@(index));
    self.contentView.contentOffset = CGPointMake(SCREEN_WIDTH*index, 0);
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int  index = (int)(scrollView.contentOffset.x/SCREEN_WIDTH);
    self.chooseView.selectedIndex = abs(index);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
