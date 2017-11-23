//
//  New-Deep-VC.h
//  新闻
//
//  Created by dllo on 16/3/1.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol deepDelegate <NSObject>

-(void)getchange:(NSString*)url;

@end
@interface New_Deep_VC : UICollectionViewCell
@property (nonatomic, retain) id<deepDelegate>delegate;
@end
