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
    
    _leftIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:_leftIcon];
    [_leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    _titleLab = [[UILabel alloc] init];
    _titleLab.textColor = COLORA(97, 97, 97);
    _titleLab.font = [UIFont systemFontOfSize:kZoomValue(16)];
    [self.contentView addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftIcon.mas_right).offset(kZoomValue(44));
        make.top.equalTo(self.contentView).offset(kZoomValue(20));
    }];
    
    _contentLab = [[UILabel alloc] init];
    _contentLab.textColor = COLORA(97, 97, 97);
    _contentLab.font = [UIFont systemFontOfSize:kZoomValue(12)];
    [self.contentView addSubview:_contentLab];
    _contentLab.numberOfLines = 0;
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftIcon.mas_right).offset(kZoomValue(44));
        make.right.equalTo(self.contentView).offset(-kZoomValue(64));
        make.top.equalTo(_titleLab.mas_bottom).offset(kZoomValue(6));
    }];
    
    
    _hotIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:_hotIcon];
    _hotIcon.image = [UIImage imageNamed:@"hot"];
    [_hotIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
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
