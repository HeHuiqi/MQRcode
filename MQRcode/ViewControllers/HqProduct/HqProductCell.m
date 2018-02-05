//
//  HqProductCell.m
//  MQRcode
//
//  Created by macpro on 2018/2/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqProductCell.h"

@implementation HqProductCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    
    _leftIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:_leftIcon];
    [_leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    _titleLab = [[UILabel alloc] init];
    _titleLab.textColor = COLORA(97, 97, 97);
    _titleLab.font = [UIFont systemFontOfSize:kZoomValue(20)];
    [self.contentView addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftIcon.mas_right).offset(kZoomValue(44));
        make.top.equalTo(self.contentView).offset(kZoomValue(20));
    }];
    
    _priceLab = [[UILabel alloc] init];
    _priceLab.textColor = COLORA(97, 97, 97);
    _priceLab.font = [UIFont systemFontOfSize:kZoomValue(16)];
    [self.contentView addSubview:_priceLab];
    _priceLab.numberOfLines = 0;
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftIcon.mas_right).offset(kZoomValue(44));
        make.right.equalTo(self.contentView).offset(-kZoomValue(64));
        make.top.equalTo(_titleLab.mas_bottom).offset(kZoomValue(6));
    }];
    
}
- (void)setProduct:(HqProduct *)product{
    _product = product;
    if(_product){
        _titleLab.text = [NSString stringWithFormat:@"%@*%@",_product.productName,@(_product.count)];
        _priceLab.text = [NSString stringWithFormat:@"%0.2f ₫",_product.price];
        
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
