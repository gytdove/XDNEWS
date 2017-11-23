//
//  New-Talk-VC.m
//  新闻
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "New-Talk-VC.h"
#import "MJRefresh.h"
#import "LXDAFNetTool.h"
#import "UIImageView+WebCache.h"
#import "New-Talk-C.h"
#import "New-Talk-M.h"
#import "New-Talk-Detail-VC.h"
#import "New-Talk-Detail-VC.h"

@interface New_Talk_VC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) UITableView    *tableV;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, assign) NSInteger      page;
@property (nonatomic, assign) NSInteger      number;


@end

@implementation New_Talk_VC
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
    
        return 320*HEIGHT;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    New_Talk_M *Model = [self.arr objectAtIndex:indexPath.row];
    
    [self.delegate getchange1:Model.expertId];
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    New_Talk_M *act = [self.arr objectAtIndex:indexPath.row];
    
    
    
    static NSString *cellStr = @"celltopic";
    New_Talk_C *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    
    if (nil == cell) {
        
        cell = [[New_Talk_C alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
    }
    // 自定义 cell 的上半部分, 包括图片等等
    [cell.imagePicurl sd_setImageWithURL:[NSURL URLWithString:act.picurl]placeholderImage:[UIImage imageNamed:@"all2.jpg"]];
    [cell.imageHeadpicurl sd_setImageWithURL:[NSURL URLWithString:act.headpicurl]placeholderImage:[UIImage imageNamed:@"head2.jpg"]];
    cell.labelName.text = act.name;
    cell.labelTitle.text = act.title;
    
    // 自定义 cell 的下半部分
    cell.labelAlias.text = act.alias;
    
    cell.labelClassification.text = act.classification;
    
    cell.imageAttention.image = [UIImage imageNamed:@"关注1.png"];
    cell.imageQuestion.image = [UIImage imageNamed:@"提问1.png"];
    
    NSNumberFormatter* numberFormatter1 = [[NSNumberFormatter alloc] init];
    cell.labelConcernCount.text = [numberFormatter1 stringFromNumber:act.concernCount];
    
    NSNumberFormatter* numberFormatter2 = [[NSNumberFormatter alloc] init];
    cell.labelQuestionCount.text = [numberFormatter2 stringFromNumber:act.questionCount];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    return cell;
}

-(void)getData
{
    if (self.number == 0) {
        self.arr = [NSMutableArray array];
    }
    
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/newstopic/list/expert/%ld-10.html",self.page];
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
        NSMutableArray *arr = [[responseObject objectForKey:@"data"] objectForKey:@"expertList"];
        for (NSMutableDictionary *temp in arr) {
            New_Talk_M *browse = [[New_Talk_M alloc] initWithDic:temp];
            [self.arr addObject:browse];
        }
        
//        NSLog(@"%@",self.arr);
        
        
        [self.tableV.mj_header endRefreshing];
        [self.tableV.mj_footer endRefreshing];
        [self.tableV reloadData];
        
    }
                        failure:^(NSURLSessionDataTask *task, NSError *error) {
                            
                        }];
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    New_Talk_Detail_VC *detail = [[New_Talk_Detail_VC alloc] init];
//    New_Talk_M *act = [self.arr objectAtIndex:indexPath.row];
//    detail.page = act.expertId;
////    NSLog(@"%@",detail.page);
////    [self presentModalViewController:detail animated:YES];
//    
//}






































@end
