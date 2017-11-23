//
//  Mine-Main-VC.m
//  新闻
//
//  Created by dllo on 16/3/2.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "Mine-Main-VC.h"
#import "Mine-Collect-VC.h"
#import "UIImageView+WebCache.h"

// 自定义 Cell
#import "Mine-Night-C.h"
#import "Mine-Collect-C.h"
#import "Mine-Clear-C.h"
#import "Mine-Contact-C.h"
#import "Mine-Share-C.h"
#import "UMSocial.h"

@interface Mine_Main_VC ()<UITableViewDelegate, UITableViewDataSource,UMSocialUIDelegate>

@property (nonatomic,retain)UITableView *tableV;
@property(nonatomic,retain) UIImageView *imageView;
@end

@implementation Mine_Main_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    
    self.tableV = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    _tableV.separatorStyle = NO;
    [self.view addSubview:self.tableV];
    
    self.tableV.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"放大背景2.jpg"]];
    //将imageView放在最下面
    [self.tableV insertSubview:self.imageView atIndex:0];
    self.imageView.frame = CGRectMake(0, -400, self.view.frame.size.width, 400);
    //保持图片原来的比例进行缩放
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    <#类名#> *act = [<#储存数据的数组#> objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
    static NSString *cellStr = @"cellCollect";
    Mine_Collect_C *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    
    if (nil == cell) {
        
        cell = [[Mine_Collect_C alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
    }
//    cell.textLabel.text = @"我的收藏";
        cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    return cell;
    }
    else if(indexPath.row == 1)
    {
        static NSString *cellStr = @"cellCollect";
        Mine_Clear_C *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        
        if (nil == cell) {
            
            cell = [[Mine_Clear_C alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
        }
//        cell.textLabel.text = @"清除缓存";
        cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
        return cell;
    }
    else if(indexPath.row == 2)
    {
        static NSString *cellStr = @"cellNight";
        Mine_Night_C *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        
        if (nil == cell) {
            cell = [[Mine_Night_C alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
        return cell;
    }
    else if(indexPath.row == 3)
    {
        static NSString *cellStr = @"cellColltact";
        Mine_Contact_C *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (nil == cell) {
            cell = [[Mine_Contact_C alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
        return cell;
    }
    else
    {
        static NSString *cellStr = @"cellShare";
        Mine_Share_C *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (nil == cell) {
            cell = [[Mine_Share_C alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 我的收藏, 进入收藏界面
    if (indexPath.row == 0) {
        Mine_Collect_VC *collect = [[Mine_Collect_VC alloc] init];
    [self.navigationController pushViewController:collect animated:YES];
    }
    // 清除缓存
    if (indexPath.row == 1) {
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        
        if (0 == [self folderSizeAtPath:path]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"当前无缓存" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self clearCache:path];
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
                
            }]];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
        } else {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"总的缓存大小为%.2fMB, 你确定要删除吗?", [self folderSizeAtPath:path]] preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self clearCache:path];
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
                
            }]];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
        }

    }
    // 分享
    if (indexPath.row == 4) {
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"507fcab25270157b37000010"
                                          shareText:@"你要分享的文字"
                                         shareImage:[UIImage imageNamed:@"icon.png"]
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToEmail,UMShareToSms,UMShareToDouban,nil]
                                           delegate:self];
    }
    // 联系我们
    if (indexPath.row == 3) {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"东哥欢迎你的加入" message:@"支付宝13889410292,加盟费五十万,欢迎加盟" preferredStyle:UIAlertControllerStyleAlert];
//        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"mailto://836427388@qq.com"]];
//        }]];
//        [self presentViewController:alert animated:YES completion:^{
//            
//        }];
        NSString *title = NSLocalizedString(@"东哥欢迎你的加入", nil);
        NSString *message = NSLocalizedString(@"支付宝13889410292,加盟费五十万,欢迎加盟.", nil);
        NSString *cancelButtonTitle = NSLocalizedString(@"Cancel", nil);
        NSString *otherButtonTitle = NSLocalizedString(@"OK", nil);
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        // Create the actions.
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//            NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
        }];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            NSLog(@"The \"Okay/Cancel\" alert's other action occured.");
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"mailto://836427388@qq.com"]];
        }];
        
        // Add the actions.
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //在视图将要出现的时候,创建NC上的导航按钮
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.400 green:0.800 blue:1.000 alpha:1.000];
    
}

// 下拉的方法, 继承于 scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat down = -200 - scrollView.contentOffset.y;
    //    NSLog(@"向下移动了%.2f",down);
    if (down < 0) {
        return;
    }
    //取出imageView的frame
    CGRect frame = self.imageView.frame;
    frame.size.height = 400 + down * 5;
    self.imageView.frame = frame;
}





































//单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
    
}
//遍历文件夹获得文件夹大小，返回多少M
- (float) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath] ;
    }
    return folderSize/(1024.0*1024.0) + [[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
}

- (void)clearCache:(NSString *)path {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
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
