//
//  New-Deep-V.m
//  新闻
//
//  Created by dllo on 16/3/1.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "New-Deep-V.h"

@implementation New_Deep_V
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatView];
    }
    
    return self;
}

-(void)creatView
{
    self.thumImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.thumImg];
    
    self.titleImgL = [[UILabel alloc] init];
    self.titleImgL.font = [UIFont systemFontOfSize:16];
    self.titleImgL.textColor = [UIColor colorWithRed:0.241 green:0.381 blue:0.562 alpha:1.000];
    self.titleImgL.numberOfLines = 0;
    [self.contentView addSubview:self.titleImgL];
    
    self.timeImgL = [[UILabel alloc] init];
    self.timeImgL.font = [UIFont systemFontOfSize:16];
    self.timeImgL.textColor = [UIColor colorWithRed:0.241 green:0.381 blue:0.562 alpha:1.000];
    [self.contentView addSubview:self.timeImgL];
    
    self.titleL = [[UILabel alloc] init];
    self.titleL.font = [UIFont systemFontOfSize:16];
    self.titleL.textColor = [UIColor colorWithRed:0.241 green:0.381 blue:0.562 alpha:1.000];
    self.titleL.numberOfLines = 0;
    [self.contentView addSubview:self.titleL];
    
    self.timeL = [[UILabel alloc] init];
    self.timeL.font = [UIFont systemFontOfSize:16];
    self.timeL.textColor = [UIColor colorWithRed:0.241 green:0.381 blue:0.562 alpha:1.000];
    [self.contentView addSubview:self.timeL];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.thumImg.frame = CGRectMake(10*WIDTH, 10*HEIGHT, 85*WIDTH, self.bounds.size.height - 20*HEIGHT);
    self.titleImgL.frame = CGRectMake(115*WIDTH, 10*HEIGHT, self.bounds.size.width - 125*WIDTH, self.bounds.size.height - 40*HEIGHT);
    self.timeImgL.frame = CGRectMake(115*WIDTH, self.bounds.size.height - 30*HEIGHT, self.bounds.size.width - 125*WIDTH, 20*HEIGHT);
    
    self.titleL.frame = CGRectMake(10*WIDTH, 10*HEIGHT, self.bounds.size.width - 20*WIDTH, 40*HEIGHT);
    self.timeL.frame = CGRectMake(10*WIDTH, 50*HEIGHT, self.bounds.size.width - 20*WIDTH, 20*HEIGHT);
}















- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
