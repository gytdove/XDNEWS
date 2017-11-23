//
//  AppDelegate.m
//  新闻
//
//  Created by dllo on 16/2/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "AppDelegate.h"
#import "New-Total-VC.h"
//#import "Read-Total-VC.h"
#import "Audio-Visual-Total-VC.h"
#import "Mine-Main-VC.h"
#import "Audio-Tools.h"
#import "Audio-Detail-VC.h"
#import "UMSocial.h"

#import "Head-Page-V.h"
#import "Head-Page-VC.h"


@interface AppDelegate ()<UITabBarControllerDelegate,UIScrollViewDelegate>

@property (nonatomic, retain) Audio_Tools *tool;
@property (nonatomic, retain) UINavigationController *currentNav;

@property (nonatomic, retain)Head_Page_VC *guid;
@property (nonatomic, retain)Head_Page_V *guidePage;

@end

@implementation AppDelegate

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self pageAction];
    
    
    
    return YES;
}

-(void)begin
{
    [self tableBarAction];
    
    _tool = [[Audio_Tools alloc] init];
    [self viewAction];
    
    // 通知 夜间模式
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alpha:) name:@"night" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alpha:) name:@"day" object:nil];
    
    // 友盟 SDK
    [UMSocialData setAppKey:@"507fcab25270157b37000010"];
}





-(void)alpha:(NSNotification *)noti{
    NSString *alpha = noti.userInfo[@"alpha"];
    
    float al = [alpha floatValue];
    
    self.window.alpha = al;
    //移除通知
    //    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"night" object:nil];
    
}



-(void)viewAction
{
    self.tool.GoSongView.frame = CGRectMake(0, 100, 20, 20);
    self.tool.GoSongView.hidden = YES;
//    self.tool.GoSongView.backgroundColor = [UIColor redColor];
    UIWindow* windows = [UIApplication sharedApplication].windows.lastObject;
    [windows addSubview:self.tool.GoSongView];
//    NSLog(@"-------======");
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, 20, 20)];
    imageView.image = [UIImage imageNamed:@"正在播放.png"];
    [self.tool.GoSongView addSubview:imageView];
    
    
    
    // 平移
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.tool.GoSongView addGestureRecognizer:panGR];
    
    
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    Button.frame = CGRectMake(0, 0, 20, 20);
//    Button.backgroundColor = [UIColor greenColor];
//    [Button setTitle:@"<#Button Title#>" forState:UIControlStateNormal];
    [Button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.tool.GoSongView addSubview:Button];

}


-(void)panAction:(UIPanGestureRecognizer *)sender
{
//    NSLog(@"平移手势");
    // 相对于触摸点的坐标
    //CGPoint point = [sender translationInView:self.view];
    // 相对于画板的坐标
//    CGPoint point = [sender locationInView:self.window];
    CGPoint p = [sender translationInView:self.tool.GoSongView];
//    NSLog(@"%f %f", p.x, p.y);
    
//    self.view.backgroundColor = [UIColor colorWithRed:point.x / 255.0 green:point.y / 255.0 blue:(point.x + point.y) / 255.0 alpha:1.0];
//    _view.frame = CGRectMake(0+point.x, 100+point.y, 20, 20);
    
    
    self.tool.GoSongView.transform = CGAffineTransformTranslate(self.tool.GoSongView.transform, p.x, p.y);
    [sender setTranslation:CGPointZero inView:self.tool.GoSongView];
}



-(void)tableBarAction
{
    New_Total_VC *newVC = [[New_Total_VC alloc] init];
    UINavigationController *newNC = [[UINavigationController alloc] initWithRootViewController:newVC];
    newNC.navigationBar.translucent = NO;
    newNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"新闻" image:[UIImage imageNamed:@"新闻2.png"] tag:10001];
//    UIImage *newVA = [UIImage imageNamed:@"新闻.png"];
//    newVA = [newVA imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [newNC.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
//    Read_Total_VC *readVC = [[Read_Total_VC alloc] init];
//    UINavigationController *readNC = [[UINavigationController alloc] initWithRootViewController:readVC];
//    readNC.navigationBar.translucent = NO;
//    readNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"阅读" image:nil tag:10002];
//    [readNC.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    Audio_Visual_Total_VC *audioVC = [[Audio_Visual_Total_VC alloc] init];
    UINavigationController *audioNC = [[UINavigationController alloc] initWithRootViewController:audioVC];
    audioNC.navigationBar.translucent = NO;
    audioNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"视听" image:[UIImage imageNamed:@"视听2.png"] tag:10003];
    [audioNC.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    Mine_Main_VC *mineVC = [[Mine_Main_VC alloc] init];
    UINavigationController *mineNC = [[UINavigationController alloc] initWithRootViewController:mineVC];
    mineNC.navigationBar.translucent = NO;
    mineNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"我的2.png"] tag:10004];
    [mineNC.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UITabBarController *tabBC = [[UITabBarController alloc] init];
    tabBC.viewControllers = [NSArray arrayWithObjects:newNC,audioNC,mineNC,nil];
    tabBC.delegate = self;
    
    self.window.rootViewController = tabBC;
}

-(void)buttonAction
{
    
  
        
//        UINavigationController *secondNa = self.window.rootViewController.childViewControllers[2];
//        [secondNa pushViewController:self.tool.detail animated:YES];
  
    
    [_currentNav pushViewController:self.tool.detail animated:YES];
    

    
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
//    NSLog(@"%@", viewController);
    _currentNav = (UINavigationController *)viewController;
    
}


-(void)pageAction
{
    // 获取沙盒版本号
    NSString *homeDirectory = [Head_Page_V getHomeDirectoryVersionNumber];
    //获取当前版本号
    NSString *present = [Head_Page_V getAtPresentVersionNumber];
    if([homeDirectory isEqualToString:present]){
        
        NSLog(@"未更新");
        [self  begin];
        
    }
    else {
        // 存储当前版本号
        [Head_Page_V saveAtPresentVersionNumber:present];
        NSLog(@"更新 --- 显示引导页");
        self.guidePage = [[Head_Page_V alloc] initWithFrame:self.window.bounds];
        self.guidePage.scrollView.delegate = self;
        [self.guidePage.enter addTarget:self action:@selector(enterButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.guid = [[Head_Page_VC alloc]init];
        [self.guid.view addSubview:self.guidePage];
        //        UINavigationController *mavGuid = [[UINavigationController alloc]initWithRootViewController:self.guid];
        //        mavGuid.navigationBar.hidden = YES;
        [self.window setRootViewController:self.guid];
        
    }
    
    
    
    
    
    [self.window makeKeyAndVisible];
}


- (void)enterButtonAction:(UIButton *)sender
{
    NSLog(@"跳过");
    [self.guidePage removeFromSuperview];
    [self begin];
}

#pragma mark - 滚动至最后一张图片, 移除引导页并显示主视图控制器
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.guidePage.scrollView.contentOffset.x > self.window.frame.size.width * 3 + self.window.frame.size.width / 4) {
        [self.guidePage removeFromSuperview];
        [self begin];
    }
}

#pragma mark - 滚动视图改变, 分页点随之改变
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.guidePage.page.currentPage = self.guidePage.scrollView.contentOffset.x / (self.guidePage.scrollView.frame.size.width);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.lanou3g.__" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"__" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"__.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
