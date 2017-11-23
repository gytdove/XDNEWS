//
//  MovieViewController.h
//  DayDayGoListen
//
//  Created by dllo on 16/1/15.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface MovieViewController : UIViewController
@property (nonatomic, assign)CGFloat current;

@property (nonatomic, retain) AVPlayer *player;

@property (nonatomic, assign)CGFloat scale;

@property (nonatomic, assign)CMTime time;

@property (nonatomic, copy) NSString *path;

@end
