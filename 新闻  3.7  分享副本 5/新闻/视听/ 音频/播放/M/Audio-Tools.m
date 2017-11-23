//
//  Audio-Tools.m
//  新闻
//
//  Created by dllo on 16/3/7.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "Audio-Tools.h"

@implementation Audio_Tools
static Audio_Tools *_instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    if (_instance == nil) {
        @synchronized(self) {
            if (_instance == nil) {
                _instance = [super allocWithZone:zone];
                _instance.arrayAudio = [NSMutableArray array];
                _instance.detail = [[Audio_Detail_VC alloc] init];
                _instance.GoSongView = [[UIView alloc] init];
            }

        }
    }
    return _instance;
}

+ (instancetype)shareTools{
    if (_instance == nil) {
        @synchronized(self) {
            if (_instance == nil) {
                _instance = [[super alloc]init];
            }
        }
    }
    return _instance;
}

@end
