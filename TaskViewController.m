//
//  TaskViewController.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/24.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "TaskViewController.h"

#import "TaskGroupCollectionViewCell.h"

#import "TaskDetailViewController.h"

#import "sscreenView.h"

@interface TaskViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UICollectionView * groupCollectionView;

@property (nonatomic,strong) NSArray * groupArray;

@property (nonatomic,assign) NSInteger index; // 选中行

@property (nonatomic,strong) UIScrollView * scrollView;

@property (nonatomic,strong) NSMutableArray * orangeArray;   // 分类数据

@property (nonatomic,strong) NSArray * purpleArray; // 排序数据

@property (nonatomic,strong) UIButton * defaultBtn; // 默认排序

@property (nonatomic,strong) UITableView * goodsTableView ;

@property (nonatomic,strong) NSMutableArray *  dataArray;

@property (nonatomic,strong) sscreenView * scView; // 筛选

@property (nonatomic,strong) UIView * sortView; // 排序

@property (nonatomic,strong) UIView * classificationView; // 分类

@end

@implementation TaskViewController

static NSString * indentifier = @"indentifier";

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    [self.groupCollectionView reloadData];
    
    // 任务列表
    [SLTool getTasks:1 success:^(id success) {
        
        BaseModel * model = [[BaseModel alloc] initWithDict:success];
        if ([model.success intValue] == 1) {
            
            NSDictionary * dictionary = [success objectForKey:@"data"];
            
            NSDictionary * dict = [dictionary objectForKey:@"meta"];
            
            TaskMetaModel * taskModel = [[TaskMetaModel alloc] initWithDict:dict];
            NSLog(@"获得的数据是 %@",taskModel);
            
            NSArray * arr = [dictionary objectForKey:@"items"];
            
            for ( NSDictionary * dic in arr ) {
                
                TaskItemModel * model = [[TaskItemModel alloc] initWithDict:dic];
                [self.dataArray addObject:model];
            }
            
        }
        
        [self.goodsTableView reloadData];
        

    } failure:^(NSError * error) {
        
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.orangeArray = [NSMutableArray arrayWithCapacity:0];
    
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    
    // self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 获取分类
    [SLTool getClassification:^(id success) {
        
        BaseModel * bsModel = [[BaseModel alloc] initWithDict:success];
        
        if ([bsModel.success integerValue]==1) {
            
            NSDictionary * dictionary = [success objectForKey:@"data"];
            
            NSArray * classes = [dictionary objectForKey:@"classes"];
            
            for (NSDictionary * dict  in classes) {
            
                ClassificationModel * model = [[ClassificationModel alloc] initWithDict:dict];
                [self.orangeArray addObject:model];
            }
            
        }
        
        [self setUp];
        
    } failure:^(NSError * error) {
        
        
    }];
    
    //  [self setUp];
}

-(NSArray *)groupArray {

    if (!_groupArray) {
        _groupArray = [NSArray arrayWithObjects:@"排序",@"分类",@"筛选", nil];
    }
    return _groupArray;
}

//-(NSMutableArray *)orangeArray {
//    
//    if (!_orangeArray) {
//        
//        _orangeArray = [NSMutableArray arrayWithObjects:@"所有",@"男装",@"鞋靴",@"数码",@"女装",@"童装",@"食品",@"家纺", nil];
//    }
//    return _orangeArray;
//}

-(NSArray *)purpleArray {
    
    if (!_purpleArray) {
        _purpleArray = [NSArray arrayWithObjects:@"默认排序",@"默认排序",@"佣金由高到低",@"佣金由低到高",@"等级由高到低",@"等级由低到高", nil];
    }
    return _purpleArray;
}

-(void)setUp {


    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView * groupCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDH, 50) collectionViewLayout:flowLayout];groupCollectionView.delegate = self;
        groupCollectionView.dataSource = self;
    groupCollectionView.backgroundColor = [UIColor lightGrayColor];
    [groupCollectionView registerClass:[TaskGroupCollectionViewCell class] forCellWithReuseIdentifier:indentifier];
    self.groupCollectionView = groupCollectionView;
    [self.view addSubview:groupCollectionView];
    
    UIView * colorView = [[UIView alloc] init];
    colorView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:colorView];
    [colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(groupCollectionView.mas_bottom);
        make.left.and.right.equalTo(colorView.superview);
        make.height.equalTo(@1);
    }];
    
    
    // 商品的展示
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectNull style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.backgroundColor = [UIColor yellowColor];
    self.goodsTableView = tableView;
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(51);
        make.left.and.right.equalTo(tableView.superview);
        make.bottom.equalTo(tableView.superview);
    }];
    
    
    
    
}
-(void)click:(NSDictionary *)dict {

    self.scrollView.hidden = YES;
    
    NSString * sex = [dict objectForKey:@"sex"];
    
    if (sex == nil || [sex isEqualToString:@""]) {
        
    }
}

-(void)back:(UIButton *)btn {
    
    [self.sortView removeFromSuperview];
    [self.classificationView removeFromSuperview];
    [self.scView removeFromSuperview];

    self.scrollView.hidden = YES;
    
    switch (self.index) {
        case 0:
        {
          
            
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:self.index inSection:0];
            TaskGroupCollectionViewCell * cell = (TaskGroupCollectionViewCell*) [self.groupCollectionView cellForItemAtIndexPath:indexPath];
            cell.nameLabel.text = @"中文";
        
        }
            break;
        case 1:
        {
        
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:self.index inSection:0];
            TaskGroupCollectionViewCell * cell = (TaskGroupCollectionViewCell*) [self.groupCollectionView cellForItemAtIndexPath:indexPath];
            NSInteger i = btn.tag - 112;
            ClassificationModel * model = self.orangeArray[i];
            NSString * name = model.classificationName;
            cell.nameLabel.text = name;
        
        }
            break;
        case 2:
        {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:self.index inSection:0];
            TaskGroupCollectionViewCell * cell = (TaskGroupCollectionViewCell*) [self.groupCollectionView cellForItemAtIndexPath:indexPath];
            cell.nameLabel.text = @"中文";
            
           
        }
            break;
            
        default:
            break;
    }
    

}

-(void)createSortView {

    
    UIView * purpleView = [[UIView alloc] init];
    purpleView.backgroundColor = [UIColor purpleColor];
    self.sortView = purpleView;
    [self.view addSubview:purpleView];
    
    [purpleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.equalTo(purpleView.superview);
        make.top.equalTo(@(50));
        make.height.equalTo(@160);
    }];
    
    // 返回
    
    CGFloat width = (SCREEN_WIDH -240) /3;
    
    for (int i = 0; i < self.purpleArray.count; i++) {
        
        UIButton * backbtn = [UIButton  buttonWithType:UIButtonTypeCustom];
        int row = i/ 2;
        int low = i%2;
        backbtn.frame = CGRectMake( width + 120 *low , 30 + (15 + 15) *row, 120, 15);
        NSString * name = self.purpleArray[i];
        if (i == 0) {
            backbtn.selected = YES;
        }
        if (i == 1) {
            backbtn.hidden = YES;
        }
        [backbtn setTitle:name forState:UIControlStateNormal];
        [backbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backbtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        backbtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        backbtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        backbtn.tag = 112 +i;
        [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [purpleView addSubview:backbtn];
        
    }


}

-(void)createClassificationView {

    UIView * orangeView = [[UIView alloc] init];
    orangeView.backgroundColor = [UIColor orangeColor];
    self.classificationView = orangeView;
    [self.view addSubview:orangeView];
    [orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.equalTo(orangeView.superview);
        make.top.equalTo(@(50));
        make.height.equalTo(@160);
    }];
    
    for (int i = 0 ;  i < self.orangeArray.count; i++) {
        
        UIButton * backbtn = [UIButton  buttonWithType:UIButtonTypeCustom];
        int row = i/ 4;
        int low = i%4;
        backbtn.frame = CGRectMake(15+(60 +20)*low , 50 + (20 + 20) *row, 60, 20);
        
        ClassificationModel * model = self.orangeArray[i];
        NSString * name = model.classificationName;
        
        [backbtn setTitle:name forState:UIControlStateNormal];
        [backbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        backbtn.tag = 112 +i;
        [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [orangeView addSubview:backbtn];
        
    }
    


}
-(void)createScreenView {

    sscreenView * scView = [[sscreenView alloc] init];
    scView.backgroundColor = [UIColor brownColor];
    //    self.scView = scView;
    scView.voidBlock = ^(NSDictionary * dict){
        
        [self click:dict];
        
    };
    [self.view  addSubview:scView];
    
    [scView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.equalTo(scView.superview);
        make.top.equalTo(@(50));
        make.height.equalTo(@160);
    }];


}

#pragma mark UICollectionViewDelegate,UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.groupArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    
    TaskGroupCollectionViewCell * cell = (TaskGroupCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:indentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];
    NSString * name = self.groupArray[indexPath.row];
    cell.nameLabel.text = name;
    
    return cell;
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TaskGroupCollectionViewCell * cell =(TaskGroupCollectionViewCell*) [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    
    self.scrollView.hidden = NO;
    
    self.index = indexPath.row;
    switch (indexPath.row) {
        case 0:{
            [self createSortView];
            [self.classificationView removeFromSuperview];
            [self.scView removeFromSuperview];
        }
        
            break;
        case 1:
        {
            [self createClassificationView];
            [self.sortView removeFromSuperview];
            [self.scView removeFromSuperview];
        }
            break;
        case 2:
        {
            [self createScreenView];
            [self.sortView removeFromSuperview];
            [self.classificationView removeFromSuperview];
        }
            break;
            
        default:
            break;
    }
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    self.scrollView.contentOffset = CGPointMake(width * self.index, 0);

 
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {

    TaskGroupCollectionViewCell * cell =(TaskGroupCollectionViewCell*) [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];



}
- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath {
    
    CGFloat i = self.groupArray.count;
    CGFloat width = (self.view.frame.size.width - (i+1)*10)/i;
    return CGSizeMake(width, 30);
    
}
-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section

{
    
    return UIEdgeInsetsMake ( 10 , 10 , 0 , 0 );
    
}

#pragma mark UIScrollViewDelegate

#pragma mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.dataArray.count == 0) {
        
        return 5;
    } else {
    
        return self.dataArray.count;
        
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    
    if (self.dataArray.count == 0) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"默认第%ld行 ",(long)indexPath.row];
        
    } else {
    
        TaskItemModel * itemModel = self.dataArray[indexPath.row];
        NSString * name = itemModel.itemName;
        if (name == nil || [name isEqualToString:@""]) {
            
            name = @"拿真实数据说话";
        }
        cell.textLabel.text = [NSString stringWithFormat:@"真实数据 %@%ld",name,(long)indexPath.row];
    
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    TaskDetailViewController * detailVC = [[TaskDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 80;
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDH, 30)];
//    headView.backgroundColor = [UIColor redColor];
//    tableView.tableHeaderView = headView;
//    return headView;
//}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDH, 10)];
    tableView.tableFooterView = footerView;
    return footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated {

    [super viewDidDisappear:animated];
    self.scrollView .hidden = YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
