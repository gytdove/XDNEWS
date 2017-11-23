//
//  New-Talk-C.m
//  新闻
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "New-Talk-C.h"

@implementation New_Talk_C
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatView];
    }
    
    return self;
}

-(void)creatView
{
    [self imageAction];
    [self labelAction];
}

-(void)imageAction
{
    self.imagePicurl = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imagePicurl];
    
    self.imageWhite = [[UIImageView alloc] init];
    self.imageWhite.layer.cornerRadius = 22;
    self.imageWhite.layer.masksToBounds = YES;
    self.imageWhite.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.imageWhite];
    
    self.imageHeadpicurl = [[UIImageView alloc] init];
    self.imageHeadpicurl.layer.cornerRadius = 20;
    self.imageHeadpicurl.layer.masksToBounds = YES;
    [self.contentView addSubview:self.imageHeadpicurl];
    
    self.imageAttention = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageAttention];
    
    self.imageQuestion = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageQuestion];
}

-(void)labelAction
{
    self.labelName = [[UILabel alloc] init];
    self.labelName.font = [UIFont systemFontOfSize:14];
    self.labelName.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.labelName];
    
    self.labelTitle = [[UILabel alloc] init];
    self.labelTitle.font = [UIFont systemFontOfSize:12];
    self.labelTitle.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.labelTitle];
    
    self.labelAlias = [[UILabel alloc] init];
    self.labelAlias.font = [UIFont systemFontOfSize:18];
    self.labelAlias.numberOfLines = 0;
//    self.labelAlias.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.labelAlias];
    
    self.labelClassification = [[UILabel alloc] init];
    self.labelClassification.textAlignment = NSTextAlignmentCenter;
    self.labelClassification.textColor = [UIColor colorWithRed:0.718 green:0.740 blue:1.000 alpha:1.000];
    [self.contentView addSubview:self.labelClassification];
    
    self.labelConcernCount = [[UILabel alloc] init];
    self.labelConcernCount.textAlignment = NSTextAlignmentRight;
    self.labelConcernCount.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.labelConcernCount];
    
    self.labelQuestionCount = [[UILabel alloc] init];
    self.labelQuestionCount.textAlignment = NSTextAlignmentRight;
    self.labelQuestionCount.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.labelQuestionCount];
}


-(void)layoutSubviews
{
    self.imagePicurl.frame = CGRectMake(0, 30*HEIGHT, self.bounds.size.width, 180*HEIGHT);
    self.imageWhite.frame = CGRectMake(20*WIDTH, 5*HEIGHT, 44*WIDTH, 44*HEIGHT);
    self.imageHeadpicurl.frame = CGRectMake(22*WIDTH, 7*HEIGHT, 40*WIDTH, 40*HEIGHT);
    
    self.labelName.frame = CGRectMake(70*WIDTH, 8*HEIGHT, 60*WIDTH, 20*HEIGHT);
    self.labelTitle.frame = CGRectMake(140*WIDTH, 9*HEIGHT, 160*WIDTH, 18*HEIGHT);
    
    self.labelAlias.frame = CGRectMake(10*WIDTH, 220*HEIGHT, self.bounds.size.width - 20*WIDTH, 60*HEIGHT);
    self.labelClassification.frame = CGRectMake(10*WIDTH, 290*HEIGHT, 40*WIDTH, 20*HEIGHT);
    self.labelConcernCount.frame = CGRectMake(60*WIDTH, 290*HEIGHT, 60*WIDTH, 20*HEIGHT);
    self.labelQuestionCount.frame = CGRectMake(150*WIDTH, 290*HEIGHT, 60*WIDTH, 20*HEIGHT);
    self.imageAttention.frame = CGRectMake(125*WIDTH, 290*HEIGHT, 20*WIDTH, 20*HEIGHT);
    self.imageQuestion.frame = CGRectMake(215*WIDTH, 290*HEIGHT, 20*WIDTH, 20*HEIGHT);
}

























- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
