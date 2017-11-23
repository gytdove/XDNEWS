//
//  New-Head-C.m
//  新闻
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "New-Head-C.h"

@implementation New_Head_C
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatView];
    }
    
    return self;
}

-(void)creatView
{
    [self docAction];
    [self slideAction];
    [self sportAction];
    [self typeAction];
}
-(void)docAction
{
    self.imageDoc = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageDoc];
    
    self.titleDoc = [[UILabel alloc] init];
    self.titleDoc.font = [UIFont systemFontOfSize:16];
    self.titleDoc.numberOfLines = 0;
    [self.contentView addSubview:self.titleDoc];
    
    self.timeDoc = [[UILabel alloc] init];
    self.timeDoc.font = [UIFont systemFontOfSize:12];
    self.timeDoc.textColor = [UIColor colorWithRed:0.573 green:0.621 blue:0.902 alpha:1.000];
    [self.contentView addSubview:self.timeDoc];
    
    self.sourceDoc = [[UILabel alloc] init];
    self.sourceDoc.font = [UIFont systemFontOfSize:12];
    self.sourceDoc.textColor = [UIColor colorWithRed:0.573 green:0.621 blue:0.902 alpha:1.000];
    [self.contentView addSubview:self.sourceDoc];
    
    self.commentDoc = [[UILabel alloc] init];
    self.commentDoc.font = [UIFont systemFontOfSize:12];
    self.commentDoc.textColor = [UIColor colorWithRed:0.573 green:0.621 blue:0.902 alpha:1.000];
    [self.contentView addSubview:self.commentDoc];
    
    self.imageInf = [[UIImageView alloc] init];
//    self.imageInf.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.imageInf];

}
-(void)slideAction
{
    self.titleSlide = [[UILabel alloc] init];
    self.titleSlide.font = [UIFont systemFontOfSize:16];
    self.titleSlide.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleSlide];
    
    self.imageSlideOne = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageSlideOne];
    
    self.imageSlideTwo = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageSlideTwo];
    
    self.imageSlideThree = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageSlideThree];
    
    self.timeSlide = [[UILabel alloc] init];
    self.timeSlide.font = [UIFont systemFontOfSize:12];
    self.timeSlide.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.timeSlide];
    
    self.commentSlide = [[UILabel alloc] init];
    self.commentSlide.font = [UIFont systemFontOfSize:12];
    self.commentSlide.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.commentSlide];
}

-(void)sportAction
{
    self.titleSport = [[UILabel alloc] init];
    self.titleSport.textAlignment = NSTextAlignmentCenter;
    self.titleSport.textColor = [UIColor colorWithRed:0.733 green:0.759 blue:1.000 alpha:1.000];
    self.titleSport.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.titleSport];
    
    self.imageLeftlogo = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageLeftlogo];
    
    self.imageRightlogo = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageRightlogo];
    
    self.labelLeftName = [[UILabel alloc] init];
    self.labelLeftName.textAlignment = NSTextAlignmentCenter;
    self.labelLeftName.textColor = [UIColor blackColor];
    self.labelLeftName.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.labelLeftName];
    
    self.labelRightName = [[UILabel alloc] init];
    self.labelRightName.textAlignment = NSTextAlignmentCenter;
    self.labelRightName.textColor = [UIColor blackColor];
    self.labelRightName.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.labelRightName];
    
    self.labelLeftScore = [[UILabel alloc] init];
    self.labelLeftScore.textAlignment = NSTextAlignmentCenter;
    self.labelLeftScore.textColor = [UIColor blackColor];
    self.labelLeftScore.font = [UIFont systemFontOfSize:30];
    [self.contentView addSubview:self.labelLeftScore];
    
    self.labelRightScore = [[UILabel alloc] init];
    self.labelRightScore.textAlignment = NSTextAlignmentCenter;
    self.labelRightScore.textColor = [UIColor blackColor];
    self.labelRightScore.font = [UIFont systemFontOfSize:30];
    [self.contentView addSubview:self.labelRightScore];
    
    self.labelCenter = [[UILabel alloc] init];
    self.labelCenter.textColor = [UIColor blackColor];
    self.labelCenter.numberOfLines = 2;
    self.labelCenter.textAlignment = NSTextAlignmentCenter;
    self.labelCenter.font = [UIFont systemFontOfSize:30];
    [self addSubview:self.labelCenter];
    
    self.labelTag = [[UILabel alloc] init];
    self.labelTag.textAlignment = NSTextAlignmentCenter;
    self.labelTag.textColor = [UIColor lightGrayColor];
    self.labelTag.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.labelTag];
}

-(void)typeAction
{
    self.labelType = [[UILabel alloc] init];
//    self.labelType.backgroundColor = [UIColor redColor];
    self.labelType.textColor = [UIColor redColor];
    self.labelType.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.labelType];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageDoc.frame = CGRectMake(10*WIDTH, 10*HEIGHT, 100*WIDTH, self.bounds.size.height - 20*HEIGHT);
    self.titleDoc.frame = CGRectMake(120*WIDTH, 10*HEIGHT, self.bounds.size.width - 140*WIDTH, 50*HEIGHT);
    self.timeDoc.frame = CGRectMake(120*WIDTH, 70*HEIGHT, 150*WIDTH, 20*HEIGHT);
    self.sourceDoc.frame = CGRectMake(220*WIDTH, 50*HEIGHT, 100*WIDTH, 20*HEIGHT);
    self.commentDoc.frame = CGRectMake(260*WIDTH, 70*HEIGHT, 30*WIDTH, 20*HEIGHT);
    self.imageInf.frame = CGRectMake(290*WIDTH, 70*HEIGHT, 20*WIDTH, 20*HEIGHT);
    
    self.titleSlide.frame = CGRectMake(10*WIDTH, 10*HEIGHT, self.bounds.size.width - 20*WIDTH, 20*HEIGHT);
    self.imageSlideOne.frame = CGRectMake(10*WIDTH, 30*HEIGHT, (self.bounds.size.width-30*WIDTH)/3, self.bounds.size.height - 50*HEIGHT);
    self.imageSlideTwo.frame = CGRectMake((self.bounds.size.width-30*WIDTH)/3+15*WIDTH, 30*HEIGHT, (self.bounds.size.width-30*WIDTH)/3, self.bounds.size.height - 50*HEIGHT);
    self.imageSlideThree.frame = CGRectMake((self.bounds.size.width-30*WIDTH)/3*2+20*WIDTH, 30*HEIGHT, (self.bounds.size.width-30*WIDTH)/3, self.bounds.size.height - 50*HEIGHT);
    self.timeSlide.frame = CGRectMake(10*WIDTH, self.bounds.size.height - 20*HEIGHT, 150*WIDTH, 20*HEIGHT);
    self.commentSlide.frame = CGRectMake(self.bounds.size.width - 100*WIDTH, self.bounds.size.height - 20*HEIGHT, 90*WIDTH, 20*HEIGHT);
    
    self.titleSport.frame = CGRectMake(10*WIDTH, 10*HEIGHT, self.bounds.size.width - 20*WIDTH, 20*HEIGHT);
    self.imageLeftlogo.frame = CGRectMake(10*WIDTH, 30*HEIGHT, 60*WIDTH, 60*HEIGHT);
    self.imageRightlogo.frame = CGRectMake(self.bounds.size.width - 70*WIDTH, 30*HEIGHT, 60*WIDTH, 60*HEIGHT);
    self.labelLeftName.frame = CGRectMake(10*WIDTH, 100*HEIGHT, 60*WIDTH, 20*HEIGHT);
    self.labelRightName.frame = CGRectMake(self.bounds.size.width - 70*WIDTH, 100*HEIGHT, 60*WIDTH, 20*HEIGHT);
    self.labelLeftScore.frame = CGRectMake(self.bounds.size.width/2-50*WIDTH, 30*HEIGHT, 40*WIDTH, 80*HEIGHT);
    self.labelRightScore.frame = CGRectMake(self.bounds.size.width/2+10*WIDTH, 30*HEIGHT, 40*WIDTH, 80*HEIGHT);
    self.labelTag.frame = CGRectMake(self.bounds.size.width/2 - 80*WIDTH, 100*HEIGHT, 160*WIDTH, 20*HEIGHT);
    self.labelCenter.frame = CGRectMake(self.bounds.size.width/2-10*WIDTH, 30*HEIGHT, 20*WIDTH, 80*HEIGHT);
    
    self.labelType.frame = CGRectMake(120*WIDTH, 50*HEIGHT, 100*WIDTH, 20*HEIGHT);
}































- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
