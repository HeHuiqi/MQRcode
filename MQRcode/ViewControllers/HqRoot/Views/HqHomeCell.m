//
//  HqHomeCell.m
//  QRCode
//
//  Created by macpro on 2018/1/5.
//  Copyright © 2018年 macpro. All rights reserved.
//

#import "HqHomeCell.h"

@implementation HqHomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.borderWidth = 1.0;
    contentView.clipsToBounds = YES;
    contentView.layer.borderColor = COLORA(229,233,234).CGColor;
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kZoomValue(15));
        make.right.equalTo(self).offset(kZoomValue(-15));
        make.top.equalTo(self).offset(kZoomValue(5));
        make.bottom.equalTo(self).offset(kZoomValue(-5));
    }];
    _leftIcon = [[UIImageView alloc] init];
    [contentView addSubview:_leftIcon];
    [_leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(kZoomValue(37));
        make.centerY.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    _titleLab = [[UILabel alloc] init];
    _titleLab.textColor = COLORA(97, 97, 97);
    _titleLab.font = [UIFont systemFontOfSize:kZoomValue(16)];
    [contentView addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftIcon.mas_right).offset(kZoomValue(43));
        make.bottom.equalTo(contentView.mas_centerY).offset(kZoomValue(-3));
    }];
    
    _contentLab = [[UILabel alloc] init];
    _contentLab.textColor = COLORA(97, 97, 97);
    _contentLab.font = [UIFont systemFontOfSize:kZoomValue(12)];
    [contentView addSubview:_contentLab];
    _contentLab.numberOfLines = 0;
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftIcon.mas_right).offset(kZoomValue(44));
        make.right.equalTo(contentView).offset(-kZoomValue(64));
        make.top.equalTo(contentView.mas_centerY).offset(kZoomValue(3));
    }];
    
    
    _hotIcon = [[UIImageView alloc] init];
    [contentView addSubview:_hotIcon];
    _hotIcon.image = [UIImage imageNamed:@"hot"];
    [_hotIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView).offset(0);
        make.top.equalTo(contentView).offset(0);
        make.size.mas_equalTo(CGSizeMake(kZoomValue(38), kZoomValue(37)));
    }];
    
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
