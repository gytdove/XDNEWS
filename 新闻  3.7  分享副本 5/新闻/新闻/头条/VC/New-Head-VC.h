//
//  New-Head-VC.h
//  新闻
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol toutiaoDelegate <NSObject>

-(void)getchange:(NSString*)url;

@end



@interface New_Head_VC : UICollectionViewCell


@property (nonatomic, retain) id<toutiaoDelegate>delegate;











@end
