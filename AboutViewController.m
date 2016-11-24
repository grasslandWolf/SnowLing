//
//  AboutViewController.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/28.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "AboutViewController.h"

#import "LogisticsTableViewCell.h"

#import "LogisticsMessageTableViewCell.h"

@interface AboutViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * refreshTableView;

@property (nonatomic,strong) NSMutableArray * dataArray;

@property (nonatomic,strong) UIButton * refreshbtn;

@end

@implementation AboutViewController


-(NSMutableArray *)dataArray {

    if (!_dataArray) {
        
        NSString * title = @"[杭州市]浙江省杭州市文三路公司  已签收  签收人：本人，感谢使用圆通速递，期待再次为您服务";
        NSString * title0 = @"[杭州市]浙江省杭州市文三路派件员：宋韬韬\n18152393829正在为您派件";
        NSString * title1 = @"浙江省杭州市文三路  已收入 浙江省杭州市文三路  已收入 浙江省杭州市文三路  已收入";
        NSString * title2 = @"[杭州市]快件已到达  浙江省杭州市文三路";
//        _dataArray = [NSMutableArray arrayWithObjects:@"星期一",@"星期二",@"星期三",@"星期四", nil];
        _dataArray = [NSMutableArray arrayWithObjects:title,title0,title1,title2, nil];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  self.title = @"关于我们";
    self.view.backgroundColor =  COLOR_BACK;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
  self.edgesForExtendedLayout = UIRectEdgeNone;
  [self setUp];
    
}
-(void)setUp {
    
//    UIButton * refreshbtn = [UIButton  buttonWithType:UIButtonTypeCustom];
//    refreshbtn.frame = CGRectMake(50, 5, 80, 20);
//    refreshbtn.backgroundColor = [UIColor clearColor];
//    refreshbtn.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
//    refreshbtn.layer.borderWidth = 0.5;
//    refreshbtn.layer.masksToBounds = YES;
//    refreshbtn.layer.cornerRadius = 5.0;
//    [refreshbtn setTitle:@"刷新" forState:UIControlStateNormal];
//    [refreshbtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    refreshbtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
//    self.refreshbtn = refreshbtn;
//    [refreshbtn addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:refreshbtn];
    

    UITableView * refreshTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    refreshTableView.delegate = self;
    refreshTableView.dataSource = self;
    self.refreshTableView = refreshTableView;
    refreshTableView.showsVerticalScrollIndicator = NO;
    refreshTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    refreshTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:refreshTableView];

}

-(void)refreshData:(UIButton*)sender {

    NSMutableArray * dataArray = [NSMutableArray arrayWithObjects:@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期天",nil];
    self.dataArray = dataArray;
    [self.refreshTableView reloadData];

}

#pragma mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    } else {
    
        return self.dataArray.count;
        
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        static NSString * identifer = @"cell";
        LogisticsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (!cell) {
            cell = [[LogisticsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
    
        static NSString * identifer = @"identifer";
        LogisticsMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (!cell) {
            cell = [[LogisticsMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString * title = self.dataArray[indexPath.row];
        [cell getTitle:title];
        cell.dataLabel.text = @"2016-10-10  14:54:12";
       
        if (self.dataArray.count >1) {
            if (indexPath.row == 0) {
                cell.grayView.hidden = YES;
                cell.titleLabel.textColor = COLOR_Theme;
                cell.dataLabel.textColor = COLOR_Theme;
            } else {
            
                cell.redImageView.hidden = YES;
            }
        } else {
        
            cell.redImageView.hidden = YES;
        }

        return cell;
    }
    
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 90;
    } else {
    
        return 80;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDH, 30)];
    headView.backgroundColor = [UIColor yellowColor];
    return headView;

}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDH, 30)];
    headView.backgroundColor = [UIColor clearColor];
    return headView;
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
