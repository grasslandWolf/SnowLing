//
//  BaseTableViewController.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/24.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // self.edgesForExtendedLayout = UIRectEdgeNone;
    
 
}


- (void)configureTableViewAndFrame:(CGRect)frame style:(UITableViewStyle)style {

    _BaseTableView = [[UITableView alloc] initWithFrame:frame style:style];
    _BaseTableView.delegate = self;
    _BaseTableView.dataSource = self;
    _BaseTableView.showsVerticalScrollIndicator = NO;
    _BaseTableView.showsHorizontalScrollIndicator = NO;
    _BaseTableView.backgroundColor = [UIColor clearColor];
    _BaseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    _BaseTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    [self.view addSubview:_BaseTableView];

}

-(void)loadData {

    [self.BaseTableView reloadData];
    [self.BaseTableView.mj_header endRefreshing];
}
-(void)loadMoreData {
    [self.BaseTableView reloadData];
    [self.BaseTableView.mj_footer endRefreshing];
}

#pragma mark

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0;
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
