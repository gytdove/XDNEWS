//
//  Mine-Collect-VC.m
//  新闻
//
//  Created by dllo on 16/3/2.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "Mine-Collect-VC.h"
#import "New-Talk-Detail-M.h"
#import "DataBaseHandle.h"
#import "LXDAFNetTool.h"
#import "UIImageView+WebCache.h"
#import "Mine-Collect-V.h"
#import "Mine-Collect-M.h"
#import "New-Talk-Detail-VC.h"
#import "Mine-Search-VC.h"

@interface Mine_Collect_VC ()<UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic, retain) UITableView    *tableV;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, retain) UISearchBar    *searchB;
@property(nonatomic, retain)UIImageView *backImg;

@end

@implementation Mine_Collect_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.arr = [NSMutableArray array];
    
    self.tableV = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.separatorStyle = NO;
    [self.view addSubview:self.tableV];
    
    [[DataBaseHandle shareDataBase] openDB];
    self.arr = [NSMutableArray array];
    self.arr = [[DataBaseHandle shareDataBase] selectAllStudent];
//    NSLog(@"%@",self.arr);
    
    if (self.arr.count == 0) {
        self.backImg = [[UIImageView alloc] initWithFrame:self.view.frame];
        self.backImg.image = [UIImage imageNamed:@"萝莉2.jpg"];
        [self.view addSubview:self.backImg];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-100, 50, 200, 50)];
        label.text = @"没有收藏";
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        label.font = [UIFont fontWithName:@"Palatino" size:24];
        label.textAlignment = NSTextAlignmentCenter;
//        label.font = [UIFont systemFontOfSize:18];
        [self.view addSubview:label];
    }
    
    [self searchid];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    <#类名#> *act = [<#储存数据的数组#> objectAtIndex:indexPath.row];
    
    New_Talk_Detail_M *act = [self.arr objectAtIndex:indexPath.row];
    
    
    static NSString *cellStr = @"cellSubject";
    Mine_Collect_V *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    
    if (nil == cell) {
        
        cell = [[Mine_Collect_V alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
    }
    
    
//    NSLog(@"%@",act.expertId);
    
    [cell.headImg sd_setImageWithURL:[NSURL URLWithString:act.headpicurl]];
    cell.aliasL.text = act.alias;
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100*HEIGHT;
}

// 删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[DataBaseHandle shareDataBase] openDB];
    //    self.arrDele = [NSMutableArray array];
    //    self.arrDele = [[DataBaseHandle shareDataBase] selectAllStudent];
    New_Talk_Detail_M *act = [self.arr objectAtIndex:indexPath.row];
    
    
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        [self.arr removeObjectAtIndex:indexPath.row];
        
        
        [[DataBaseHandle shareDataBase] deleteDataWithData:act.expertId];
    }
    
    
    
    [self.tableV reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    New_Talk_Detail_M *act = [self.arr objectAtIndex:indexPath.row];
    New_Talk_Detail_VC *detail = [[New_Talk_Detail_VC alloc] init];
    
    //    NSLog(@"%@",author.act.author_id);
    //    NSLog(@"%@",act.user_type);
    detail.exID = act.expertId;
//    NSLog(@"%@",detail.exID);
    [self.navigationController pushViewController:detail animated:YES];
}


-(void)searchid
{
    self.searchB = [[UISearchBar alloc] initWithFrame:CGRectMake(80, 0, 200, 50)];
    self.searchB.placeholder = @"请输入要搜索的人";
    self.searchB.showsCancelButton = NO;
    self.searchB.delegate = self;
    
    UIBarButtonItem *searchName = [[UIBarButtonItem alloc] initWithCustomView:self.searchB];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObject:searchName];
    
}

// 点击后的方法
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //    LXD_TOTAL_Collec2_VC *search = [[LXD_TOTAL_Collec2_VC alloc] init];
    ////    search.search = self.searchB.text;
    //    [self.navigationController pushViewController:search animated:YES];
    //    [search release];
}



-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    Mine_Search_VC *search = [[Mine_Search_VC alloc] init];
    search.search = self.searchB.text;
    [self.navigationController pushViewController:search animated:YES];
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
