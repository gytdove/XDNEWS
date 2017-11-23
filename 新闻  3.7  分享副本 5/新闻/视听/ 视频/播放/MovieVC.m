//
//  MovieVC.m
//  DayDayGoListen
//
//  Created by dllo on 16/3/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "MovieVC.h"
#import <AVFoundation/AVFoundation.h>
#import "MovieViewController.h"
#import "Audio-Tools.h"

@interface MovieVC ()

@property (nonatomic, retain) Audio_Tools *tool;
@property (nonatomic, retain) UIView      *viewAll;
@property (nonatomic, getter=isOn) BOOL on;
@end

@implementation MovieVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor blueColor];
    
    self.on = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getChangeDonw:) name:@"getChange" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endChangeDonw:) name:@"endChange" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeValue:) name:@"changeValue" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTime:) name:@"changeTime" object:nil];
    
    self.container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
//    _container.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.container];

    
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = self.container.frame;
    [self.container.layer addSublayer:self.playerLayer];
    //    [self button];
    
    
//    NSLog(@"%f",self.current);
//    self.viewAll = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.viewAll = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width)];
//    self.viewAll.alpha = 0.1;
    self.viewAll.userInteractionEnabled = YES;
    [self.view addSubview:self.viewAll];
    
    // 轻触
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tapGR];
    
    // 平移
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:panGR];
    
    
    [self total];
    [self slider];
    [self addTimerObserver];
    self.volS.value = 5.0f;
    _tool = [[Audio_Tools alloc] init];
    [self.player play];
}

- (void)getChangeDonw:(NSNotification *)noti
{
    NSString *number = noti.object;
    self.timeLabel.text = [NSString stringWithFormat:@"%@", number];
}

- (void)endChangeDonw:(NSNotification *)noti
{
    NSString *number = noti.object;
    self.endL.text = [NSString stringWithFormat:@"%@", number];
}

-(void)changeValue:(NSNotification *)noti
{
//    NSLog(@"%@",noti);
}

-(void)changeTime:(NSNotification *)noti
{
//    [self.player seekToTime:noti.object];
}

-(void)tapAction:(UITapGestureRecognizer *)sender
{
    
    if (self.isOn) {
//        self.viewAll.alpha = 0.1;
        self.viewAll.hidden = YES;
//        self.backB.alpha = 0.5;
        self.on = NO;
    }
    else
    {
        self.viewAll.hidden = NO;
//        self.viewAll.alpha = 1;
//        self.backB.alpha = 1;
        self.on = YES;
    }
}

-(void)panAction:(UIPanGestureRecognizer *)sender
{
    //    UIGestureRecognizerState
    UIPanGestureRecognizer *panGesture = sender;
    CGPoint movePoint = [panGesture translationInView:self.view];
    //    NSLog(@"%f  %f",movePoint.x,movePoint.y);
    
    if (fabs(movePoint.y)>fabs(movePoint.x)) {
        // 上下滑调音量
        self.volS.value = self.volS.value - movePoint.y/40;
//        [sender setTranslation:CGPointZero inView:self.view];
        self.player.volume = self.volS.value;
    }
    else
    {
        // 左右调节进度
//        [self pauseAction];
        
//        NSLog(@"桃子%f",_timeS.value);
        
//        NSLog(@"🍎 %f",movePoint.x);
        
        CMTime t = CMTimeMake(_timeS.value * _totalDuration  + movePoint.x/20, 1);
        [self.player seekToTime:t];
        
//        _timeS.hidden = YES;
//        _timeS.hidden = NO;
        
//        [self playAction];
        
    }
    
//    [sender setTranslation:CGPointZero inView:self.view];
}














-(void)backAction
{
//    [self.player pause];
    MovieViewController *movie = [[MovieViewController alloc] init];
//    movie.player = self.player;

//    movie.totalDuration = self.totalDuration;
    CMTime t = CMTimeMake(self.current * _totalDuration, 1);
    
//    NSLog(@"QQQ");
    [self dismissViewControllerAnimated:YES completion:nil];
    [movie.player seekToTime:t];

}
#pragma 基本控件
-(void)total
{
//    self.container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
//    _container.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:self.container];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(40*WIDTH, 270*HEIGHT, 60*WIDTH, 30*HEIGHT)];
    self.timeLabel.text = @"00:00";
    self.timeLabel.textColor = [UIColor colorWithRed:0.926 green:0.304 blue:0.902 alpha:1.000];
    self.timeLabel.backgroundColor = [UIColor colorWithRed:0.294 green:0.372 blue:0.884 alpha:1.000];
    [self.viewAll addSubview:self.timeLabel];
    
    
    self.endL = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.height - 100*WIDTH, 270*HEIGHT, 60*WIDTH, 30*HEIGHT)];
    self.endL.text = @"00:00";
    self.endL.textColor = [UIColor colorWithRed:0.926 green:0.304 blue:0.902 alpha:1.000];
    self.endL.backgroundColor = [UIColor colorWithRed:0.294 green:0.372 blue:0.884 alpha:1.000];
    [self.viewAll addSubview:self.endL];
    
    self.playB = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playB.frame = CGRectMake(150*WIDTH, 290*HEIGHT, 50*WIDTH, 30*HEIGHT);
    [self.playB setTitle:@"播放" forState:UIControlStateNormal];
    //    [self.playB setTitle:@"继续" forState:UIControlStateSelected];
    [self.playB setTitleColor:[UIColor colorWithRed:0.926 green:0.304 blue:0.902 alpha:1.000] forState:UIControlStateNormal];
    self.playB.backgroundColor = [UIColor colorWithRed:0.294 green:0.372 blue:0.884 alpha:1.000];
    [self.playB addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    [self.viewAll addSubview:self.playB];
    
    self.pauseB = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pauseB.frame = CGRectMake(250*WIDTH, 290*HEIGHT, 50*WIDTH, 30*HEIGHT);
    self.pauseB.backgroundColor = [UIColor colorWithRed:0.294 green:0.372 blue:0.884 alpha:1.000];
    [self.pauseB setTitle:@"暂停" forState: UIControlStateNormal];
    [self.pauseB setTitleColor:[UIColor colorWithRed:0.926 green:0.304 blue:0.902 alpha:1.000] forState:UIControlStateNormal];
    [self.pauseB addTarget:self action:@selector(pauseAction) forControlEvents:UIControlEventTouchUpInside];
    [self.viewAll addSubview:self.pauseB];
    
    
    
    
    self.backB = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backB.frame = CGRectMake(350*WIDTH, 290*HEIGHT, 50*WIDTH, 30*HEIGHT);
    self.backB.backgroundColor = [UIColor colorWithRed:0.294 green:0.372 blue:0.884 alpha:1.000];
    [self.backB setTitle:@"缩小" forState:UIControlStateNormal];
//    self.backB.userInteractionEnabled = YES;
    [self.backB setTitleColor:[UIColor colorWithRed:0.926 green:0.304 blue:0.902 alpha:1.000] forState:UIControlStateNormal];
    [self.backB addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.viewAll addSubview:self.backB];
    
    
//    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
//    self.playerLayer.frame = self.container.frame;
//    [self.container.layer addSublayer:self.playerLayer];
    
}

#pragma 播放
-(void)playAction
{
    
    //    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(trackAction) userInfo:nil repeats:YES];
    [self.player play];
}

-(void)addTimerObserver
{
    __weak MovieVC *m = self;
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        m.current = CMTimeGetSeconds(time);
//        m.timeLabel.text = [m changeTimer:m.current];
//        _totalDuration = CMTimeGetSeconds(_playerItem.duration);
//        m.endL.text = [m changeTimer:m.totalDuration];
        m.scale = m.current / _totalDuration;
        m.timeS.value = m.scale;
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"getChange" object:[m changeTimer:m.current]];
        //        NSLog(@"..........");
    }];
}

#pragma 暂停
-(void)pauseAction
{
    [self.player pause];
}

#pragma 进程音量 Slider
-(void)slider
{
    self.timeS = [[UISlider alloc] initWithFrame:CGRectMake(self.view.bounds.size.height/2-150*WIDTH, 270*HEIGHT, 300*WIDTH, 20*HEIGHT)];
    self.timeS.value = self.scale;
    [self.timeS addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventValueChanged];
    [self.viewAll addSubview:self.timeS];
    //    [_timeS release];
    
    self.volS = [[UISlider alloc] initWithFrame:CGRectMake(-50*WIDTH, 120*HEIGHT, 150*WIDTH, 20*HEIGHT)];
    [self.volS addTarget:self action:@selector(volAction) forControlEvents:UIControlEventValueChanged];
    //设置旋转90度
    self.volS.transform = CGAffineTransformMakeRotation(-1.57079633);

    
    self.volS.minimumValue = 0.0f;
    self.volS.maximumValue = 10.0f;
    [self.viewAll addSubview:self.volS];
}

-(void)timeAction:(UISlider *)timeS;
{
    CMTime t = CMTimeMake(timeS.value * _totalDuration, 1);
    [self.player seekToTime:t];
}

-(void)volAction
{
    
    // 设置音量
    self.player.volume = self.volS.value;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //在视图将要出现的时候,创建NC上的导航按钮
    
    //    _tool.GoSongView.hidden = YES;
    //    [_tool.GoSongView setHidden:YES];
    [self playAction];
    _tool.GoSongView.alpha = 0;
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [_tool.detail.player pause];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //当视图即将消失的时候把装有导航按钮的视图删掉
    //    [_tool.GoSongView setHidden:NO];
    //    [self stopAction];
    //    [self pauseAction];
    _tool.GoSongView.alpha = 1;
    [_tool.detail.player resume];
}


















// 强制横屏
-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation { return (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight); }
-(NSUInteger)supportedInterfaceOrientations { return UIInterfaceOrientationMaskLandscapeRight; }
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
