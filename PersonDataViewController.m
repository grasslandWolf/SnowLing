//
//  PersonDataViewController.m
//  SnowLing
//
//  Created by 刘新乐 on 16/11/22.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "PersonDataViewController.h"


@interface PersonDataViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView * baseCollectionView;

@end

@implementation PersonDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_BACK;
    [self initTitleView:@"个人资料"];
    [self setUp];
}
-(void)setUp {

    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    UICollectionView * baseCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    baseCollectionView.backgroundColor = [UIColor clearColor];
    baseCollectionView.delegate = self;
    baseCollectionView.dataSource = self;
    self.baseCollectionView = baseCollectionView;
    [baseCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
    baseCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    baseCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
        
    }];
    
    [self.view addSubview:baseCollectionView];

}

#pragma mark UICollectionViewDelegate,UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cyanColor];
    return cell;
}
- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath {
    CGFloat width = (SCREEN_WIDH - 30) / 2;
    return CGSizeMake(width, 150);
}
// 下拉刷新
-(void)loadData {

    [self.baseCollectionView reloadData];
    [self.baseCollectionView.mj_header endRefreshing];
}
// 上拉加载更多
-(void)loadMoreData {
    
    [self.baseCollectionView reloadData];
    [self.baseCollectionView.mj_footer endRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
