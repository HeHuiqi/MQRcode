//
//  HqProductVC.m
//  MQRcode
//
//  Created by macpro on 2018/2/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqProductVC.h"
#import "HqProductCell.h"
#import "HqScanPayVC.h"
#import "HqGenerateCodeVC.h"

@interface HqProductVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *productList;

@end

@implementation HqProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _productList = [[NSMutableArray alloc] init];
    for (int i = 0; i<10; i++) {
        HqProduct *product = [[HqProduct alloc] init];
        product.productName = @"Apple";
        product.count = random()%10+1;
        product.price = random()%1000+1;
        product.currency = @"VND";
        [_productList addObject:product];
    }
    self.title = @"List of Product";
    [self initView];
//    self.navBarView.layer.shadowPath = self.shadowPath.CGPath;
}
- (void)initView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navBarheight, SCREEN_WIDTH , SCREEN_HEIGHT-self.navBarheight) style:UITableViewStyleGrouped];
    _tableView.separatorColor = LineColor;
    _tableView.tableHeaderView = [UIView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _productList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kZoomValue(100);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentfier = @"HqProductCell";
    HqProductCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentfier];
    if (!cell) {
        cell = [[HqProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentfier];
    }
    HqProduct *product = _productList[indexPath.row];
    cell.product = product;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self createOrderWithIndex:indexPath.row];
}
- (void)createOrderWithIndex:(NSInteger)index{
    HqProduct *product = _productList[index];
    NSDictionary *param = @{
                            @"product":product.productName,
                            @"amount": @(product.price),
                            @"currency": product.currency
                            };
    [HqHttpUtil hqPostShowHudTitle:nil param:param url:@"/transactions/orders" complete:^(NSHTTPURLResponse *response, id responseObject, NSError *error) {
        NSLog(@"==%@",responseObject);
        
        if (response.statusCode == 200) {
            NSString *msg = [responseObject hq_objectForKey:@"message"];
            int code = [[responseObject hq_objectForKey:@"code"] intValue];
            if (code==1) {
                NSString *merchantOrderNo = [responseObject hq_objectForKey:@"merchantOrderNo"];
                if(_productType == HqProductTypeScanPay){
                    HqScanPayVC *scanPay = [[HqScanPayVC alloc] init];
                    scanPay.merchantOrderNo = merchantOrderNo;
                    Push(scanPay);
                }else{
                    HqGenerateCodeVC *generateVC = [[HqGenerateCodeVC alloc] init];
                    generateVC.merchantOrderNo = merchantOrderNo;
                    Push(generateVC);
                }
                
            }else{
                [Dialog simpleToast:msg];
            }
        }else{
            [Dialog simpleToast:kRequestError];
        }
    }];
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
