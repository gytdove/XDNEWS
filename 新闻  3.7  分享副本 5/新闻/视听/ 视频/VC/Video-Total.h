//
//  Video-Total.h
//  新闻
//
//  Created by dllo on 16/2/26.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaPlayer/MediaPlayer.h"

@protocol moviedelegate <NSObject>

-(void)gomovie:(NSString *)movie;

@end






@interface Video_Total : UICollectionViewCell

@property (nonatomic, strong) MPMoviePlayerController *movie;
@property (nonatomic, retain) id<moviedelegate>delegate;

@end
