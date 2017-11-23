//
//  MovieViewController.m
//  DayDayGoListen
//
//  Created by dllo on 16/1/15.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "MovieViewController.h"
#import<MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "MovieVC.h"
#import "Audio-Tools.h"

@interface MovieViewController ()


@property (nonatomic, retain) UIView        *container;
@property (nonatomic, retain) UILabel       *timeLabel;
@property (nonatomic, retain) UILabel       *endL;

@property (nonatomic, retain) UIButton      *playB;
@property (nonatomic, retain) UIButton      *pauseB;
@property (nonatomic, retain) UIButton      *allViewB;
@property (nonatomic, retain) UIButton      *noViewB;

@property (nonatomic, retain) UISlider      *volS;
@property (nonatomic, retain) UISlider      *timeS;
@property (nonatomic, retain) NSTimer       *timer;

@property (nonatomic, assign) CGFloat       totalDuration;
@property (nonatomic, retain) AVPlayerItem  *playerItem;
@property (nonatomic, retain) AVPlayerLayer *playerLayer;

//@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, retain  ) Audio_Tools        *tool;
@end

@implementation MovieViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _tool = [[Audio_Tools alloc] init];
    
    [self button];
    [self total];
    [self slider];
    
    
}

#pragma 基本控件
-(void)total
{
    self.container = [[UIView alloc] initWithFrame:CGRectMake(0, 64*HEIGHT, self.view.frame.size.width, self.view.frame.size.width/3*2)];
//    _container.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.container];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 360*HEIGHT, 60*WIDTH, 30*HEIGHT)];
    self.timeLabel.text = @"00:00";
    self.timeLabel.textColor = [UIColor blackColor];
//    self.timeLabel.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.timeLabel];
    
    self.endL = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 60*WIDTH, 360*HEIGHT, 60*WIDTH, 30*HEIGHT)];
    self.endL.text = @"00:00";
    self.endL.textColor = [UIColor blackColor];
//    self.endL.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.endL];
    
    self.playB = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playB.frame = CGRectMake(150*WIDTH, 400*HEIGHT, 50*WIDTH, 50*HEIGHT);
    [self.playB setTitle:@"播放" forState:UIControlStateNormal];
    //    [self.playB setTitle:@"继续" forState:UIControlStateSelected];
    [self.playB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.playB addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.playB];
    
    self.pauseB = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pauseB.frame = CGRectMake(250*WIDTH, 400*HEIGHT, 50*WIDTH, 50*HEIGHT);
    [self.pauseB setTitle:@"暂停" forState: UIControlStateNormal];
    [self.pauseB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.pauseB addTarget:self action:@selector(pauseAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.pauseB];
    
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width/3*2);
    [self.container.layer addSublayer:self.playerLayer];
}

#pragma 播放
-(void)playAction
{
    
    //    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(trackAction) userInfo:nil repeats:YES];
    [self.player play];
}

#pragma 暂停
-(void)pauseAction
{
    [self.player pause];
}

#pragma 初始化播放器
-(AVPlayer *)player
{
    
    //    AVPlayerItem *playerItem = [[AVPlayerItem;
    if (!_player) {
        
        //        NSString *urlStr = @"http://221.204.185.130/v.cctv.com/flash/mp4video48/TMS/2016/01/12/462da4ce5e9a48ca8484ed7243e11835_h264418000nero_aac32.mp4";
//        NSString *urlStr = @"http://baobab.cdn.wandoujia.com/14468618701471.mp4";
        NSString *urlStr = _path;
        NSURL *url = [NSURL URLWithString:urlStr];
        self.playerItem = [AVPlayerItem playerItemWithURL:url];
        _player = [AVPlayer playerWithPlayerItem:_playerItem];

        //添加进度更新
        [self addTimerObserver];
        //添加监控
        [self addobserverTopPlayerItem:_playerItem];
        
    }
    return _player;
}

#pragma 添加时间
-(void)addTimerObserver
{
    __weak MovieViewController *m = self;
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        m.current = CMTimeGetSeconds(time);
        m.timeLabel.text = [m changeTimer:m.current];
        _totalDuration = CMTimeGetSeconds(_playerItem.duration);
        m.endL.text = [m changeTimer:m.totalDuration];
        m.scale = m.current / _totalDuration;
        m.timeS.value = m.scale;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getChange" object:[m changeTimer:m.current]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"endChange" object:[m changeTimer:m.totalDuration]];
//        NSLog(@"..........");
    }];
}

#pragma 更改时间格式
-(NSString *)changeTimer:(CGFloat)time
{
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"mm:ss"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

#pragma 添加监控
-(void)addobserverTopPlayerItem:(AVPlayerItem *)playerItem
{
    //监控状态属性
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    //监控网络加载情况属性
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
}

#pragma 删除监控
-(void)removeobserverTopPlayerItem:(AVPlayerItem *)playerItem
{
    [playerItem removeObserver:self forKeyPath:@"status"];
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    AVPlayerItem *playerItem = object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        if (status == AVPlayerStatusReadyToPlay) {
//            NSLog(@"正在播放....");
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSArray *arr = playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [arr.firstObject CMTimeRangeValue];
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;
        NSLog(@"一共缓冲%.2f", totalBuffer);
        
    }
}

#pragma 全屏方法
-(void)button
{
    self.allViewB = [[UIButton alloc] initWithFrame:CGRectMake(50*WIDTH, 400*HEIGHT, 50*WIDTH, 50*HEIGHT)];
    [self.allViewB setTitle:@"全屏" forState:UIControlStateNormal];
    // 移到最前端
    [self.view bringSubviewToFront:self.allViewB];
    //     [self.allViewB setTitle:@"缩小" forState:UIControlStateSelected];
    [self.allViewB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.allViewB addTarget:self action:@selector(allViewAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.allViewB];
}

-(void)allViewAction
{

    MovieVC *movie = [[MovieVC alloc] init];
    movie.player = self.player;

//    movie.playerItem = self.playerItem;
//    [self.player pause];
//    movie.current = self.current;
    [self presentViewController:movie animated:YES completion:nil];
    movie.totalDuration = self.totalDuration;
    movie.scale = self.scale;
}



#pragma 进程音量 Slider
-(void)slider
{
    self.timeS = [[UISlider alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-100*WIDTH, 350*HEIGHT, 200*WIDTH, 50*HEIGHT)];
    [self.timeS addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.timeS];
    //    [_timeS release];
    
    self.volS = [[UISlider alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-100*WIDTH, 480*HEIGHT, 200*WIDTH, 50*HEIGHT)];
    [self.volS addTarget:self action:@selector(volAction) forControlEvents:UIControlEventValueChanged];
    self.volS.value = 5.0f;
    self.volS.minimumValue = 0.0f;
    self.volS.maximumValue = 10.0f;
    [self.view addSubview:self.volS];
}

-(void)timeAction:(UISlider *)timeS;
{
    CMTime t = CMTimeMake(timeS.value * _totalDuration, 1);
    [self.player seekToTime:t];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeValue" object:t];
}

-(void)volAction
{
    
    // 设置音量
    self.player.volume = self.volS.value;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeValue" object:[self changeTimer:self.volS.value]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //在视图将要出现的时候,创建NC上的导航按钮

    //    _tool.GoSongView.hidden = YES;
    //    [_tool.GoSongView setHidden:YES];
    _tool.GoSongView.alpha = 0;
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.tool.detail.player pause];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //当视图即将消失的时候把装有导航按钮的视图删掉
    //    [_tool.GoSongView setHidden:NO];
    //    [self stopAction];
    [self pauseAction];
    _tool.GoSongView.alpha = 1;
    [_tool.detail.player resume];
}




















































- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
