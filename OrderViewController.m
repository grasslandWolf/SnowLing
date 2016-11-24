//
//  OrderViewController.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/28.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "OrderViewController.h"

#import "HeadTableViewCell.h"

@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource,HeadTableViewCellDeledate>

@property (nonatomic,strong) UITableView * headTableView ;

@property (nonatomic,strong) UITableView * detailTableView;

@property(nonatomic,strong) UIView * coverView ;

@property (nonatomic,strong) UIView * leftView;
@property (nonatomic,strong) UIView * middleView;
@property (nonatomic,strong) UIView * rightView;

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation OrderViewController

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
//    self.detailTableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
//        
//        self.dataArray = [NSMutableArray arrayWithObjects:@"华语金曲",@"华语乐坛",@"音乐盛典",@"随机数据", nil];
//    }];
//    [self.detailTableView.mj_header beginRefreshing];
    
   // [self.detailTableView.mj_header endRefreshing];
}


-(NSMutableArray *)dataArray {

    if (!_dataArray ) {
        _dataArray = [NSMutableArray arrayWithObjects:@"星期一",@"星期二",@"星期三",@"星期四",@"星期五", nil];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的订单";

    
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    [self setUp];
    
    
}
-(void)setUp {


    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDH, 50) style:UITableViewStyleGrouped];
    self.headTableView = tableView;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    UITableView * DtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDH, SCREEN_HEIGHT -50-60) style:UITableViewStyleGrouped];
    DtableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
       
    }];
    DtableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    [DtableView.mj_header beginRefreshing];
    self.detailTableView = DtableView;
    DtableView.delegate = self;
    DtableView.dataSource = self;
    [self.view addSubview:DtableView];
    


}
-(void)loadNewData {


    [self.detailTableView reloadData];
    [self.detailTableView.mj_header endRefreshing];
    
}
-(void)loadMoreData {

        NSArray * arr = [NSArray arrayWithObjects:@"八九不离十",@"八十九不离十",@"八九不离十",@"八九不离十", nil];
        for (int i = 0; i < arr.count; i++) {
            [self.dataArray addObject:arr[i]];
        }
    [self.detailTableView reloadData];
    [self.detailTableView.mj_footer endRefreshing];

}
-(void)initCoverView {
    
    UIView * coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDH, SCREEN_HEIGHT)];
    self.coverView = coverView;
    coverView.backgroundColor = [UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:0.6];
    [self.view addSubview:coverView];
    
    UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc] init];
    recognizer.numberOfTouchesRequired =1 ;
    [recognizer addTarget:self action:@selector(removeSelf:)];
    [coverView addGestureRecognizer:recognizer];

}
-(void)removeSelf:(UITapGestureRecognizer *)recognzier {

    [self.coverView removeFromSuperview];
    [self.leftView removeFromSuperview];
    [self.middleView removeFromSuperview];
    [self.rightView removeFromSuperview];
    [self.detailTableView reloadData];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

//    if (tableView == self.detailTableView) {
//        return 2;
//    } else {
//        
//        return 1;
//    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if ([tableView isEqual: self.detailTableView]) {

        return self.dataArray.count;
    } else  {
    
        return 1;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual: self.headTableView ]) {
        
        HeadTableViewCell * cell = (HeadTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[HeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
        
    } else  {
    
        static NSString * identifier = @"identifier";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
        }
        cell.textLabel.text = self.dataArray[indexPath.row];
        
        return cell;
    
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.headTableView) {
        
        return 50;
        
    } else {
    
        return 60;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 10;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

//    [self.navigationController popViewControllerAnimated:YES];
//    self.navigationController.tabBarController.hidesBottomBarWhenPushed = NO;
//    self.navigationController.tabBarController.selectedIndex = 0;
    

}
-(void)reloadMessage:(NSInteger)index {
    
    switch (index) {
        case 123:
        {
            [self initCoverView];
            [self initLeftView];
            [self.middleView removeFromSuperview];
            [self.rightView removeFromSuperview];
        }

            break;
        case 124:
        {
            [self initCoverView];
            [self initMiddleView];
            [self.leftView removeFromSuperview];
            [self.rightView removeFromSuperview];
        
        }
 
            break;
        case 125:
        {
            [self initCoverView];
            [self initRightView];
            [self.leftView removeFromSuperview];
            [self.middleView removeFromSuperview];
        
        }
 
            break;
            
        default:
            break;
    }

   // [self.detailTableView reloadData];
}

-(void)initLeftView {

    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDH, 160)];
    view.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < 5; i++) {
        
        int line = i/3;
        int row = i%3;
        
        NSArray * array  = [NSArray arrayWithObjects:@"上衣",@"外套",@"男鞋",@"女装",@"女鞋", nil];
        CGFloat x = (SCREEN_WIDH - 120)/4;
       
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(x +(x+ 40)*row, 30 +(20+20)*line, 40, 20);
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        if (i==0) {
            button.selected = YES;
        }
        button.tag = 1123 + i;
        [button addTarget:self action:@selector(chooseSort:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [view addSubview:button];
    }
    self.leftView = view;
    [self.view addSubview:view];
}
-(void)chooseSort:(UIButton*)sender {

    self.leftView.hidden = YES;
    self.coverView.hidden = YES;
     NSMutableArray * array = [NSMutableArray arrayWithObjects:@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", @"星期天",nil];
    self.dataArray = array;
    
    [self.detailTableView reloadData];

    
}

-(void)initMiddleView {
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDH, 160)];
    view.backgroundColor = [UIColor cyanColor];
    self.middleView = view;
    [self.view addSubview:view];
}
-(void)initRightView {
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDH, 160)];
    view.backgroundColor = [UIColor yellowColor];
    self.rightView = view;
    [self.view addSubview:view];
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
