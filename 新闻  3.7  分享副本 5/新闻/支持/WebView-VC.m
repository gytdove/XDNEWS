//
//  WebView-VC.m
//  新闻
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "WebView-VC.h"
#import "Audio-Tools.h"


@interface WebView_VC ()<UIWebViewDelegate>
@property (nonatomic, retain) UIWebView *web;
//小菊花转转
@property (nonatomic, retain)  UIActivityIndicatorView *actIndicatorV ;
@property (nonatomic, retain) Audio_Tools *tools;

@end

@implementation WebView_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tools = [[Audio_Tools alloc] init];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    
    self.web = [[UIWebView alloc] initWithFrame:CGRectMake(2, 2, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    
    //签代理
    self.web.delegate = self;
    
    
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.view addSubview:self.web];
    [self.web loadRequest:request];
    
    
    
    
    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //在视图将要出现的时候,创建NC上的导航按钮

    _tools.GoSongView.alpha = 0;
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //当视图即将消失的时候把装有导航按钮的视图删掉
    //    [_tool.GoSongView setHidden:NO];
    //    [self stopAction];
  _tools.GoSongView.alpha = 1;
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
