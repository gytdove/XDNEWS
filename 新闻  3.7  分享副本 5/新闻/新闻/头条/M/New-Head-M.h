//
//  New-Head-M.h
//  新闻
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LXDBaseModel.h"

@interface New_Head_M : LXDBaseModel

@property (nonatomic, copy  ) NSString       *title;
@property (nonatomic, retain) NSMutableArray *images;
@property (nonatomic, copy  ) NSString       *thumbnail;
@property (nonatomic, copy  ) NSString       *source;
@property (nonatomic, copy  ) NSString       *commentsUrl;

@property (nonatomic, copy  ) NSString       *commentsall;
@property (nonatomic, copy  ) NSString       *updateTime;
@property (nonatomic, copy  ) NSString       *type;

@property (nonatomic, copy  ) NSString       *leftName;
@property (nonatomic, copy  ) NSString       *rightName;
@property (nonatomic, copy  ) NSString       *leftLogo;
@property (nonatomic, copy  ) NSString       *rightLogo;
@property (nonatomic, copy  ) NSString       *leftScore;
@property (nonatomic, copy  ) NSString       *rightScore;
@property (nonatomic, copy  ) NSString       *tag;








@end
