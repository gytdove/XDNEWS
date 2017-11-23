//
//  DataBaseHandle.m
//  豆瓣
//
//  Created by dllo on 15/12/2.
//  Copyright (c) 2015年 dllo. All rights reserved.
//

#import "DataBaseHandle.h"
#import <sqlite3.h>
#import "New-Talk-Detail-M.h"



@implementation DataBaseHandle

+(instancetype)shareDataBase
{
    static DataBaseHandle *dataBase = nil;
    if (nil == dataBase) {
        dataBase = [[DataBaseHandle alloc] init];
    }
    return dataBase;
}

static sqlite3 *DB = nil;
-(void)openDB
{
    // 获取路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [path stringByAppendingPathComponent:@"dataBase.db"];
    
    // 打开数据库
    // 注意将文件路径转为 c 语言是别的字符串类型
    int ret = sqlite3_open(filePath.UTF8String, &DB);
    
    if (SQLITE_OK == ret) {
        NSLog(@"打开数据库成功");
    }
    else
    {
        NSLog(@"打开数据库失败");
    }
}


-(void)createTable
{
    NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS pro(number integer PRIMARY KEY AUTOINCREMENT, expertId TEXT, alias TEXT, headpicurl TEXT)"];
    
    int ret = sqlite3_exec(DB, sqlStr.UTF8String, NULL, NULL, NULL);
    if (SQLITE_OK == ret) {
        NSLog(@"创建表单成功");
    }
    else
    {
        NSLog(@"创建表单失败");
    }
}

-(void)insertDataWithHuman:(New_Talk_Detail_M *)au1
{
    NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO pro(expertId, alias, headpicurl) VALUES ('%@', '%@', '%@')", au1.expertId, au1.alias, au1.headpicurl];
    
    int ret = sqlite3_exec(DB, sqlStr.UTF8String, NULL, NULL, NULL);
    if (SQLITE_OK == ret) {
        NSLog(@"插入数据库成功");
    }
    else
    {
        NSLog(@"插入数据库失败");
    }}



-(void)deleteDataWithData:(NSString*)expertId
{
    NSString *sqlStr = [NSString stringWithFormat:@"DELETE FROM pro WHERE expertId = '%@'", expertId];
    
    int ret = sqlite3_exec(DB, sqlStr.UTF8String, NULL, NULL, NULL);
    if (SQLITE_OK == ret) {
        NSLog(@"删除数据成功");
    }
    else
    {
        NSLog(@"删除数据失败");
    }
}














-(void)deleteDataWithData:(NSString*)expertId alias:(NSString *)alias headpicurl:(NSString *)headpicurl
{
    NSString *sqlStr = [NSString stringWithFormat:@"DELETE FROM pro WHERE expertId = '%@', alias = '%@',headpicurl = '%@'", expertId,alias,headpicurl];
    
    int ret = sqlite3_exec(DB, sqlStr.UTF8String, NULL, NULL, NULL);
    if (SQLITE_OK == ret) {
        NSLog(@"删除数据成功");
    }
    else
    {
        NSLog(@"删除数据失败");
    }
}







-(NSMutableArray *)selectAllStudent
{
    NSString *sqlStr = @"SELECT * FROM pro";
    sqlite3_stmt *stmt = nil;
    int ret = sqlite3_prepare_v2(DB, sqlStr.UTF8String, -1, &stmt, NULL);
    
    if (SQLITE_OK == ret) {
        NSMutableArray *stuArr = [NSMutableArray array];
        // 判断是否还有有效数据
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            // 参数2: 列数
            //            sqlite3_column_text(stmt, 1);
            const unsigned char *expertId = sqlite3_column_text(stmt, 1);
            const unsigned char *alias = sqlite3_column_text(stmt, 2);
            const unsigned char *headpicurl = sqlite3_column_text(stmt, 3);
            

            
            
            New_Talk_Detail_M *hum = [[New_Talk_Detail_M alloc] init];
            hum.expertId = [NSString stringWithUTF8String:(const char *)expertId];
            hum.alias = [NSString stringWithUTF8String:(const char *)alias];
            hum.headpicurl = [NSString stringWithUTF8String:(const char *)headpicurl];
//            NSLog(@"%@",stuArr);
            
            [stuArr addObject:hum];
        }
        NSLog(@"获取数据成功");
        return stuArr;
        
    }
    else
    {
        NSLog(@"获取数据失败");
        return nil;
    }
}









-(NSMutableArray *)selectStudentWithalias:(NSString *)alias
{
    NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM pro WHERE  alias LIKE '%%%@%%'", alias];
    sqlite3_stmt *stmt = nil;
    int ret = sqlite3_prepare_v2(DB, sqlStr.UTF8String, -1, &stmt, NULL);
    
    if (SQLITE_OK == ret) {
        NSMutableArray *stuArr = [NSMutableArray array];
        // 判断是否还有有效数据
        while (SQLITE_ROW == sqlite3_step(stmt)) {
            
            
            
            
            
            // 参数2: 列数
            //            sqlite3_column_text(stmt, 1);
            const unsigned char *expertId = sqlite3_column_text(stmt, 1);
            const unsigned char *alias = sqlite3_column_text(stmt, 2);
            const unsigned char *headpicurl = sqlite3_column_text(stmt, 3);
            //            sqlite3_int64 age = sqlite3_column_int64(stmt, 3);

            New_Talk_Detail_M *hum = [[New_Talk_Detail_M alloc] init];
            
            
             hum.expertId = [NSString stringWithUTF8String:(const char *)expertId];
            hum.alias = [NSString stringWithUTF8String:(const char *)alias];
            hum.headpicurl = [NSString stringWithUTF8String:(const char *)headpicurl];
            
            
            
            
            
            [stuArr addObject:hum];
        }
        return stuArr;
    }
    else
    {
        NSLog(@"获取数据失败");
        return nil;
    }
}










@end
