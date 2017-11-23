//
//  LXD_Head_Page.h
//  earthOL
//
//  Created by dllo on 16/1/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Head_Page_V : UIView
@property (nonatomic, retain) UIScrollView *scrollView; /* 引导页滑动 */

@property (nonatomic, retain)UIPageControl *page; /* 滑动的点 */

@property (nonatomic, retain) UIButton *enter;
+ (NSString *)getHomeDirectoryVersionNumber;

/**
 *  @brief 获取当前版本号
 *
 *  @return 返回当前APP版本号
 */
+ (NSString *)getAtPresentVersionNumber;

/**
 *  @brief 存储当前版本号
 *
 *  @param atPresentVersionNumber 传入的当前版本号
 */
+ (void)saveAtPresentVersionNumber:(NSString *)atPresentVersionNumber;
@end
