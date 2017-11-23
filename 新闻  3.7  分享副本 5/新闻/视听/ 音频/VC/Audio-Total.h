//
//  Audio-Total.h
//  新闻
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol moreMideleDelgate <NSObject>

-(void)getchangemoreMiddle:(NSString *)more;
-(void)getchangeIdMiddle:(NSString *)middle;

@end
@interface Audio_Total : UICollectionViewCell


@property (nonatomic, retain) UITableView *tableV;

@property (nonatomic, copy) NSString *moreMiddle;

@property (nonatomic, retain)id<moreMideleDelgate>delegate;

@property (nonatomic, copy) NSString *idMiddle;


@end
