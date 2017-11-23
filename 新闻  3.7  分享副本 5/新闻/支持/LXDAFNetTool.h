//
//  LXDAFNetTool.h
//  earthOL
//
//  Created by dllo on 15/12/15.
//  Copyright © 2015年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LXDResponseStyle) {
    LXDJSON,
    LXDXML,
    LXDDATA,
};

typedef NS_ENUM(NSUInteger, LXDRequestStyle) {
    LXDRequestJSON,
    LXDRequestString,
};



@interface LXDAFNetTool : NSObject

/**
 *  get 请求
 *
 *  @param url           请求网址
 *  @param body          body体
 *  @param responseStyle 返回的数据类型
 *  @param headFile      请求头
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 */
+(void)getNetWithURL:(NSString *)url body:(id)body
            headFile:(NSDictionary *)headFile
       responseStyle:(LXDResponseStyle)responseStyle
             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


/**
 *  post 请求
 *
 *  @param url           请求网址
 *  @param body          body体
 *  @param requestStyle  请求的数据类型
 *  @param responseStyle 返回的数据类型
 *  @param headFile      请求头
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 */
+(void)postNetWithURL:(NSString *)url
                 body:(id)body
            bodyStyle:(LXDRequestStyle)requestStyle
             headFile:(NSDictionary *)headFile
        responseStyle:(LXDResponseStyle)responseStyle
              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;















@end
