//
//  New-163-VC.m
//  新闻
//
//  Created by dllo on 16/3/1.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "New-163-VC.h"
#import "New-163-M.h"
#import "New-163-V.h"
#import "MJRefresh.h"
#import "LXDAFNetTool.h"
#import "UIImageView+WebCache.h"

@interface New_163_VC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) UITableView    *tableV;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, assign) NSInteger      page;
@property (nonatomic, assign) NSInteger      number;
@property (nonatomic, copy  ) NSString       *timeNow;

@end




@implementation New_163_VC
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
    if (indexPath.row == 0) {
        return 160*HEIGHT;
    }else
    {
    return 180*HEIGHT;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    New_163_M *act = [self.arr objectAtIndex:indexPath.row];
    
    // 第一个 tableviewcell
    if (indexPath.row == 0) {
//        NSLog(@"%@",act.title);
        static NSString *cellStr = @"cell";
        New_163_V *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        
        if (nil == cell) {
            
            cell = [[New_163_V alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
        }
        [cell.imgsrcUpImg sd_setImageWithURL:[NSURL URLWithString:act.imgsrc]placeholderImage:[UIImage imageNamed:@"all2.jpg"]];
//        NSLog(@"%@",act.imgsrc);
        cell.titleUpL.text = act.title;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
        return cell;
        
    }
    // 其他的 tableviewcell
    else
    {
        static NSString *cellStr = @"celltopic";
        New_163_V *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        
        if (nil == cell) {
            
            cell = [[New_163_V alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
        }
        
        cell.titleL.text = act.title;
        [cell.imgsrcImg sd_setImageWithURL:[NSURL URLWithString:act.imgsrc]placeholderImage:[UIImage imageNamed:@"all2.jpg"]];
        cell.digestL.text = act.digest;
        NSNumberFormatter* numberFormatter1 = [[NSNumberFormatter alloc] init];
            cell.replyL.text = [numberFormatter1 stringFromNumber:act.replyCount];
        cell.talkImg.image = [UIImage imageNamed:@"讨论1.png"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
        return cell;
    }
    
    
    
//    NSNumberFormatter* numberFormatter1 = [[NSNumberFormatter alloc] init];
//    cell.likeL.text = [numberFormatter1 stringFromNumber:act.likes];
    
    
    
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
    
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/list/T1370583240249/%ld-20.html",self.page];
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
        NSString  *b= [url substringWithRange:NSMakeRange(35,14)];
//        NSLog(@"%@",b);
        NSMutableArray *arr = [responseObject objectForKey:b];
        for (NSMutableDictionary *temp in arr) {
            New_163_M *act = [[New_163_M alloc] initWithDic:temp];
//            act.imgsrc = [NSMutableArray array];
            [self.arr addObject:act];
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
    New_163_M *act = [self.arr objectAtIndex:indexPath.row];
    //    WebView_VC *wb = [[WebView_VC alloc]init];
    if (act.url != nil) {
        [self.delegate getchange:act.url];
    }
    
}



























@end
