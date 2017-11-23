//
//  New-163-VC.h
//  新闻
//
//  Created by dllo on 16/3/1.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol yuanchuangDelegate <NSObject>

-(void)getchange:(NSString*)url;

@end
@interface New_163_VC : UICollectionViewCell
@property (nonatomic, retain) id<yuanchuangDelegate>delegate;
@end
