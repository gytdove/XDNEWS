//
//  New-Cute-C.m
//  新闻
//
//  Created by dllo on 16/2/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "New-Cute-C.h"

@implementation New_Cute_C
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatView];
    }
    
    return self;
}

-(void)creatView
{
    self.thumbnailImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.thumbnailImg];
    
    self.likeL = [[UILabel alloc] init];
    self.likeL.font = [UIFont systemFontOfSize:14];
    self.likeL.textColor = [UIColor colorWithRed:0.504 green:0.613 blue:0.703 alpha:1.000];
    self.likeL.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.likeL];
//    NSLog(@"%@",self.likeL.text);
    
    self.commentL = [[UILabel alloc] init];
    self.commentL.font = [UIFont systemFontOfSize:14];
    self.commentL.textColor = [UIColor colorWithRed:0.504 green:0.613 blue:0.703 alpha:1.000];
    [self.contentView addSubview:self.commentL];
    
    self.goodImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.goodImg];
    
    self.talkImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.talkImg];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.thumbnailImg.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 50*HEIGHT);
    self.likeL.frame = CGRectMake(30*WIDTH+10*WIDTH, self.bounds.size.height-50*HEIGHT+15*HEIGHT, 100*WIDTH, 20*HEIGHT);
    self.commentL.frame = CGRectMake(150*WIDTH, self.bounds.size.height-50*HEIGHT+15*HEIGHT, 100*WIDTH, 20*HEIGHT);
    
    self.goodImg.frame = CGRectMake(5*WIDTH+10*WIDTH, self.bounds.size.height-50*HEIGHT+15*HEIGHT, 20*WIDTH, 20*HEIGHT);
    self.talkImg.frame = CGRectMake(125*WIDTH, self.bounds.size.height-50*HEIGHT+15*HEIGHT, 20*WIDTH, 20*HEIGHT);
}






















- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
