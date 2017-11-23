//
//  LXDBaseModel.h
//  earthOL
//
//  Created by dllo on 15/12/15.
//  Copyright © 2015年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXDBaseModel : NSObject

-(instancetype)initWithDic:(NSMutableDictionary *)dic;


+(instancetype)baseModelWithDic:(NSMutableDictionary *)dic;


+(NSMutableArray *)baseModelWithArr:(NSMutableArray *)arr;


@property (nonatomic, copy) NSString *mId;


@end
