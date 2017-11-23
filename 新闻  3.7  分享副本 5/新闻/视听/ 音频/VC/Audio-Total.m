//
//  Audio-Total.m
//  新闻
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "Audio-Total.h"
#import "MJRefresh.h"
#import "LXDAFNetTool.h"
#import "UIImageView+WebCache.h"
#import "Audio-Total-m.h"
#import "Audio-Total-V.h"

@interface Audio_Total () <UITableViewDelegate, UITableViewDataSource,moreDelgate>
//@property (nonatomic, retain) UITableView    *tableV;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, retain) NSMutableArray *arrLunBo;
@property (nonatomic, assign) NSInteger      number;
@property (nonatomic, retain) NSMutableArray *arr2;

//@property (nonatomic, retain) NSMutableArray *arrTitle;




@end


@implementation Audio_Total
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
    //    self.page = 1;
    //    NSLog(@"%@",self.page);
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
}

-(void)begin
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 20*HEIGHT, self.bounds.size.width, self.bounds.size.height - 69*HEIGHT) style:UITableViewStylePlain];
    //    self.tableV.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    self.tableV.separatorStyle = NO;
    [self addSubview:self.tableV];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arr count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    Audio_Total_m *act = [self.arr objectAtIndex:indexPath.row];
    return 220*HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Audio_Total_m *act = [self.arr objectAtIndex:indexPath.row];
    //    Audio_Total_m *act2 = [self.arr2 objectAtIndex:indexPath.row];
    static NSString *cellStr = @"cell";
    Audio_Total_V *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    
    if (nil == cell) {
        
        cell = [[Audio_Total_V alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
    }
    
    //    NSLog(@"now%@",act.cardTitle);
    cell.cardTitleL.text = act.cardTitle;
    //    NSLog(@"%ld",self.arr.count);
//    Audio_Total_V *audio = [[Audio_Total_V alloc] init];
//    cell.arr = [NSMutableArray array];
//    NSLog(@"%@",act.cardDetails);
    cell.arr = act.cardDetails;
//    NSLog(@"%@",cell.arr);
    cell.netId.text = act.nodeId;
    
    cell.delegate = self;
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    return cell;
}

-(void)getData
{
    if (self.number == 0) {
        self.arr = [NSMutableArray array];
        self.arrLunBo = [NSMutableArray array];
        self.arr2 = [NSMutableArray array];
        
        //        self.arrTitle = [NSMutableArray array];
    }
    NSString *url = [NSString stringWithFormat:@"http://api.3g.ifeng.com/api_fm_homepage?gv=5.0.0&av=0&proid=ifengnews&os=ios_9.1&vt=5&screen=640x1136&publishid=4002&uid=d164f40d9e7b43cab841ce7c774c12c4"];
    [LXDAFNetTool getNetWithURL:url body:nil headFile:nil responseStyle:LXDJSON success:^(NSURLSessionDataTask *task, id responseObject) {

        // 轮播图  请求数据
        NSMutableArray *arrLunBo = [[responseObject objectForKey:@"data"] objectForKey:@"focus"];
        for (NSMutableDictionary *lunboDic in arrLunBo) {
            Audio_Total_m *browse = [[Audio_Total_m alloc] initWithDic:lunboDic];
            [self.arrLunBo addObject:browse];
        }
        
        // 正常  请求数据
        NSMutableArray *arr = [[responseObject objectForKey:@"data"] objectForKey:@"cardList"];
        for (NSMutableDictionary *temp in arr) {
            Audio_Total_m *data = [[Audio_Total_m alloc] initWithDic:temp];
            
//            data.cardDetails = [NSMutableArray array];
//            data.cardDetails = [temp objectForKey:@"cardDetails"];

            NSMutableArray *arrB = [temp objectForKey:@"cardDetails"];
            for (NSMutableDictionary *tempDicD in arrB) {
                Audio_Total_m *model = [[Audio_Total_m alloc]initWithDic:tempDicD];
//                NSLog(@"%@",model.title);
                model.songId = tempDicD[@"id"];
//                NSLog(@"%@",model.songId);
                [model.cardDetails addObject:model];
            }
//                        NSLog(@"net%@",data.nodeId);
            [self.arr addObject:data];
        }
        
        
        
        
        [self.tableV.mj_header endRefreshing];
        [self.tableV reloadData];
        
    }
                        failure:^(NSURLSessionDataTask *task, NSError *error) {
                            
                        }];
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    Audio_Total_m *act = [self.arr objectAtIndex:indexPath.row];
//
//    Audio_Total_V *browse = [[Audio_Total_V alloc] init];
//    browse.arr = [NSMutableArray array];
//    [browse.arr addObject:act.title];
//    
//    
//}

-(void)getchangemore:(NSString *)more
{
//    Audio_More_VC *detail = [[Audio_More_VC alloc] init];
    self.moreMiddle = more;
//    [self.navigationController pushViewController:detail animated:YES];
    
//    NSLog(@"%@",self.moreMiddle);
    
    [self.delegate getchangemoreMiddle:self.moreMiddle];
}

-(void)getchangedetail:(NSString *)detail
{
    self.idMiddle = detail;
//    NSLog(@"%@",self.idMiddle);
    [self.delegate getchangeIdMiddle:self.idMiddle];
}















































@end
