//
//  LXD_Head_Page.m
//  earthOL
//
//  Created by dllo on 16/1/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "Head-Page-V.h"

@implementation Head_Page_V

-(instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if(self){
        
        
        [self creatGuid];
        
    }
    
    return self;
}
+ (NSString *)getHomeDirectoryVersionNumber
{
    // 获取NSUserDefaults文件
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *VersionNumber = [userDefaults objectForKey:@"VersionNumber"];
    
    return VersionNumber;
}
+ (NSString *)getAtPresentVersionNumber
{
    // 项目版本号
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    return version;
}

#pragma mark - 存储当前版本号
+ (void)saveAtPresentVersionNumber:(NSString *)atPresentVersionNumber
{
    // 获取NSUserDefaults文件
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    // 向文件写入版本号
    [userDefaults setObject:atPresentVersionNumber forKey:@"VersionNumber"];
    // 立即同步内容
    [userDefaults synchronize];
}

-(void)creatGuid{
    
    // 背景图片
    NSArray *backgroundImage = @[@"尼采.jpg",@"拿破仑.jpg",@"曹操.jpg",@"黑格尔.jpg"];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    // 分页滚动
    self.scrollView.pagingEnabled = YES;
    // 滚动范围
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * backgroundImage.count, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    
    // 添加背景图片
    for (int i = 0; i < backgroundImage.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        imageView.image = [UIImage imageNamed:backgroundImage[i]];
        [self.scrollView addSubview:imageView];
    }
    
    // 分页控制器
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 25 * WIDTH, self.frame.size.height - 30 *HEIGHT, 50*WIDTH, 20*HEIGHT)];
    //    self.pageControl.backgroundColor = [UIColor blueColor];
    // 未选中点颜色
    self.page.pageIndicatorTintColor = [UIColor whiteColor];
    // 当前选中点颜色
    self.page.currentPageIndicatorTintColor = [UIColor grayColor];
    // 分页点数量
    self.page.numberOfPages = backgroundImage.count;
    [self addSubview:_page];
    
    // 进入按钮
    self.enter = [UIButton buttonWithType:UIButtonTypeCustom];
    self.enter.frame = CGRectMake(self.frame.size.width - 80*WIDTH, self.page.frame.origin.y - 35*HEIGHT, 70*WIDTH, 35*HEIGHT);
    [self.enter setTitle:@"跳过" forState:UIControlStateNormal];
    self.enter.layer.borderColor = [UIColor whiteColor].CGColor;
    self.enter.layer.borderWidth = 0.5;
    self.enter.layer.cornerRadius = 7;
    [self addSubview:_enter];
    
    
    
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
