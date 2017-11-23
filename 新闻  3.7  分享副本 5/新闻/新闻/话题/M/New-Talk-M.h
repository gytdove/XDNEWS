//
//  New-Talk-M.h
//  新闻
//
//  Created by dllo on 16/2/27.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LXDBaseModel.h"

@interface New_Talk_M : LXDBaseModel


@property (nonatomic, copy) NSString *expertId;
@property (nonatomic, copy) NSString *alias;
@property (nonatomic, copy) NSString *picurl;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *descrip;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *headpicurl;

@property (nonatomic, copy) NSString *classification;
@property (nonatomic, copy) NSNumber *concernCount;
@property (nonatomic, copy) NSNumber *questionCount;




@end
