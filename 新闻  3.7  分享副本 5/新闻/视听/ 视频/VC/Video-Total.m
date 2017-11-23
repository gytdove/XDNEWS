//
//  Video-Total.m
//  新闻
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "Video-Total.h"
#import "MJRefresh.h"
#import "LXDAFNetTool.h"
#import "AV-Video-C.h"
#import "UIImageView+WebCache.h"
#import "AV-Video-M.h"
#import "MediaPlayer/MediaPlayer.h"

@interface Video_Total () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain  ) UITableView    *tableV;
@property (nonatomic, retain  ) NSMutableArray *arr;
@property (nonatomic, retain  ) NSMutableArray *arr2;
@property (nonatomic, assign  ) NSInteger      page;
@property (nonatomic, assign  ) NSInteger      number;

@end

@implementation Video_Total
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}
-(void)creatView
{
    self.page = 0;
    self.number = 0;
    [self begin];
    [self refresh];
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
    
    
    
    //    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    //    long long dTime = [[NSNumber numberWithDouble:timeInterval] longLongValue]; // 将double转为long long型
    //    NSString *tempTime = [NSString stringWithFormat:@"%llu",dTime]; // 输出long long型
    //    NSLog(@"%@",tempTime);
    
}

-(void)begin
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 20*HEIGHT, self.bounds.size.width, self.bounds.size.height) style:UITableViewStylePlain];
    //    self.tableV.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    self.tableV.separatorStyle = NO;
    [self.contentView addSubview:self.tableV];
    
    //    NSLog(@"%ld",self.arr.count);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arr count];
    //    return 100;
    //    NSLog(@"%ld",[self.arr count]);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 240*HEIGHT;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AV_Video_M *act = [self.arr objectAtIndex:indexPath.row];
    static NSString *cellStr = @"cellSubject";
    AV_Video_C *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    
    if (nil == cell) {
        
        cell = [[AV_Video_C alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
    }

    cell.labelTitle.text = act.title;
    cell.labelDescription.text = act.descrip;
    [cell.imageCover sd_setImageWithURL:[NSURL URLWithString:act.cover] placeholderImage:nil];
//   NSLog(@"%@",act.length);
    
    NSNumberFormatter* numberFormatter1 = [[NSNumberFormatter alloc] init];
    cell.labelLenth.text = [numberFormatter1 stringFromNumber:act.length];
    
    NSNumberFormatter* numberFormatter2 = [[NSNumberFormatter alloc] init];
   cell.labelPlayCount.text = [numberFormatter2 stringFromNumber:act.playCount];
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    
    cell.timeL.image = [UIImage imageNamed:@"时间.png"];
    cell.playL.image = [UIImage imageNamed:@"播放.png"];
    
    
    
    
    return cell;
}





-(void)getData
{
    if (self.number == 0) {
        self.arr = [NSMutableArray array];
        self.arr2 = [NSMutableArray array];
    }
    // 时间戳
    //    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    //    long long dTime = [[NSNumber numberWithDouble:timeInterval] longLongValue]; // 将double转为long long型
    //    NSString *tempTime = [NSString stringWithFormat:@"%llu",dTime]; // 输出long long型
    //    NSLog(@"%@",self.page);
    
    NSString *url = [NSString stringWithFormat:@"http://c.3g.163.com/nc/video/home/%ld-10.html",self.page];
    [LXDAFNetTool getNetWithURL:url body:nil headFile:nil responseStyle:LXDJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *arr = [responseObject objectForKey:@"videoList"];
        
        for (NSMutableDictionary *temp in arr) {
            AV_Video_M *browse = [[AV_Video_M alloc] initWithDic:temp];
//            NSLog(@"%@",browse.playCount);
            browse.descrip = [temp objectForKey:@"description"];
             
//             NSLog(@"%@",browse.descrip);
            [self.arr addObject:browse];
        }
       
        [self.tableV.mj_header endRefreshing];
        [self.tableV.mj_footer endRefreshing];
        [self.tableV reloadData];
        
    }
                        failure:^(NSURLSessionDataTask *task, NSError *error) {
                            
                        }];
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AV_Video_M *act = [self.arr objectAtIndex:indexPath.row];
    NSLog(@"%@",act.mp4_url);
    
    [self.delegate gomovie:act.mp4_url];
}











//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    AV_Video_M *act = [self.arr objectAtIndex:indexPath.row];
//    self.movie = [[MPMoviePlayerController alloc] initWithContentURL:
//                        [NSURL URLWithString:@"http://v.youku.com/player/getRealM3U8/vid/XNTY2MTAxOTUy/type/video.m3u8"]];
//    self.movie.movieControlMode = MPMovieControlStyleDefault;
//    [self.movie.view setFrame:CGRectMake(0, 0, 320, 380)];
//}


















































@end
