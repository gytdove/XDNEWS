//
//  Audio-Detail-VC.h
//  新闻
//
//  Created by dllo on 16/3/3.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LXDBaseViewController.h"
#import "STKAudioPlayer.h"
@interface Audio_Detail_VC : LXDBaseViewController


@property (nonatomic, retain) NSString *idTotal;

@property (nonatomic, retain  ) UITableView    *tableV;
@property (nonatomic, retain  ) STKAudioPlayer     *player;



@end
