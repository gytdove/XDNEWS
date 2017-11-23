//
//  Audio-Total-m.h
//  新闻
//
//  Created by dllo on 16/2/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LXDBaseModel.h"

@interface Audio_Total_m : LXDBaseModel

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy  ) NSString       *cardTitle;
@property (nonatomic, retain) NSMutableArray *cardDetails;
@property (nonatomic, copy  ) NSString       *title;
@property (nonatomic, copy  ) NSString       *programName;
@property (nonatomic, copy  ) NSNumber       *listenNumShow;
@property (nonatomic, copy  ) NSString       *nodeId;
@property (nonatomic, copy  ) NSString       *songId;
@property (nonatomic, copy  ) NSString       *id;

@end
