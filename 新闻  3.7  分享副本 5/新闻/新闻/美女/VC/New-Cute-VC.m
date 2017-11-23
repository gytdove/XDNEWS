//
//  New-Cute-VC.m
//  新闻
//
//  Created by dllo on 16/2/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "New-Cute-VC.h"
#import "MJRefresh.h"
#import "LXDAFNetTool.h"
#import "UIImageView+WebCache.h"
#import "New-Cute-M.h"
#import "New-Cute-C.h"

@interface New_Cute_VC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) UITableView    *tableV;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, assign) NSInteger      page;
@property (nonatomic, assign) NSInteger      number;
@property (nonatomic, copy  ) NSString       *timeNow;

@end

@implementation New_Cute_VC
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
        [self getData];
        [self.tableV reloadData];
    }];
    [self.tableV.mj_header beginRefreshing];
    
    self.tableV.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.page = self.page+10;
        self.number++;
        [self getData];
        [self.tableV reloadData];
    }];
    
    
    
}

-(void)begin
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 20*HEIGHT, self.bounds.size.width, self.bounds.size.height) style:UITableViewStylePlain];
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    self.tableV.separatorStyle = NO;
    [self.contentView addSubview:self.tableV];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arr count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return self.bounds.size.height;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    New_Cute_M *act = [self.arr objectAtIndex:indexPath.row];
    
    
    
    static NSString *cellStr = @"celltopic";
    New_Cute_C *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    
    if (nil == cell) {
        
        cell = [[New_Cute_C alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
    }
    
    
    
    NSNumberFormatter* numberFormatter1 = [[NSNumberFormatter alloc] init];
    cell.likeL.text = [numberFormatter1 stringFromNumber:act.likes];
    
//    NSLog(@"%@",cell.likeL.text);
    
    NSNumberFormatter* numberFormatter2 = [[NSNumberFormatter alloc] init];
    cell.commentL.text = [numberFormatter2 stringFromNumber:act.comments];
    
    
//    NSLog(@"%@",cell.commentL.text);
    
    [cell.thumbnailImg sd_setImageWithURL:[NSURL URLWithString:act.thumbnail]placeholderImage:[UIImage imageNamed:@"all1.jpg"]];

    cell.goodImg.image = [UIImage imageNamed:@"点赞1.png"];
    cell.talkImg.image = [UIImage imageNamed:@"评论1.png"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    return cell;
}

-(void)getData
{
    if (self.number == 0) {
        self.arr = [NSMutableArray array];
    }
    
    
    // 时间戳
        NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
        long long dTime = [[NSNumber numberWithDouble:timeInterval] longLongValue]; // 将double转为long long型
        NSString *tempTime = [NSString stringWithFormat:@"%llu",dTime]; // 输出long long型
//        NSLog(@"%@",tempTime);
    self.timeNow = tempTime;
    
    NSString *url = [NSString stringWithFormat:@"http://api.3g.ifeng.com/clientShortNews?type=beauty&Itime=%@&page=%ld&gv=5.0.0&av=0&proid=ifengnews&os=ios_9.1&vt=5&screen=640x1136&publishid=4002&uid=d164f40d9e7b43cab841ce7c774c12c4",self.timeNow,self.page];
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
        
        NSMutableArray *arr = [responseObject objectForKey:@"body"];
//        NSLog(@"%@",arr);
        for (NSMutableDictionary *temp in arr) {
            New_Cute_M *browse = [[New_Cute_M alloc] initWithDic:temp];
            [self.arr addObject:browse];
        }
        
        
        [self.tableV.mj_header endRefreshing];
        [self.tableV.mj_footer endRefreshing];
        [self.tableV reloadData];
        
    }
                        failure:^(NSURLSessionDataTask *task, NSError *error) {
                            
                        }];
}
































@end
