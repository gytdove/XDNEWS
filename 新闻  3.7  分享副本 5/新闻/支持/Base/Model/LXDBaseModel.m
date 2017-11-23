//
//  LXDBaseModel.m
//  earthOL
//
//  Created by dllo on 15/12/15.
//  Copyright © 2015年 dllo. All rights reserved.
//

#import "LXDBaseModel.h"

@implementation LXDBaseModel

//- (void)dealloc
//{
//    [_mId release];
//    [super dealloc];
//}

// 容错
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.mId = value;
    }
}



-(instancetype)initWithDic:(NSMutableDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}




//+ (instancetype)baseModelWithDic:(NSMutableDictionary *)dic
//{
//    // 使用多态的方式进行对象的创建.
//    id obj = [[[self class] alloc] initWithDic:dic];
//    return [obj autorelease];
//}

+ (NSMutableArray *)baseModelWithArr:(NSMutableArray *)arr
{
    // 创建一个数组, 用来装model
    NSMutableArray *modelArr = [NSMutableArray array];
    for (NSMutableDictionary *dic in arr) {
        @autoreleasepool {
            // 通过便利构造器方式创建对象.
            id model = [[self class] baseModelWithDic:dic];
            // 把对象添加到数组中
            [modelArr addObject:model];
        }
    }
    return modelArr;
    
}
















@end
