//
//  Audio-Detail-VC.m
//  新闻
//
//  Created by dllo on 16/3/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "Audio-Detail-VC.h"
#import "MJRefresh.h"
#import "LXDAFNetTool.h"
#import "UIImageView+WebCache.h"
#import "Audio-Detail-M.h"
#import "Audio-Detail-V.h"
#import <Foundation/Foundation.h>
#import "STKAudioPlayer.h"
#import "Audio-Tools.h"
 


@interface Audio_Detail_VC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain  ) NSMutableArray     *arrTotal;
@property (nonatomic, retain  ) NSMutableArray     *arr2;
@property (nonatomic, assign  ) NSInteger          page;
@property (nonatomic, assign  ) NSInteger          number;



@property (nonatomic, retain  ) NSMutableArray     *arr;

@property (nonatomic, retain  ) UIButton           *playB;
@property (nonatomic, retain  ) UIButton           *stopB;
@property (nonatomic, retain  ) UIButton           *nextB;
@property (nonatomic, retain  ) UIButton           *lastB;

@property (nonatomic, retain  ) UILabel            *modelL;
@property (nonatomic, retain  ) UILabel            *beginL;
@property (nonatomic, retain  ) UILabel            *endL;
@property (nonatomic, retain  ) UILabel            *titleL;

@property (nonatomic, retain  ) UIButton           *orderB;
@property (nonatomic, retain  ) UIButton           *repeatB;
@property (nonatomic, retain  ) UIButton           *randomB;


@property (nonatomic, retain  ) UISlider           *volS;
@property (nonatomic, retain  ) UISlider           *timeS;
@property (nonatomic, retain  ) NSTimer            *timer;
@property (nonatomic, copy    ) NSString           *songModel;

// 保存音乐文件的数组
@property (nonatomic, strong  ) NSMutableArray     *songs;
@property (nonatomic, strong  ) NSMutableArray     *titles;
@property (nonatomic, strong  ) NSMutableArray     *images;
// 用一个 int 型记录当前索引
@property (nonatomic, assign  ) NSInteger          currentIndex;

@property (nonatomic, retain  ) UISegmentedControl *segmentOrder;

@property (nonatomic, retain  ) Audio_Tools        *tool;
// 控制在主页面能随时进入播放页面的 View
@property (nonatomic, getter = isOn) BOOL on;
// 最上面的动画, 图片转
@property (nonatomic, retain) CABasicAnimation *animation;
@property (nonatomic, retain) UIImageView *imageView;

@end

@implementation Audio_Detail_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    NSLog(@"%@",self.idTotal);
    
    // Audio_Tools *audio = [[Audio_Tools alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tool = [[Audio_Tools alloc] init];
    _tool.arrayAudio = _songs;
    self.page = 1;
    self.number = 0;
    [self begin];
    [self refresh];
    
    self.currentIndex = 0;
    
    //    NSLog(@"%@",self.songs);
    //    [self segment];
    
    [self Button];
    [self slider];
    [self labelAction];
    //    [self getData];
    
    self.songModel = @"order";
    //    [self.tableV reloadData];
    
    self.on = YES;
    
    // 动画
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 40*WIDTH, 20*HEIGHT, 80*WIDTH, 80*HEIGHT)];
    //    _imageView.image = [UIImage imageNamed:@"head4.jpg"];
    _imageView.layer.cornerRadius = 40*HEIGHT;
    _imageView.layer.masksToBounds = YES;
    _imageView.clipsToBounds = YES;
    [self.view addSubview:_imageView];
    
    
    
}

// 播放歌曲

-(void)Button
{
    self.playB = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playB.frame = CGRectMake(self.view.bounds.size.width/2-65*WIDTH, 200*HEIGHT, 50*WIDTH, 30*HEIGHT);
    [self.playB setTitle:@"播放" forState:UIControlStateNormal];
    [self.playB setTitle:@"暂停" forState:UIControlStateSelected];
    [self.playB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.playB addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.playB];
    
    self.stopB = [UIButton buttonWithType:UIButtonTypeCustom];
    self.stopB.frame = CGRectMake(self.view.bounds.size.width/2+100*WIDTH, 200*HEIGHT, 50*WIDTH, 30*HEIGHT);
    [self.stopB setTitle:@"停止" forState:UIControlStateNormal];
    [self.stopB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.stopB addTarget:self action:@selector(stopAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.stopB];
    
    self.nextB = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextB.frame = CGRectMake(self.view.bounds.size.width/2+15*WIDTH, 200*HEIGHT, 60*WIDTH, 30*HEIGHT);
    [self.nextB setTitle:@"下一首" forState:UIControlStateNormal];
    [self.nextB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.nextB addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextB];
    
    self.lastB = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lastB.frame = CGRectMake(self.view.bounds.size.width/2 - 160*WIDTH, 200*HEIGHT, 60*WIDTH, 30*HEIGHT);
    [self.lastB setTitle:@"上一首" forState: UIControlStateNormal];
    [self.lastB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.lastB addTarget:self action:@selector(lastAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.lastB];
    
    //    self.orderB = [UIButton buttonWithType:UIButtonTypeCustom];
    //    self.orderB.frame = CGRectMake(20, 500, 80, 50);
    //    [self.orderB setTitle:@"顺序播放" forState:UIControlStateNormal];
    //    [self.orderB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [self.orderB addTarget:self action:@selector(orderAction) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:self.orderB];
    //
    //    self.repeatB = [UIButton buttonWithType:UIButtonTypeCustom];
    //    self.repeatB.frame = CGRectMake(120, 500, 80, 50);
    //    [self.repeatB setTitle:@"重复播放" forState: UIControlStateNormal];
    //    [self.repeatB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [self.repeatB addTarget:self action:@selector(repeatAction) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:self.repeatB];
    //
    //    self.randomB = [UIButton buttonWithType:UIButtonTypeCustom];
    //    self.randomB.frame = CGRectMake(220, 500, 80, 50);
    //    [self.randomB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [self.randomB setTitle:@"随机播放" forState: UIControlStateNormal];
    //    [self.randomB addTarget:self action:@selector(randomAction) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:self.randomB];
}

-(void)slider
{
    self.timeS = [[UISlider alloc] initWithFrame:CGRectMake(80*WIDTH, 140*HEIGHT, self.view.bounds.size.width - 160*WIDTH, 20*HEIGHT)];
    [self.timeS addTarget:self action:@selector(timeAction) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.timeS];
    //    [_timeS release];
    
    self.volS = [[UISlider alloc] initWithFrame:CGRectMake(80*WIDTH, 160*HEIGHT, self.view.bounds.size.width - 160*WIDTH, 20*HEIGHT)];
    [self.volS addTarget:self action:@selector(volAction) forControlEvents:UIControlEventValueChanged];
    self.volS.value = 5.0f;
    self.volS.minimumValue = 0.0f;
    self.volS.maximumValue = 10.0f;
    [self.view addSubview:self.volS];
    //    [_volS release];
}

-(void)stopAction
{
    [self.player stop];
    self.playB.selected = NO;
    [self.timer invalidate];
    self.timer = nil;
    self.timeS.value = 0;
    self.tool.GoSongView.hidden = YES;
    self.beginL.text = [NSString stringWithFormat:@"00:00"];
    self.endL.text = [NSString stringWithFormat:@"00:00"];
}

-(void)playAction
{
    if (STKAudioPlayerStatePlaying == self.player.state) {
        //暂停
        [self.player pause];
        self.playB.selected = NO;
        self.tool.GoSongView.hidden = YES;
        // 暂停动画
        CFTimeInterval pausedTime = [_imageView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        _imageView.layer.speed = 0.0;
        _imageView.layer.timeOffset = pausedTime;
        
    } else if (STKAudioPlayerStatePaused == self.player.state) {
        //继续
        [self.player resume];
        self.playB.selected = YES;
        self.tool.GoSongView.hidden = NO;
        // 继续动画
        CFTimeInterval pausedTime = [_imageView.layer timeOffset];
        _imageView.layer.speed = 1.0;
        _imageView.layer.timeOffset = 0.0;
        _imageView.layer.beginTime = 0.0;
        CFTimeInterval timeSincePause = [_imageView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
        _imageView.layer.beginTime = timeSincePause;
        
    }else
    {
        STKAudioPlayerOptions playerOptions = {YES, YES, {50, 100, 200, 400, 800, 1600, 2600, 16000}};
        self.player = [[STKAudioPlayer alloc] initWithOptions:playerOptions];
        
        //        [self.player play:@"http://cdn.wawa.fm/group1/M00/01/1E/Cvtf3VZgMnSASQH1AFdyLx-UILg839.mp3"];
        //        [self.player play:self.songs[self.currentIndex]];
        //        NSLog(@"%@",self.songs);
        [self.player play:[self.songs objectAtIndex:self.currentIndex]];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(trackAction) userInfo:nil repeats:YES];
        self.titleL.text = [_titles objectAtIndex:self.currentIndex];
        
        self.playB.selected = YES;
        
        self.tool.GoSongView.hidden = NO;
        
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:[_images objectAtIndex:self.currentIndex]]];
    }
}

-(void)timeAction
{
    [self.player seekToTime:self.timeS.value];
}
// 时间监控
-(void)trackAction
{
    self.timeS.maximumValue = self.player.duration;
    //    NSLog(@"当前分钟:%ld, 当前秒:%ld",(NSInteger)self.player.progress / 60, (NSInteger)self.player.progress % 60);
    //    NSLog(@"剩余分钟: %ld,剩余秒:%ld", (NSInteger)(self.player.duration - self.player.progress) / 60, (NSInteger)(self.player.duration - self.player.progress) % 60);
    self.beginL.text = [NSString stringWithFormat:@"%ld:%ld",(NSInteger)self.player.progress / 60, (NSInteger)self.player.progress % 60];
    self.endL.text = [NSString stringWithFormat:@"%ld:%ld", (NSInteger)(self.player.duration - self.player.progress) / 60, (NSInteger)(self.player.duration - self.player.progress) % 60];
    self.timeS.value = self.player.progress;
    
    // 放完歌以后
    //    if (self.player.duration == self.player.progress) {
    //        [self nextAction];
    //    }
    
}
// 设置音量
-(void)volAction
{
    
    // 设置音量
    self.player.volume = self.volS.value;
}
// 下一首方法
-(void)nextAction
{
    [self stopAction];
    
    [self.timer invalidate];
    self.timer = nil;
    //    [self.player release];
    
    if ([self.songModel isEqualToString:@"order"]) {
        self.currentIndex++;
        if (self.currentIndex >= self.songs.count) {
            self.currentIndex = 0;
        }
    }
    if ([self.songModel isEqualToString:@"random"]) {
        NSInteger num = 0;
        num = arc4random() % (self.songs.count + 1);
        for (num = arc4random() % (self.songs.count + 1); num == self.currentIndex; num = 0) {
            num = arc4random() % (self.songs.count + 1);
        }
        self.currentIndex = num;
    }
    if ([self.songModel isEqualToString:@"repeat"]) {
        
    }
    [self playAction];
}
// 上一首
-(void)lastAction
{
    [self stopAction];
    
    [self.timer invalidate];
    self.timer = nil;
    //    [self.player release];
    
    
    
    if ([self.songModel isEqualToString:@"order"]) {
        self.currentIndex--;
        if (self.currentIndex <= 0) {
            self.currentIndex = [self.songs count];
        }
    }
    if ([self.songModel isEqualToString:@"random"]) {
        NSInteger num = 0;
        num = arc4random() % (self.songs.count + 1);
        for (num = arc4random() % (self.songs.count + 1); num == self.currentIndex; num = 0) {
            num = arc4random() % (self.songs.count + 1);
        }
        self.currentIndex = num;
    }
    if ([self.songModel isEqualToString:@"repeat"]) {
        
    }
    self.currentIndex--;
    [self playAction];
}

-(void)labelAction
{
    self.beginL = [[UILabel alloc] initWithFrame:CGRectMake(20*WIDTH, 140*HEIGHT, 60*WIDTH, 20*HEIGHT)];
    //    self.beginL.backgroundColor = [UIColor redColor];
    //    self.beginL.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.beginL];
    
    self.endL = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 80*WIDTH, 140*HEIGHT, 60*WIDTH, 20*HEIGHT)];
    //    self.endL.backgroundColor = [UIColor blueColor];
    //    self.endL.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.endL];
    
    self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 200*WIDTH, 115*HEIGHT, 400*WIDTH, 20*HEIGHT)];
    self.titleL.backgroundColor = [UIColor whiteColor];
    self.titleL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.titleL];
}

#pragma 歌曲播放方式
-(void)orderAction
{
    self.songModel = @"order";
    self.modelL.text = @"顺序播放";
    //    NSLog(@"%@",self.songModel);
}

-(void)repeatAction
{
    self.songModel = @"repeat";
    self.modelL.text = @"重复播放";
    //    NSLog(@"%@",self.songModel);
}

-(void)randomAction
{
    self.songModel = @"random";
    self.modelL.text = @"随机播放";
    //    NSLog(@"%@",self.songModel);
}

-(void)segment
{
    self.segmentOrder = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"顺序播放", @"重复播放",@"随机播放",  nil]];
    self.segmentOrder.frame = CGRectMake(self.view.bounds.size.width/2 - 100*WIDTH, 0, 200*WIDTH, 30*HEIGHT);
    [self.segmentOrder addTarget:self action:@selector(segActionT:) forControlEvents:UIControlEventValueChanged];
    [self.navigationController.navigationBar addSubview: self.segmentOrder];
    //    [segment release];
}

-(void)segActionT:(UISegmentedControl *)sender
{
    if (0 == sender.selectedSegmentIndex) {
        [self orderAction];
        NSLog(@"%@",self.songModel);
    }
    if (1 == sender.selectedSegmentIndex) {
        [self repeatAction];
        NSLog(@"%@",self.songModel);
    }
    if (2 == sender.selectedSegmentIndex) {
        [self randomAction];
        NSLog(@"%@",self.songModel);
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //在视图将要出现的时候,创建NC上的导航按钮
    [self segment];
    [self getData];
    [self.tableV reloadData];
    //    _tool.GoSongView.hidden = YES;
    //    [_tool.GoSongView setHidden:YES];
    _tool.GoSongView.alpha = 0;
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    // 圆图片动画
    _animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    _animation.delegate =self;
    _animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI,0, 0,1.0)];
    //执行时间
    _animation.duration =30;
    _animation.cumulative =YES;//累积的
    //执行次数
    _animation.repeatCount = INT_MAX;
    _animation.autoreverses=YES;//是否自动重复
    [_imageView.layer addAnimation:_animation forKey:@"animation"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //当视图即将消失的时候把装有导航按钮的视图删掉
    [self.segmentOrder removeFromSuperview];
    //    [_tool.GoSongView setHidden:NO];
    //    [self stopAction];
    _tool.GoSongView.alpha = 1;
}













































// 底下的 tableview

-(void)begin
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2-50*HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height/2+50*HEIGHT) style:UITableViewStylePlain];
    //    self.tableV.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    self.tableV.separatorStyle = NO;
    [self.view addSubview:self.tableV];
    
    //    NSLog(@"%ld",self.arr.count);
}

-(void)refresh
{
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //        self.page = @"down";
        [self getData];
        [self.tableV reloadData];
    }];
    [self.tableV.mj_header beginRefreshing];
    
    self.tableV.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.page = self.page + 10;
        self.number++;
        [self getData];
        [self.tableV reloadData];
    }];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrTotal count];
    //    return 100;
    //    NSLog(@"%ld",[self.arr count]);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Audio_Detail_M *act = [self.arrTotal objectAtIndex:indexPath.row];
    static NSString *cellStr = @"cellSubject";
    Audio_Detail_V *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    
    if (nil == cell) {
        
        cell = [[Audio_Detail_V alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
    }
    
    [cell.imageImg sd_setImageWithURL:[NSURL URLWithString:act.image]];
    
    //    NSNumberFormatter* numberFormatter2 = [[NSNumberFormatter alloc] init];
    //    cell.labelPlayCount.text = [numberFormatter2 stringFromNumber:act.playCount];
    
    cell.titleL.text = act.title;
    cell.timeL.text = act.createTime;
    
    return cell;
}


-(void)getData
{
    if (self.number == 0) {
        self.arrTotal = [NSMutableArray array];
        self.arr2 = [NSMutableArray array];
        self.songs = [NSMutableArray array];
        self.titles = [NSMutableArray array];
        self.images = [NSMutableArray array];
        self.beginL.text = [NSString stringWithFormat:@"00:00"];
        self.endL.text = [NSString stringWithFormat:@"00:00"];
    }
    // 时间戳
    //    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    //    long long dTime = [[NSNumber numberWithDouble:timeInterval] longLongValue]; // 将double转为long long型
    //    NSString *tempTime = [NSString stringWithFormat:@"%llu",dTime]; // 输出long long型
    //    NSLog(@"%@",self.page);
    
    NSString *url = [NSString stringWithFormat:@"http://api.3g.ifeng.com/api_fm_resource?rid=%@&page=%ld&pageSize=20&gv=5.0.0&av=0&proid=ifengnews&os=ios_9.1&vt=5&screen=640x1136&publishid=4002&uid=d164f40d9e7b43cab841ce7c774c12c4",self.idTotal,self.page];
    [LXDAFNetTool getNetWithURL:url body:nil headFile:nil responseStyle:LXDJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //        NSLog(@"%@",url);
        NSMutableArray *arr = [[responseObject objectForKey:@"data"] objectForKey:@"resourcelist"];
        
        //        NSLog(@"%@",arr);
        //        for (NSMutableDictionary *temp in arr) {
        //            Audio_Detail_M *browse = [[AV_Video_M alloc] initWithDic:temp];
        //            browse.descrip = [temp objectForKey:@"description"];
        //            [self.arr addObject:browse];
        //        }
        for (NSMutableDictionary *temp in arr) {
            Audio_Detail_M *browse = [[Audio_Detail_M alloc] initWithDic:temp];
            browse.filePath = [[[temp objectForKey:@"audiolist"] objectAtIndex:0]objectForKey:@"filePath"];
            //            NSLog(@"%@",browse.id);
            [self.songs addObject:[[[temp objectForKey:@"audiolist"] objectAtIndex:0]objectForKey:@"filePath"]];
            [self.titles addObject:[temp objectForKey:@"title"]];
            [self.images addObject:[temp objectForKey:@"image"]];
            [self.arrTotal addObject:browse];
        }
        //        NSLog(@"%@",self.titles);
        
        [self.tableV.mj_header endRefreshing];
        [self.tableV.mj_footer endRefreshing];
        [self.tableV reloadData];
        
    }
                        failure:^(NSURLSessionDataTask *task, NSError *error) {
                            
                        }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    Audio_Detail_M *act = [self.arrTotal objectAtIndex:indexPath.row];
    [self stopAction];
    self.currentIndex = indexPath.row;
    [self playAction];
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
