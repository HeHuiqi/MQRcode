//
//  HqBillTypeChooseView.m
//  MQRcode
//
//  Created by macpro on 2018/2/6.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqBillTypeChooseView.h"
#define BtnHeight 45
#define BtnWidth (SCREEN_WIDTH/3.0)

@interface HqBillTypeChooseView()

@property (nonatomic,strong) UIButton *lastSelectedBtn;
@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,strong) UIView *indicatorView;


@end

@implementation HqBillTypeChooseView

- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    if(_titles){
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        CGFloat btnWidth = BtnWidth;
        CGFloat btnHeight = BtnHeight;
        for (int i = 0; i<_titles.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:_titles[i] forState:UIControlStateNormal];
            [btn setTitleColor:COLOR(69,90,100,0.54) forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            if(i == 0){
                _lastSelectedBtn = btn;
                _selectedIndex = i;
                _lastSelectedBtn.selected = YES;
            }
            
            btn.tag = i;
            btn.frame = CGRectMake(i*btnWidth, 0, btnWidth, btnHeight);
            [btn addTarget:self action:@selector(selectedBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [self.btns addObject:btn];

        }
        _indicatorView = [[UIView alloc] init];
        _indicatorView.backgroundColor = [UIColor whiteColor];
        _indicatorView.frame = CGRectMake(0, btnHeight-2, btnWidth, 2);
        [self addSubview:_indicatorView];

    }
}
- (NSMutableArray *)btns{
    if(!_btns){
        _btns = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _btns;
}
- (void)selectedBtn:(UIButton *)btn{
    if(![_lastSelectedBtn isEqual:btn]){
        if(self.delegate){
            [self.delegate hqBillTypeChooseView:self index:btn.tag];
        }
        self.selectedIndex = btn.tag;
    }
}
- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    UIButton *btn = _btns[_selectedIndex];
    if(![_lastSelectedBtn isEqual:btn]){
        btn.selected = YES;
        _lastSelectedBtn.selected = NO;
        _indicatorView.frame = CGRectMake(_selectedIndex*BtnWidth, BtnHeight-2, BtnWidth, 2);
    }
    _lastSelectedBtn = btn;

   
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
