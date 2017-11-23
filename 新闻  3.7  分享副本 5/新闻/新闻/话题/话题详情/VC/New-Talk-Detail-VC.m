//
//  New-Talk-Detail-VC.m
//  新闻
//
//  Created by dllo on 16/2/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "New-Talk-Detail-VC.h"
#import "MJRefresh.h"
#import "LXDAFNetTool.h"
#import "UIImageView+WebCache.h"
#import "New-Talk-Detail-C.h"
#import "New-Talk-Detail-M.h"
#import "DataBaseHandle.h"

@interface New_Talk_Detail_VC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) UITableView    *tableV;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, retain) NSMutableArray *arrUp;
@property (nonatomic, strong) NSMutableArray *arrDown;
@property (nonatomic, retain) NSMutableArray *arrCollec;
@property (nonatomic, assign) CGRect         frame;
@property (nonatomic, assign) CGRect         rectsize;

@property (nonatomic, assign) NSInteger      number;

@property (nonatomic, assign) BOOL           temp;

@end

@implementation New_Talk_Detail_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatView];
    [self tableHead];
    
    self.arrDown = [[NSMutableArray alloc]init];
    
}
-(void)creatView
{

    self.number = 0;
    self.page = 10;
    [self begin];
    [self refresh];

    
    // 右上角收藏键
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style: UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
}
-(void)refresh
{
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
        [self.tableV reloadData];
    }];
    [self.tableV.mj_header beginRefreshing];
    
    self.tableV.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
//        self.page = self.page+10;
        
        self.page = self.page + 10;
        self.number++;
        [self getDataDown];
        [self.tableV reloadData];
        
        
    }];
}

-(void)begin
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 49*HEIGHT) style:UITableViewStylePlain];
    //    self.tableV.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    self.tableV.separatorStyle = NO;
    [self.view addSubview:self.tableV];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrDown.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40 + self.frame.size.height;
    
}
////设置标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return  @" ";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *hotDic = self.arrDown[indexPath.section];
     static NSString *cellStr = @"celltopic";
    New_Talk_Detail_C *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    
    if (nil == cell) {
        
        cell = [[New_Talk_Detail_C alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
    }
    // 分区赋值
    if(indexPath.row == 0){
        
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:[[hotDic objectForKey:@"question"]objectForKey:@"userHeadPicUrl"]]placeholderImage:[UIImage imageNamed:@"all2.jpg"]];
        cell.contentLabel.text = [[hotDic objectForKey:@"question"]objectForKey:@"content"];
        self.frame = [[[hotDic objectForKey:@"question"]objectForKey:@"content"] boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 60, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName ] context:nil];
        cell.contentLabel.frame = CGRectMake(50*WIDTH, 15*HEIGHT, self.view.frame.size.width - 60*WIDTH, self.frame.size.height);
        cell.contentLabel.font = [UIFont systemFontOfSize:15];
        cell.contentLabel.numberOfLines = 0;
    }else{
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:[[hotDic objectForKey:@"answer"]objectForKey:@"specialistHeadPicUrl"]]placeholderImage:[UIImage imageNamed:@"all2.jpg"]];
        cell.contentLabel.text = [[hotDic objectForKey:@"answer"]objectForKey:@"content"];
        
        self.frame = [[[hotDic objectForKey:@"answer"]objectForKey:@"content"] boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 60, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName ] context:nil];
        cell.contentLabel.frame = CGRectMake(50*WIDTH, 15*HEIGHT, self.view.frame.size.width - 60*WIDTH, self.frame.size.height);
        cell.contentLabel.font = [UIFont systemFontOfSize:14];
        cell.contentLabel.numberOfLines = 0;
        
        
    }

    return cell;
}

-(void)getData
{
    if (self.number == 0) {
        self.arr = [NSMutableArray array];
        self.arrUp = [NSMutableArray array];
        self.arrDown = [NSMutableArray array];
    }
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/newstopic/qa/%@.html",self.exID];
//    NSLog(@"%@",self.exID);
    [LXDAFNetTool getNetWithURL:url body:nil headFile:nil responseStyle:LXDJSON success:^(NSURLSessionDataTask *task, id responseObject) {

        
        NSMutableDictionary *dic = [[responseObject objectForKey:@"data"] objectForKey:@"expert"];
//        NSLog(@"%@",dic);
        New_Talk_Detail_M *act = [[New_Talk_Detail_M alloc] initWithDic:dic];
        
        act.descrip = [dic objectForKey:@"description"];
//        NSLog(@"%@",act.descrip);
        
        // 头视图, 在请求数据的时候直接赋值了
        [self.picurlImg sd_setImageWithURL:[NSURL URLWithString:act.picurl]];
        self.aliasL.text = act.alias;
        //        cell.countL.text = act.concernCount;
        NSNumberFormatter* numberFormatter1 = [[NSNumberFormatter alloc] init];
        self.countL.text = [numberFormatter1 stringFromNumber:act.concernCount];
        

        [self.headImg sd_setImageWithURL:[NSURL URLWithString:act.headpicurl]];
        self.nameL.text = act.name;
        self.titleL.text = act.title;
        self.descripL.text = act.descrip;
        
        self.rectsize = [act.descrip boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 60, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName ] context:nil];
        
        [self.arrUp addObject:act];
        
//        self.arrDown = [[responseObject objectForKey:@"data"]objectForKey:@"hotList"];
//        NSLog(@"%@",[[responseObject objectForKey:@"data"]objectForKey:@"hotList"]);
        
        
        for (NSMutableDictionary *temp in [[responseObject objectForKey:@"data"]objectForKey:@"hotList"]) {
            [self.arrDown addObject:temp];
        }
        
        
        [self.tableV.mj_header endRefreshing];
        [self.tableV reloadData];
        
    }
                        failure:^(NSURLSessionDataTask *task, NSError *error) {
                            
                        }];
}

// 收藏
-(void)rightAction
{
    self.temp = NO;

    // 打开数据库
    [[DataBaseHandle shareDataBase] openDB];
    self.arrCollec = [NSMutableArray array];
    self.arrCollec = [[DataBaseHandle shareDataBase] selectAllStudent];
//    NSLog(@"%@",self.arrCollec);

    for (int i = 0; i < self.arrCollec.count; i++) {
        New_Talk_Detail_M *act = [self.arrCollec objectAtIndex:i];

        if ([act.expertId isEqualToString:self.exID]) {
            
            self.temp = YES;

        }
    }
    
    
    
    if (NO == self.temp) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"收藏成功" message:@"恭喜你,收藏成功啦" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        // 输出数据库位置
            NSLog(@"%@",NSHomeDirectory());
        // 创建表单
        [[DataBaseHandle shareDataBase] createTable];
        
        New_Talk_Detail_M *act = [self.arrUp objectAtIndex:0];
        
        // 插入数据
        New_Talk_Detail_M *au1 = [[New_Talk_Detail_M alloc] init];
        
//        NSLog(@"%@",act.expertId);
        au1.expertId = act.expertId;
        au1.alias = act.alias;
        au1.headpicurl = act.headpicurl;
        
        [[DataBaseHandle shareDataBase] insertDataWithHuman:au1];
    } else {
        
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"收藏失败" message:@"收藏重复了" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
            }]];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
        }
    }
}

-(void)tableHead
{
    self.backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 380*HEIGHT)];
    self.tableV.tableHeaderView = _backView;
    
    [self upData];
    [self downData];
}

-(void)upData
{
    self.picurlImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 210*HEIGHT)];
    [self.backView addSubview:self.picurlImg];
    
    self.aliasL = [[UILabel alloc] initWithFrame:CGRectMake(40*WIDTH, 65*HEIGHT, self.view.bounds.size.width - 80*WIDTH, 40*HEIGHT)];
    self.aliasL.font = [UIFont systemFontOfSize:16];
    self.aliasL.numberOfLines = 0;
    self.aliasL.textColor = [UIColor whiteColor];
    self.aliasL.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:self.aliasL];
    
    self.countL = [[UILabel alloc] initWithFrame:CGRectMake(0, 115*HEIGHT, self.view.bounds.size.width, 20*HEIGHT)];
    self.countL.font = [UIFont systemFontOfSize:15];
    self.countL.textColor = [UIColor whiteColor];
    self.countL.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:self.countL];
    
//    self.collecB = [UIButton buttonWithType:UIButtonTypeCustom];
//    //    Button.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);
//    self.collecB.frame = CGRectMake(self.view.bounds.size.width/2 - 30, 145, 60, 20);
//    self.collecB.backgroundColor = [UIColor redColor];
//    [self.collecB setTitle:@"+ 关注" forState:UIControlStateNormal];
//    [self.collecB addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.backView addSubview:self.collecB];
    
}

-(void)downData
{
    self.headImg = [[UIImageView alloc] init];
    self.headImg.layer.cornerRadius = 20;
    self.headImg.frame = CGRectMake(20*WIDTH, 230*HEIGHT, 40*WIDTH, 40*HEIGHT);
    [self.backView addSubview:self.headImg];
    
    self.nameL = [[UILabel alloc] init];
    self.nameL.font = [UIFont systemFontOfSize:12];
    self.nameL.textColor = [UIColor grayColor];
    self.nameL.textAlignment = NSTextAlignmentRight;
    self.nameL.frame = CGRectMake(70*WIDTH, 230*HEIGHT, 40*WIDTH, 20*HEIGHT);
    [self.backView addSubview:self.nameL];
    
    self.titleL = [[UILabel alloc] init];
    self.titleL.font = [UIFont systemFontOfSize:12];
    self.titleL.textColor = [UIColor grayColor];
    self.titleL.textAlignment = NSTextAlignmentLeft;
    self.titleL.frame = CGRectMake(120*WIDTH, 230*HEIGHT, self.view.bounds.size.width - 150*WIDTH, 20*HEIGHT);
    [self.backView addSubview:self.titleL];
    
    self.descripL = [[UILabel alloc]initWithFrame:CGRectMake(70*WIDTH, 250*HEIGHT , self.view.frame.size.width - 90*WIDTH, 150*HEIGHT)];
    self.descripL.font = [UIFont boldSystemFontOfSize:14];
    self.descripL.numberOfLines = 15;
    self.descripL.textColor = [UIColor lightGrayColor];
    [self.backView addSubview:self.descripL];
}

-(void)getDataDown
{

    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/newstopic/list/hotqa/%@/%ld-10.html",self.exID,self.page];
    //    NSLog(@"%@",self.exID);
//    NSLog(@"%@",url);
    [LXDAFNetTool getNetWithURL:url body:nil headFile:nil responseStyle:LXDJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        
        //        NSLog(@"%@",act.descrip);
        
        
//        self.arrDown =[responseObject objectForKey:@"data"];
        
        for (NSMutableDictionary *temp in responseObject[@"data"]) {
//            NSLog(@"%@",temp);
//            NSUInteger i = 10;
            [self.arrDown addObject:temp];
            
//            i++;
        }
//        NSMutableArray *newsearchRecordArray = [NSMutableArray arrayWithArray:responseObject[@"data"]];
//        [self.arrDown addObjectsFromArray:newsearchRecordArray];
//        NSLog(@"%ld",self.arrDown.count);
        
//        [self.tableV.mj_header endRefreshing];
        [self.tableV.mj_footer endRefreshing];
        [self.tableV reloadData];
        
    }
                        failure:^(NSURLSessionDataTask *task, NSError *error) {
                            
                        }];

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
