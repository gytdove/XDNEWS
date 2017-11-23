//
//  Audio-Total-V.m
//  新闻
//
//  Created by dllo on 16/2/29.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "Audio-Total-V.h"
#import "Audio-Total-CV.h"
#import "Audio-Total-m.h"
#import "MJRefresh.h"
#import "LXDAFNetTool.h"
#import "UIImageView+WebCache.h"
#import "Audio-Detail-VC.h"




@interface Audio_Total_V ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,retain)UICollectionView *collectionV;
@property(nonatomic,retain)NSMutableDictionary *dic;

@end

@implementation Audio_Total_V
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatView];
    }
    
    return self;
}
-(void)setArr:(NSMutableArray *)arr
{
    
    if(_arr != arr){
        
        _arr = arr;
    
//    NSLog(@"***********%ld",self.arr.count);
    [self.collectionV reloadData];
   }
}
-(void)creatView
{
    [self collectAction];

    
    self.cardTitleL = [[UILabel alloc] init];
    self.cardTitleL.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.cardTitleL];
    
//    NSLog(@"qqqqqqqqq%@",self.netId);
    self.netId = [[UILabel alloc] init];
    [self.contentView addSubview:self.netId];
    
    self.moreB = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moreB.frame = CGRectMake(0, 10*HEIGHT, 100*WIDTH, 30*HEIGHT);
//    self.moreB.backgroundColor = [UIColor redColor];
    [self.moreB setTitle:@"更多" forState:UIControlStateNormal];
    [self.moreB setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.moreB addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self. contentView addSubview:self.moreB];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.cardTitleL.frame = CGRectMake(10*WIDTH, 10*HEIGHT, 100*WIDTH, 20*HEIGHT);
    
    self.moreB.frame = CGRectMake(self.bounds.size.width - 100*WIDTH, 15*HEIGHT, 100*WIDTH, 20*HEIGHT);
}

-(void)buttonAction
{
//    NSLog(@"%@",self.netId.text);
    
    [self.delegate getchangemore:self.netId.text];
    
}



-(void)collectAction
{
    // UICollectionViewLayout 是一个抽象类, 我们一般使用他的子类
    UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc] init];
    
    // 最低限度行间距
    // 注意:
    // 1, 系统会尽可能靠近参数值, 并保证不会小于
    // 2, 垂直于滑动方向即为行!
    flowL.minimumLineSpacing = 10;
    
    // 列间距
    //    flowL.minimumInteritemSpacing = 100;
    
    // 单元大小
    flowL.itemSize = CGSizeMake(90*WIDTH, 160*HEIGHT);
    
    // 区头间距
    flowL.headerReferenceSize = CGSizeMake(10, 10);
    
    // 区脚间距
    //    flowL.footerReferenceSize = CGSizeMake(10, 10);
    
    // 与屏幕四边的间距
    flowL.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
    
    // 滚动方向
    flowL.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40*HEIGHT, self.bounds.size.width+ WIDTH*100, 160*HEIGHT) collectionViewLayout:flowL];
    self.collectionV.backgroundColor = [UIColor whiteColor];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    [self addSubview:self.collectionV];
    
    // 注册自定义 cell
    [self.collectionV registerClass:[Audio_Total_CV class] forCellWithReuseIdentifier:@"cell"];
}

// 图片数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}
// cell 里面
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Audio_Total_CV *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    

    Audio_Total_m *act = [[Audio_Total_m alloc] initWithDic:[self.arr objectAtIndex:indexPath.row]];

    [cell.imageImg sd_setImageWithURL:[NSURL URLWithString:act.image]];
    cell.titleL.text = act.title;
//    NSLog(@"qwerqwfawds%@",self.arr);
    cell.programNameL.text = act.programName;
//    cell.listenNumShowL.text = act.listenNumShow;
    
    NSNumberFormatter* numberFormatter2 = [[NSNumberFormatter alloc] init];
    
    cell.listenNumShowL.text = [numberFormatter2 stringFromNumber:act.listenNumShow];
//    NSLog(@"%@",cell.listenNumShowL.text);
//    NSLog(@"sssssss%@",act.songId);
//    NSLog(@"lllllll%@",act.listenNumShow);
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    Audio_Total_m *act = [self.arr objectAtIndex:indexPath.row];
//    self.delegate = act.id;
//    Audio_Detail_VC *detail = [[Audio_Detail_VC alloc] init];
//    NSLog(@"%@",act.id);
    
    self.dic = [NSMutableDictionary dictionary];
    self.dic = [self.arr objectAtIndex:indexPath.row] ;
//    NSLog(@"%@",[_dic objectForKey:@"id"]);
//    detail.idTotal = [_dic objectForKey:@"id"];
    [self.delegate getchangedetail:[_dic objectForKey:@"id"]];
}








































- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
