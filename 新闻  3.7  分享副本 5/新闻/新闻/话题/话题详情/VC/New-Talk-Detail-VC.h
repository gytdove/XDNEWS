//
//  New-Talk-Detail-VC.h
//  新闻
//
//  Created by dllo on 16/2/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LXDBaseViewController.h"
@class New_Talk_Detail_M;
@interface New_Talk_Detail_VC : LXDBaseViewController
@property (nonatomic, retain) UITableView           *tabelV;
@property (nonatomic, assign) NSInteger             page;
@property (nonatomic, copy  ) NSString              *exID;

@property (nonatomic, retain) New_Talk_Detail_M     *act;


@property (nonatomic, retain) UIImageView           *picurlImg;
@property (nonatomic, retain) UILabel               *aliasL;
@property (nonatomic, retain) UILabel               *countL;
@property (nonatomic, retain) UIButton              *collecB;

@property (nonatomic, retain) UIImageView           *headImg;
@property (nonatomic, retain) UILabel               *nameL;
@property (nonatomic, retain) UILabel               *titleL;
@property (nonatomic, retain) UILabel               *descripL;

@property (nonatomic, retain) UIImageView           *backView;





@end
