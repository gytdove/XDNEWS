//
//  New-Talk-Detail-C.m
//  新闻
//
//  Created by dllo on 16/2/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "New-Talk-Detail-C.h"

@implementation New_Talk_Detail_C
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatView];
    }
    
    return self;
}

-(void)creatView
{
    
//    self.backgroundColor = [UIColor redColor];
    
    self.imageV = [[UIImageView alloc]init];
    self.imageV.layer.masksToBounds = YES;
    self.imageV.layer.cornerRadius = 15;
    [self.contentView addSubview:self.imageV];
    self.contentLabel = [[UILabel alloc]init];
    //self.contentLabel.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:self.contentLabel];
}







-(void)layoutSubviews
{
    
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(5*WIDTH, 5*HEIGHT, 30*WIDTH, 30*HEIGHT);
    
    // self.contentLabel.frame = CGRectMake(10, 10, <#CGFloat width#>, <#CGFloat height#>)
    
}


















- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
