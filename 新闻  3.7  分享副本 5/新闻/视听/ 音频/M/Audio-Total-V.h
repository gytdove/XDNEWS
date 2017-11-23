//
//  Audio-Total-V.h
//  新闻
//
//  Created by dllo on 16/2/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol moreDelgate <NSObject>

-(void)getchangemore:(NSString *)more;
-(void)getchangedetail:(NSString *)detail;
@end




@interface Audio_Total_V : UITableViewCell

//@property (nonatomic, retain)id<collectDelgate>delegate;

@property (nonatomic, retain)id<moreDelgate>delegate;
//@property (nonatomic, retain)id<detailDelgate>delegate;

@property (nonatomic, retain) UILabel *cardTitleL;

@property (nonatomic, retain) NSMutableArray *arr;

@property (nonatomic, retain) UILabel *netId;

@property (nonatomic, retain) UIButton *moreB;




@end
