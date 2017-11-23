//
//  AV-Video-C.m
//  新闻
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AV-Video-C.h"

@implementation AV_Video_C
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatView];
    }
    
    return self;
}

-(void)creatView
{
    self.labelTitle = [[UILabel alloc] init];
    self.labelTitle.font = [UIFont systemFontOfSize:18];
    self.labelTitle.textColor = [UIColor blackColor];
    [self addSubview:self.labelTitle];
    
    self.labelDescription = [[UILabel alloc] init];
    self.labelDescription.font = [UIFont systemFontOfSize:16];
    self.labelDescription.textColor = [UIColor lightGrayColor];
    [self addSubview:self.labelDescription];
    
    self.imageCover = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageCover];
    
    self.labelLenth = [[UILabel alloc] init];
    self.labelLenth.font = [UIFont systemFontOfSize:14];
    self.labelLenth.textAlignment = NSTextAlignmentLeft;
    self.labelLenth.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.labelLenth];
    
    self.labelPlayCount = [[UILabel alloc] init];
    self.labelPlayCount.font = [UIFont systemFontOfSize:14];
    self.labelPlayCount.textColor = [UIColor lightGrayColor];
    self.labelPlayCount.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.labelPlayCount];
    
    self.timeL = [[UIImageView alloc] init];
    [self.contentView addSubview:self.timeL];
    
    self.playL = [[UIImageView alloc] init];
    [self.contentView addSubview:self.playL];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.labelTitle.frame = CGRectMake(10*WIDTH, 20*HEIGHT, self.bounds.size.width, 20*HEIGHT);
    self.labelDescription.frame = CGRectMake(10*WIDTH, 45*HEIGHT, self.bounds.size.width, 20*HEIGHT);
    self.imageCover.frame = CGRectMake(10*WIDTH, 70*HEIGHT, self.bounds.size.width - 20*WIDTH, self.bounds.size.height - 90*HEIGHT);
    self.labelLenth.frame = CGRectMake(40*WIDTH, self.bounds.size.height - 20*HEIGHT, 40*WIDTH, 20*HEIGHT);
    self.labelPlayCount.frame = CGRectMake(120*WIDTH, self.bounds.size.height - 20*HEIGHT, 60*WIDTH, 20*HEIGHT);
    self.timeL.frame = CGRectMake(15*WIDTH, self.bounds.size.height - 20*HEIGHT, 20*WIDTH, 20*HEIGHT);
    self.playL.frame = CGRectMake(95*WIDTH, self.bounds.size.height - 20*HEIGHT, 20*WIDTH, 20*HEIGHT);
    
}























- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
