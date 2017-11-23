//
//  New-163-V.m
//  新闻
//
//  Created by dllo on 16/3/1.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "New-163-V.h"

@implementation New_163_V
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatView];
    }
    
    return self;
}

-(void)creatView
{
    // 第一张图片
    self.imgsrcUpImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgsrcUpImg];
    
    self.titleUpL = [[UILabel alloc] init];
    self.titleUpL.font = [UIFont systemFontOfSize:14];
    self.titleUpL.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.titleUpL];
    
    // 以后的图片
    self.titleL = [[UILabel alloc] init];
    self.titleL.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.titleL];
    
    self.imgsrcImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgsrcImg];
    
    self.digestL = [[UILabel alloc] init];
    self.digestL.font = [UIFont systemFontOfSize:12];
    self.digestL.numberOfLines = 2;
    self.digestL.textColor = [UIColor colorWithWhite:0.616 alpha:1.000];
    [self.contentView addSubview:self.digestL];
    
    self.replyL = [[UILabel alloc] init];
    self.replyL.font = [UIFont systemFontOfSize:12];
    self.replyL.numberOfLines = 2;
    self.replyL.textColor = [UIColor colorWithWhite:0.616 alpha:1.000];
    [self.contentView addSubview:self.replyL];
    
    // 讨论的本地图片
    self.talkImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.talkImg];
}

-(void)layoutSubviews
{
    self.imgsrcUpImg.frame = self.frame;
    self.titleUpL.frame = CGRectMake(10*WIDTH, self.bounds.size.height - 30*HEIGHT, self.bounds.size.width, 20*HEIGHT);
    
    self.titleL.frame = CGRectMake(10*WIDTH, 10*HEIGHT, self.bounds.size.width, 20*HEIGHT);
    self.imgsrcImg.frame = CGRectMake(10*WIDTH, 40*HEIGHT, self.bounds.size.width - 20*WIDTH, self.bounds.size.height - 90*HEIGHT);
    self.digestL.frame = CGRectMake(10*WIDTH, self.bounds.size.height - 50*HEIGHT, self.bounds.size.width - 20*WIDTH, 40*HEIGHT);
    self.replyL.frame = CGRectMake(self.bounds.size.width - 100*WIDTH, self.bounds.size.height - 20*HEIGHT, 60*WIDTH, 20*HEIGHT);
    
    self.talkImg.frame = CGRectMake(self.bounds.size.width - 45*WIDTH, self.bounds.size.height - 20*HEIGHT, 20*WIDTH, 20*HEIGHT);
}

















- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
