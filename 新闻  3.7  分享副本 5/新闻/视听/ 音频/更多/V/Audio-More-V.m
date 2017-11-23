//
//  Audio-More-V.m
//  新闻
//
//  Created by dllo on 16/3/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "Audio-More-V.h"

@implementation Audio_More_V
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatView];
    }
    
    return self;
}

-(void)creatView
{
    self.proImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.proImg];
    
    self.proNameL = [[UILabel alloc] init];
    self.proNameL.textColor = [UIColor colorWithRed:0.155 green:0.373 blue:0.574 alpha:1.000];
    self.proNameL.textAlignment = NSTextAlignmentLeft;
    self.proNameL.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.proNameL];
    
    self.proDetL = [[UILabel alloc] init];
    self.proDetL.textColor = [UIColor colorWithRed:0.682 green:0.674 blue:0.736 alpha:1.000];
    self.proDetL.font = [UIFont systemFontOfSize:12];
    self.proDetL.textAlignment = NSTextAlignmentNatural;
    self.proDetL.numberOfLines = 0;
    [self.contentView addSubview:self.proDetL];
}

-(void)layoutSubviews
{
    self.proImg.frame = CGRectMake(10*WIDTH, 10*HEIGHT, 80*WIDTH, 80*HEIGHT);
    self.proNameL.frame = CGRectMake(100*WIDTH, 10*HEIGHT, self.bounds.size.width - 110*WIDTH, 20*HEIGHT);
    self.proDetL.frame = CGRectMake(100*WIDTH, 40*HEIGHT, self.bounds.size.width - 100*WIDTH, 40*HEIGHT);
}




















- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
