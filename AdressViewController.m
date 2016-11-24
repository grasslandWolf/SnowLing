//
//  AdressViewController.m
//  SnowLing
//
//  Created by 刘新乐 on 16/11/13.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "AdressViewController.h"
#import "AdressTableViewCell.h"
#import "AdressFmdbModel.h"
#import "AddAdressViewController.h"

@interface AdressViewController ()<UITableViewDelegate,UITableViewDataSource,AdressTableViewCellDelegate>

@property (nonatomic,strong) NSArray * dataArray;

@end

@implementation AdressViewController

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.dataArray = [CollectionAndLikeManager addressCounts:1];
    
    [self.BaseTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = COLOR_BACK;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setUp];
}
-(void)setUp {

    [self initTitleView:@"地址管理"];
    [self configureTableViewAndFrame:CGRectMake(0, 0, SCREEN_WIDH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [self.BaseTableView registerNib:[UINib nibWithNibName:@"AdressTableViewCell" bundle:nil] forCellReuseIdentifier:@"identifer"];
    
    UIButton * adressBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    adressBtn.layer.masksToBounds = YES;
    adressBtn.layer.cornerRadius = 5.0;
    adressBtn.backgroundColor = COLOR_Theme;
    [adressBtn setTitle:@"新增地址" forState:UIControlStateNormal];
    adressBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [adressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [adressBtn addTarget:self action:@selector(addAdress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:adressBtn];
    
    [adressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        make.left.equalTo(adressBtn.superview).offset(30);
        make.right.equalTo(adressBtn.superview).offset(-30);
        make.height.equalTo(@40);
        
    }];
    self.dataArray = [NSArray array];
    
}
// 添加地址
-(void)addAdress:(UIButton *)sender {

    AddAdressViewController * addVC = [[AddAdressViewController alloc] init];
    addVC.type = 2;
    [self.navigationController pushViewController:addVC animated:YES];
  

}
#pragma mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifer = @"identifer";
    AdressTableViewCell * cell =(AdressTableViewCell *) [tableView dequeueReusableCellWithIdentifier:identifer];
    cell.delegate = self;
    cell.tag = indexPath.row +210;
    cell.deleteBtn.tag = indexPath.row + 100;
    cell.editBtn.tag = indexPath.row + 210;
    cell.defaultAdressBtn.backgroundColor = COLOR_CLEAR;
    cell.defaultAdressBtn.layer.cornerRadius = 7.5f;
    cell.defaultAdressBtn.layer.borderWidth = 0.5f;
    cell.defaultAdressBtn.layer.borderColor = COLOR_141.CGColor;
    cell.defaultAdressBtn.layer.masksToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString * phone = self.dataArray[indexPath.row];
    cell.phoneLabel.text = phone;
   // [cell getModel:model];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 115;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.01;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 修改地址
-(void)editAdress:(UIButton *)sender {


//    
//    AddAdressViewController * addVC = [[AddAdressViewController alloc] init];
//    addVC.type = 5;
//    [self.navigationController pushViewController:addVC animated:YES];
    
    NSDictionary * dict = @{
                            @"detailAdress":@"杭州市西湖区文一西路",
                            @"adress":@"浙江杭州",
                            @"phone":@"56784321",
                            @"consigneeName":@"世界阿三",
                            };
    AdressFmdbModel * adModel = [[AdressFmdbModel alloc] initWithDict:dict];
    NSInteger index = sender.tag ;
    AdressTableViewCell * cell = (AdressTableViewCell *)[self.BaseTableView viewWithTag:index];
    cell.phoneLabel.text = adModel.phone;
    cell.nickNameLabel.text = adModel.consigneeName;
    
    [CollectionAndLikeManager changeAdress: adModel];

    
//    [self.BaseTableView reloadData];
//    self.dataArray = [CollectionAndLikeManager addressCounts:1];
//    
//    [self.BaseTableView reloadData];
    
}
// 删除地址
-(void)deleteAdress:(UIButton *)sender {

    
      NSDictionary * dict = @{@"detailAdress":@"杭州市西湖区文一西路",@"adress":@"浙江杭州",@"phone":@"56784321",@"consigneeName":@"印度阿三",
                                                                       };
     AdressFmdbModel * adModel = [[AdressFmdbModel alloc] initWithDict:dict];
     [CollectionAndLikeManager revoveAdress: adModel];
     
     self.dataArray = [CollectionAndLikeManager addressCounts:1];
    
    [self.BaseTableView reloadData];
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
