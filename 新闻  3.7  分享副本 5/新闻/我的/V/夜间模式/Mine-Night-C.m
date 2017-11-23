//
//  Mine-Night-C.m
//  新闻
//
//  Created by dllo on 16/3/10.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "Mine-Night-C.h"

@implementation Mine_Night_C
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
    label.text = @"夜间模式";
    label.textColor = [UIColor blackColor];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentNatural;
//    label.font = [UIFont systemFontOfSize:<#字体大小#>];
    [self.contentView addSubview:label];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 100, 10, self.bounds.size.height - 20, self.bounds.size.height - 20)];
    imageView.image = [UIImage imageNamed:@"夜间2.png"];
    [self addSubview:imageView];
    
    UISwitch *nightS = [[UISwitch alloc] initWithFrame:CGRectMake(self.bounds.size.width - 60, 10, 60, self.bounds.size.height - 20)];
    [nightS addTarget:self action:@selector(nightAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:nightS];
}

-(void)nightAction:(UISwitch *)sender
{
    
    
    if (YES == sender.on) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"night" object:nil userInfo:@{@"alpha":@0.7}];
    }else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"day" object:nil userInfo:@{@"alpha":@1}];
    }
}









- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
