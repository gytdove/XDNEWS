//
//  Mine-Collect-V.m
//  新闻
//
//  Created by dllo on 16/3/2.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "Mine-Collect-V.h"

@implementation Mine_Collect_V
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatView];
    }
    
    return self;
}

-(void)creatView
{
    self.headImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.headImg];
    
    self.aliasL = [[UILabel alloc] init];
    self.aliasL.textColor = [UIColor colorWithRed:0.315 green:0.416 blue:0.594 alpha:1.000];
    self.aliasL.textAlignment = NSTextAlignmentNatural;
    self.aliasL.font = [UIFont systemFontOfSize:16];
    self.aliasL.numberOfLines = 0;
    [self.contentView addSubview:self.aliasL];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.headImg.frame = CGRectMake(10, 10, 80, 80);
    self.aliasL.frame = CGRectMake(100, 10, self.bounds.size.width - 110, 80);
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
