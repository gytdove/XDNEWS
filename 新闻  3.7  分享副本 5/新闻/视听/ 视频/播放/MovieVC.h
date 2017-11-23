//
//  MovieVC.h
//  DayDayGoListen
//
//  Created by dllo on 16/3/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface MovieVC : UIViewController
@property (nonatomic, retain) AVPlayer *player;
@property (nonatomic, retain) UIView   *container;
@property (nonatomic, retain) UILabel  *timeLabel;
@property (nonatomic, retain) UILabel  *endL;

@property (nonatomic, retain) UIButton *playB;
@property (nonatomic, retain) UIButton *pauseB;
@property (nonatomic, retain) UIButton *allViewB;
@property (nonatomic, retain) UIButton *noViewB;

@property (nonatomic, retain) UISlider *volS;
@property (nonatomic, retain) UISlider *timeS;
@property (nonatomic, retain) NSTimer  *timer;

@property (nonatomic, assign) CGFloat totalDuration;
@property (nonatomic, retain) AVPlayerItem *playerItem;
@property (nonatomic, retain) AVPlayerLayer *playerLayer;
@property (nonatomic, retain) UIButton *backB;

@property (nonatomic, assign)CGFloat current;

@property (nonatomic, assign)CGFloat scale;
@end
