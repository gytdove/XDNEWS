//
//  AV-Video-C.h
//  新闻
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AV_Video_C : UITableViewCell

@property (nonatomic, retain) UILabel *labelTitle;

@property (nonatomic, retain) UILabel *labelDescription;

@property (nonatomic, retain) UIImageView *imageCover;

@property (nonatomic, retain) UILabel *labelLenth;

@property (nonatomic, retain) UILabel *labelPlayCount;
// 时间图片
@property (nonatomic, retain) UIImageView *timeL;
// 播放图片
@property (nonatomic, retain) UIImageView *playL;


@end
