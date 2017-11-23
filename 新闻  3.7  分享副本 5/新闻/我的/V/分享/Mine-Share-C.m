//
//  Mine-Share-C.m
//  新闻
//
//  Created by dllo on 16/3/10.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "Mine-Share-C.h"

@implementation Mine_Share_C
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatView];
    }
    
    return self;
}

-(void)creatView
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, self.bounds.size.height - 20)];
    label.text = @"分享快乐";
    label.textColor = [UIColor blackColor];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentNatural;
    //    label.font = [UIFont systemFontOfSize:<#字体大小#>];
    [self.contentView addSubview:label];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 100, 10, self.bounds.size.height - 20, self.bounds.size.height - 20)];
    imageView.image = [UIImage imageNamed:@"分享.png"];
    [self addSubview:imageView];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
