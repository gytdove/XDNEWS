//
//  Audio-Total-CV.m
//  新闻
//
//  Created by dllo on 16/2/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "Audio-Total-CV.h"

@implementation Audio_Total_CV
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}

-(void)creatView
{
//    self.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    
    self.imageImg = [[UIImageView alloc] init];
    self.imageImg.layer.cornerRadius = 10;
    self.imageImg.layer.masksToBounds = YES;
    [self.contentView addSubview:self.imageImg];
    
    self.titleL = [[UILabel alloc] init];
    self.titleL.font = [UIFont systemFontOfSize:12];
    self.titleL.textAlignment = NSTextAlignmentNatural;
    self.titleL.textColor = [UIColor colorWithRed:0.240 green:0.332 blue:0.541 alpha:1.000];
    self.titleL.numberOfLines = 0;
    [self.contentView addSubview:self.titleL];
    
    self.programNameL = [[UILabel alloc] init];
    self.programNameL.font = [UIFont systemFontOfSize:10];
    self.programNameL.textAlignment = NSTextAlignmentNatural;
    self.programNameL.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.programNameL];
    
    self.listenNumShowL = [[UILabel alloc] init];
    self.listenNumShowL.font = [UIFont systemFontOfSize:10];
    self.listenNumShowL.textAlignment = NSTextAlignmentLeft;
    self.listenNumShowL.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.listenNumShowL];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageImg.frame = CGRectMake(0, 0, 90*WIDTH, 90*HEIGHT);
    self.titleL.frame = CGRectMake(0, 95*HEIGHT, 90*WIDTH, 40*HEIGHT);
    self.programNameL.frame = CGRectMake(0, 135*HEIGHT, 90*WIDTH, 20*HEIGHT);
    self.listenNumShowL.frame = CGRectMake(10*WIDTH, 65*HEIGHT, 90*WIDTH, 20*HEIGHT);
}























@end
