//
//  Audio-Tools.h
//  新闻
//
//  Created by dllo on 16/3/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Audio-Detail-VC.h"
@interface Audio_Tools : NSObject
@property (nonatomic, strong) NSMutableArray *arrayAudio;

@property (nonatomic, strong) Audio_Detail_VC *detail;

@property (nonatomic, strong) UIView *GoSongView;
+ (instancetype)shareTools;
@end
