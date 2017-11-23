//
//  DataBaseHandle.h
//  豆瓣
//
//  Created by dllo on 15/12/2.
//  Copyright (c) 2015年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class New_Talk_Detail_M;


@interface DataBaseHandle : NSObject


+(instancetype)shareDataBase;

//-(void)openDB;
//
////-(void)insertDataWithHuman:(Human *)hum;
//
//-(void)createTable;
//
//-(NSMutableArray *)selectAllStudent;
//
//-(void)insertDataWithHuman:(LXD_tra_Author_M *)au1;
//
//-(void)deleteDataWithData:(NSString*)author_id nick:(NSString *)nick slogan:(NSString *)slogan location:(NSString *)location face:(NSString *)face user_type:(NSString *)user_type;
//
//-(void)deleteDataWithData:(NSString*)author_id;
//
//-(NSMutableArray *)selectStudentWithNick:(NSString *)nick;


-(void)openDB;

-(void)createTable;

-(void)insertDataWithHuman:(New_Talk_Detail_M *)au1;

-(void)deleteDataWithData:(NSString*)expertId;

-(void)deleteDataWithData:(NSString*)expertId alias:(NSString *)alias headpicurl:(NSString *)headpicurl;
-(NSMutableArray *)selectAllStudent;

-(NSMutableArray *)selectStudentWithalias:(NSString *)alias;






























@end
