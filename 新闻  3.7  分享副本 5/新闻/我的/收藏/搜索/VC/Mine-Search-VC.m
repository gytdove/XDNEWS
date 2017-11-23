//
//  Mine-Search-VC.m
//  新闻
//
//  Created by dllo on 16/3/2.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "Mine-Search-VC.h"
#import "DataBaseHandle.h"
#import "New-Talk-Detail-M.h"
#import "Mine-Collect-V.h"
#import "New-Talk-Detail-VC.h"
#import "LXDAFNetTool.h"
#import "UIImageView+WebCache.h"

@interface Mine_Search_VC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, retain)UITableView *tableV;
@property(nonatomic, retain)NSMutableArray *arr;
@property(nonatomic, retain)NSMutableArray *arr2;
@property(nonatomic, retain)UIImageView *backImg;
@end

@implementation Mine_Search_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getData];
    [self creat];
    self.tableV = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
    
    if (self.arr.count == 0) {
        self.backImg = [[UIImageView alloc] initWithFrame:self.view.frame];
        self.backImg.image = [UIImage imageNamed:@"萝莉1.jpg"];
        [self.view addSubview:self.backImg];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-100, 50, 200, 50)];
        label.text = @"没有搜索到";
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        label.font = [UIFont fontWithName:@"Palatino" size:24];
        label.textAlignment = NSTextAlignmentCenter;
        //        label.font = [UIFont systemFontOfSize:18];
        [self.view addSubview:label];

    }
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.backImg removeFromSuperview];
}

-(void)getData
{
    //    // 遍历数据库
    //    [[DataBaseHandle shareDataBase] openDB];
    //
    //    //    Human *hum = [[Human alloc] init];
    //    self.arr = [NSMutableArray array];
    //    self.arr = [[DataBaseHandle shareDataBase] selectAllStudent];
    //    //    NSLog(@"%@",self.arr);
    //    [self.tableV reloadData];
    
    // 赋值
    self.arr = [[DataBaseHandle shareDataBase] selectStudentWithalias:self.search];
    
    
    [self.tableV reloadData];
}

-(void)creat
{
    [[DataBaseHandle shareDataBase] openDB];
    self.arr2 = [NSMutableArray array];
    
}

-(void)tapAction:(UITapGestureRecognizer *)sender
{
    [self.tableV resignFirstResponder];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arr count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100*HEIGHT;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    New_Talk_Detail_M *act = [self.arr objectAtIndex:indexPath.row];
    static NSString *cellStr = @"cellSubject";
    Mine_Collect_V *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    
    if (nil == cell) {
        
        cell = [[Mine_Collect_V alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
    }
    
    
    
    
    
    // 关键字高亮
    NSRange range = [act.alias rangeOfString:self.search];
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc]initWithString:act.alias];
    [attributed addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:26.0] range:range];
    [attributed addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.150 green:0.752 blue:1.000 alpha:1.000] range:range];
    
    
    
    [cell.headImg sd_setImageWithURL:[NSURL URLWithString:act.headpicurl]];
//    cell.aliasL.text = act.alias;
    
  cell.aliasL.attributedText = attributed;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    New_Talk_Detail_M *act = [self.arr objectAtIndex:indexPath.row];
    New_Talk_Detail_VC *author = [[New_Talk_Detail_VC alloc] init];

    author.exID = act.expertId;
    [self.navigationController pushViewController:author animated:YES];
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
