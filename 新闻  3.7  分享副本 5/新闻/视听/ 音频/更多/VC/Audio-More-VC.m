//
//  Audio-More-VC.m
//  新闻
//
//  Created by dllo on 16/3/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "Audio-More-VC.h"
#import "MJRefresh.h"
#import "LXDAFNetTool.h"
#import "UIImageView+WebCache.h"
#import "Audio-More-M.h"
#import "Audio-More-V.h"
#import "Audio-Detail-VC.h"
#import "Audio-Tools.h"


@interface Audio_More_VC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) UITableView *tableV;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, assign) NSInteger      page;
@property (nonatomic, assign) NSInteger      number;
@property (nonatomic, retain) Audio_Tools *tool;
@end

@implementation Audio_More_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSLog(@"%@",self.moreId);
    
    self.page = 1;
    self.number = 0;
    [self begin];
    [self refresh];
    
    self.tool = [[Audio_Tools alloc] init];
    
}

-(void)begin
{
    self.tableV = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
}


-(void)refresh
{
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
        [self.tableV reloadData];
    }];
    [self.tableV.mj_header beginRefreshing];
    
    self.tableV.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.page ++;
        self.number++;
        [self getData];
        [self.tableV reloadData];
    }];
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arr count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100*HEIGHT;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Audio_More_M *act = [self.arr objectAtIndex:indexPath.row];
    
    
    
    static NSString *cellStr = @"celltopic";
    Audio_More_V *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    
    if (nil == cell) {
        
        cell = [[Audio_More_V alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
    }
    
    
    
//    NSNumberFormatter* numberFormatter1 = [[NSNumberFormatter alloc] init];
//    cell.likeL.text = [numberFormatter1 stringFromNumber:act.likes];
    
    [cell.proImg sd_setImageWithURL:[NSURL URLWithString:act.programImg]];
    
    cell.proNameL.text = act.programName;
    cell.proDetL.text = act.programDetails;
    
    return cell;
}

-(void)getData
{
    if (self.number == 0) {
        self.arr = [NSMutableArray array];
    }
    
    
    // 时间戳
//    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
//    long long dTime = [[NSNumber numberWithDouble:timeInterval] longLongValue]; // 将double转为long long型
//    NSString *tempTime = [NSString stringWithFormat:@"%llu",dTime]; // 输出long long型
    //        NSLog(@"%@",tempTime);
    
    
    NSString *url = [NSString stringWithFormat:@"http://api.3g.ifeng.com/api_fm_programlist?nodeId=%@&page=%ld&pageSize=20&gv=5.0.0&av=0&proid=ifengnews&os=ios_9.1&vt=5&screen=640x1136&publishid=4002&uid=d164f40d9e7b43cab841ce7c774c12c4",self.moreId,self.page];
//    NSLog(@"%@",url);
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
        
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor blackColor]}];
        
        
        self.navigationItem.title = responseObject[@"data"][@"nodeName"];
        
        
        
        
        NSMutableArray *arr = responseObject[@"data"][@"programList"];
//        NSLog(@"%@",arr);
        
        for (NSMutableDictionary *temp in arr) {
            Audio_More_M *browse = [[Audio_More_M alloc] initWithDic:temp];
//            NSLog(@"%@",browse.resourceId);
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
//    Audio_Detail_VC *detail = [[Audio_Detail_VC alloc] init];
    Audio_More_M *act = [self.arr objectAtIndex:indexPath.row];
    self.tool.detail.idTotal = act.resourceId;
    [self.navigationController pushViewController:self.tool.detail animated:YES];
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
