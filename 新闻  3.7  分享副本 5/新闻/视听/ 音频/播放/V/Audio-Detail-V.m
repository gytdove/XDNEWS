//
//  Audio-Detail-V.m
//  新闻
//
//  Created by dllo on 16/3/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "Audio-Detail-V.h"

@implementation Audio_Detail_V
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatView];
    }
    
    return self;
}

-(void)creatView
{
    self.imageImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageImg];
    
    self.titleL = [[UILabel alloc] init];
    self.titleL.textColor = [UIColor colorWithRed:0.260 green:0.362 blue:0.520 alpha:1.000];
    self.titleL.textAlignment = NSTextAlignmentNatural;
    self.titleL.font = [UIFont systemFontOfSize:14];
    self.titleL.numberOfLines = 0;
    [self.contentView addSubview:self.titleL];
    
    self.timeL = [[UILabel alloc] init];
    self.timeL.textColor = [UIColor colorWithRed:0.641 green:0.669 blue:0.753 alpha:1.000];
    self.timeL.textAlignment = NSTextAlignmentLeft;
    self.timeL.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.timeL];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageImg.frame = CGRectMake(10*WIDTH, 10*HEIGHT, 80*WIDTH, 80*HEIGHT);
    self.titleL.frame = CGRectMake(100*WIDTH, 10*HEIGHT, self.bounds.size.width - 110*WIDTH, 40*HEIGHT);
    self.timeL.frame = CGRectMake(100*WIDTH, 75*HEIGHT, self.bounds.size.width - 110*WIDTH, 20*HEIGHT);
}













- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
