//
//  New-Head-VC.m
//  新闻
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "New-Head-VC.h"
#import "New-Head-C.h"
#import "New-Head-M.h"
#import "MJRefresh.h"
#import "LXDAFNetTool.h"
#import "UIImageView+WebCache.h"
#import "WebView-VC.h"
#import "SDCycleScrollView.h"
#import "New-Lunbo-M.h"

@interface New_Head_VC () <UITableViewDelegate, UITableViewDataSource,SDCycleScrollViewDelegate>
@property (nonatomic, retain) UITableView       *tableV;
@property (nonatomic, retain) NSMutableArray    *arr;
@property (nonatomic, assign) NSInteger         page;
@property (nonatomic, assign) NSInteger         number;
// 轮播图
@property (nonatomic, retain) NSMutableArray    *arrHead;
@property (nonatomic, retain) SDCycleScrollView *scy;

@end
@implementation New_Head_VC
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
    self.page = 1;
    self.number = 0;
    [self begin];
    [self refresh];
}

-(void)refresh
{
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
        [self getHead];
        [self.tableV reloadData];
    }];
    [self.tableV.mj_header beginRefreshing];
    
    self.tableV.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.page ++;
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
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 10*HEIGHT, self.bounds.size.width, self.bounds.size.height) style:UITableViewStylePlain];
    //    self.tableV.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    self.tableV.separatorStyle = NO;
    [self.contentView addSubview:self.tableV];
    
    //    NSLog(@"%ld",self.arr.count);
    
    //创建轮播图
    self.scy = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.bounds.size.width - 20*WIDTH, self.bounds.size.width/7*4) delegate:self placeholderImage:[UIImage imageNamed:@"all2.jpg"]];
    self.scy.delegate = self;
    self.scy.autoScrollTimeInterval = 4.0;
    self.scy.backgroundColor = [UIColor grayColor];
    self.tableV.tableHeaderView = self.scy;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arr count];
    //    return 100;
//        NSLog(@"%ld",[self.arr count]);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    New_Head_M *act = [self.arr objectAtIndex:indexPath.row];
    if ([act.type isEqualToString:@"doc"]||[act.type isEqualToString:@"topic2"]||[act.type isEqualToString:@"web"]||[act.type isEqualToString:@"text_live"]) {
        return 100*HEIGHT;
    }else
    {
        return 140*HEIGHT;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    New_Head_M *act = [self.arr objectAtIndex:indexPath.row];
    
    if ([act.type isEqualToString:@"doc"]) {
        static NSString *cellStr = @"cellDoc";
        New_Head_C *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        
        if (nil == cell) {
            
            cell = [[New_Head_C alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
        }
        [cell.imageDoc sd_setImageWithURL:[NSURL URLWithString:act.thumbnail]placeholderImage:[UIImage imageNamed:@"head1.jpg"]];
        cell.titleDoc.text = act.title;
        cell.timeDoc.text = act.updateTime;
        cell.sourceDoc.text = act.source;
        cell.commentDoc.text = act.commentsall;
        cell.imageInf.image = [UIImage imageNamed:@"信息1.png"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    }
    // 有三张图片的 cell, 必须要第二页开始才能刷出来
    else if ([act.type isEqualToString:@"slide"]) {
        static NSString *cellStr = @"cellSlide";
        New_Head_C *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        
        if (nil == cell) {
            
            cell = [[New_Head_C alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
        }
        cell.titleSlide.text = act.title;
        [cell.imageSlideOne sd_setImageWithURL:[act.images objectAtIndex:0]placeholderImage:[UIImage imageNamed:@"head1.jpg"]];
        [cell.imageSlideTwo sd_setImageWithURL:[act.images objectAtIndex:1]placeholderImage:[UIImage imageNamed:@"head1.jpg"]];
        [cell.imageSlideThree sd_setImageWithURL:[act.images objectAtIndex:2]placeholderImage:[UIImage imageNamed:@"head1.jpg"]];
        cell.timeSlide.text = act.updateTime;
        cell.commentSlide.text = act.commentsall;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
        
        return cell;
    }
    // 体育类, 大部分时候都不出现
    else if([act.type isEqualToString:@"sports_live"])
    {
        static NSString *cellStr = @"cellSport";
        New_Head_C *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        
        if (nil == cell) {
            
            cell = [[New_Head_C alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
        }
        
        cell.titleSport.text = act.title;
        [cell.imageLeftlogo sd_setImageWithURL:[NSURL URLWithString:act.leftLogo]placeholderImage:[UIImage imageNamed:@"head1.jpg"]];
        [cell.imageRightlogo sd_setImageWithURL:[NSURL URLWithString:act.rightLogo]placeholderImage:[UIImage imageNamed:@"head1.jpg"]];
        cell.labelLeftName.text = act.leftName;
        cell.labelRightName.text = act.rightName;
        cell.labelLeftScore.text = act.leftScore;
        cell.labelRightScore.text = act.rightScore;
        cell.labelTag.text = act.tag;
        cell.labelCenter.text = @":";
        cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
        return cell;
    }
    static NSString *cellStr = @"celltopic";
    New_Head_C *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    
    if (nil == cell) {
        
        cell = [[New_Head_C alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
    }
    [cell.imageDoc sd_setImageWithURL:[NSURL URLWithString:act.thumbnail]placeholderImage:[UIImage imageNamed:@"head1.jpg"]];
    cell.titleDoc.text = act.title;
    cell.timeDoc.text = act.updateTime;
    cell.sourceDoc.text = act.source;
    cell.commentDoc.text = act.commentsall;
    cell.imageInf.image = [UIImage imageNamed:@"信息1.png"];
    if ([act.type isEqualToString:@"topic2"]) {
        cell.labelType.text = @"专题";
    }
    if ([act.type isEqualToString:@"text_live"]) {
        cell.labelType.text = @"直播";
    }
    
    
    NSMutableArray *image = [NSMutableArray array];
    for (New_Lunbo_M *lomodel in self.arrHead) {
        [image addObject:lomodel.thumbnail];
    }
    self.scy.imageURLStringsGroup = image;
    
    NSMutableArray *title = [NSMutableArray array];
    for (New_Lunbo_M *browse in self.arrHead) {
        [title addObject:browse.title];
    }
    self.scy.titlesGroup = title;
    
    
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    return cell;
}

-(void)getData
{
    if (self.number == 0) {
        self.arr = [NSMutableArray array];
        self.arrHead = [NSMutableArray array];
    }
    // 时间戳
    //    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    //    long long dTime = [[NSNumber numberWithDouble:timeInterval] longLongValue]; // 将double转为long long型
    //    NSString *tempTime = [NSString stringWithFormat:@"%llu",dTime]; // 输出long long型
    
    
    NSString *url = [NSString stringWithFormat:@"http://api.iclient.ifeng.com/ClientNews?id=SYLB10,SYDT10,SYRECOMMEND&province=辽宁省&city=大连市&newShowType=1&gv=5.0.0&av=0&proid=ifengnews&os=ios_9.1&vt=5&screen=640x1136&publishid=4002&uid=d164f40d9e7b43cab841ce7c774c12c4&page=%ld",self.page];
    [LXDAFNetTool getNetWithURL:url body:nil headFile:nil responseStyle:LXDJSON success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSMutableArray *arr = [responseObject objectForKey:@"item"];
//        for (NSMutableDictionary *temp in arr) {
//            Read_Recommend_M *browse = [[Read_Recommend_M alloc] initWithDic:temp];
//            browse.images = [NSMutableArray array];
//            for (NSString *temD in temp[@"style"][@"images"]) {
//                [browse.images addObject:temD];
//            }
//            [self.arr addObject:browse];
//        }
        
        //        NSLog(@"%@",arr);
        NSMutableDictionary *dic = [responseObject objectAtIndex:0];
        
        NSMutableArray *arr = [dic objectForKey:@"item"];
        for (NSMutableDictionary *temp in arr) {
            New_Head_M *browse = [[New_Head_M alloc] init];
//            NSLog(@"%@",temp[@"sportsLiveExt"]);
            [browse setValuesForKeysWithDictionary:temp[@"sportsLiveExt"]];
            [browse setValuesForKeysWithDictionary:temp];
            browse.images = [NSMutableArray array];
            for (NSString *temD in temp[@"style"][@"images"]) {
                [browse.images addObject:temD];
            }
//            NSLog(@"%@",browse.leftName);
            [self.arr addObject:browse];
        }
        
        // 轮播图数据
//        NSMutableDictionary *dicHead = [responseObject objectAtIndex:1];
//        NSMutableArray *arrHead = [dicHead objectForKey:@"item"];
//        
//        for (NSMutableDictionary *temp in arrHead) {
//            // 按数组取
////            [_arrHead addObject:temp[@"thumbnail"]];
//            // 按 model 取
//            New_Lunbo_M *head = [[New_Lunbo_M alloc] initWithDic:temp];
//            [_arrHead addObject:head];
//        }
//        NSLog(@"%@",_arrHead);
        
        [self.tableV.mj_header endRefreshing];
        [self.tableV.mj_footer endRefreshing];
        [self.tableV reloadData];
        
//        NSLog(@"%ld",self.arr.count);
        
    }
                        failure:^(NSURLSessionDataTask *task, NSError *error) {
                            
                        }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    New_Head_M *act = [self.arr objectAtIndex:indexPath.row];
//    WebView_VC *wb = [[WebView_VC alloc]init];
//    NSLog(@"%@",act.commentsUrl);
    if (act.commentsUrl != nil) {
        [self.delegate getchange:act.commentsUrl];
    }
    
    
}

-(void)getHead
{
    if (self.number == 0) {
        self.arr = [NSMutableArray array];
        self.arrHead = [NSMutableArray array];
    }

    
    NSString *url = [NSString stringWithFormat:@"http://api.iclient.ifeng.com/ClientNews?id=SYLB10,SYDT10,SYRECOMMEND&province=辽宁省&city=大连市&newShowType=1&gv=5.0.0&av=0&proid=ifengnews&os=ios_9.1&vt=5&screen=640x1136&publishid=4002&uid=d164f40d9e7b43cab841ce7c774c12c4&page=%ld",self.page];
    [LXDAFNetTool getNetWithURL:url body:nil headFile:nil responseStyle:LXDJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        

        // 轮播图数据
        NSMutableDictionary *dicHead = [responseObject objectAtIndex:1];
        NSMutableArray *arrHead = [dicHead objectForKey:@"item"];
        
        for (NSMutableDictionary *temp in arrHead) {
            // 按数组取
            //            [_arrHead addObject:temp[@"thumbnail"]];
            // 按 model 取
            New_Lunbo_M *head = [[New_Lunbo_M alloc] initWithDic:temp];
            [_arrHead addObject:head];
        }
        //        NSLog(@"%@",_arrHead);
        
        [self.tableV.mj_header endRefreshing];
        [self.tableV.mj_footer endRefreshing];
        [self.tableV reloadData];
        
        //        NSLog(@"%ld",self.arr.count);
        
    }
                        failure:^(NSURLSessionDataTask *task, NSError *error) {
                            
                        }];

}







































@end
