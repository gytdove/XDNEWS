//
//  LXDAFNetTool.m
//  earthOL
//
//  Created by dllo on 15/12/15.
//  Copyright © 2015年 dllo. All rights reserved.
//

#import "LXDAFNetTool.h"
#import "AFNetworking.h"
@implementation LXDAFNetTool



+(void)getNetWithURL:(NSString *)url body:(id)body
            headFile:(NSDictionary *)headFile
       responseStyle:(LXDResponseStyle)responseStyle
             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    // 1. 创建网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2. 请求头的添加
    if (headFile) {
        for (NSString *key in headFile.allKeys) {
            [manager.requestSerializer setValue:headFile[key] forHTTPHeaderField:key];
        }
    }
    // 3.返回数据的类型
    switch (responseStyle) {
        case LXDJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case LXDXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        case LXDDATA:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
 
            
        default:
            break;
    }
    
    
    
    // 4. 响应返回数据类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript",@"application/x-javascript",@"image/jpeg", nil]];
    // 5. UTF8转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // 6. 发送请求
    [manager GET:url parameters:body success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSString *path = [NSString stringWithFormat:@"%ld.plist", [url hash]];
        // 存储的沙盒路径
        NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        // 归档
        [NSKeyedArchiver archiveRootObject:responseObject toFile:[path_doc stringByAppendingPathComponent:path]];
        
        
        if (responseObject) {
            success(task, responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
        // 缓存的文件夹
        NSString *path = [NSString stringWithFormat:@"%ld.plist", [url hash]];
        NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        // 反归档
        id result = [NSKeyedUnarchiver unarchiveObjectWithFile:[path_doc stringByAppendingPathComponent:path]];
        
        if (result) {
            success(task, result);
            //            failure(task, error);
            //            NSLog(@"%@", error);
        } else {
            failure(task, error);
        }
        
    }];
    
}









+(void)postNetWithURL:(NSString *)url
                 body:(id)body
            bodyStyle:(LXDRequestStyle)requestStyle
             headFile:(NSDictionary *)headFile
        responseStyle:(LXDResponseStyle)responseStyle
              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    // 1. 创建网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2. body 的类型
    switch (requestStyle) {
        case LXDRequestJSON:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        case LXDRequestString:
            [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable * _Nullable error) {
                return parameters;
            }];
            break;
        default:
            break;
    }
    // 3. 请求头的添加
    if (headFile) {
        for (NSString *key in headFile.allKeys) {
            [manager.requestSerializer setValue:headFile[key] forHTTPHeaderField:key];
        }
    }
    // 4.返回数据的类型
    switch (responseStyle) {
        case LXDJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case LXDXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        case LXDDATA:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
            
            
        default:
            break;
    }
    
    
    
    // 5. 响应返回数据类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript",@"application/x-javascript",@"image/jpeg",nil]];
    // 6. UTF8转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // 7. 发送请求
    [manager POST:url parameters:body success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (responseObject) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (error) {
            failure(task, error);
        }
    }];

    
    
    
    
    
}















































@end
