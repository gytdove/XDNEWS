//
//  New-Talk-VC.h
//  新闻
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LXDdelegate <NSObject>

-(void)getchange1:(NSString *)expertId;

@end

@interface New_Talk_VC : UICollectionViewCell
@property (nonatomic, retain)id<LXDdelegate>delegate;

@end
