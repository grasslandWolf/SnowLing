//
//  AddAdressViewController.m
//  SnowLing
//
//  Created by 刘新乐 on 16/11/14.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "AddAdressViewController.h"

#import "AddAdressTableViewCell.h"

#import "AdressFmdbModel.h"



@interface AddAdressViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager * locationManager;
@property (nonatomic,strong) NSString * currentCity;

@end

@implementation AddAdressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.type == 2) {
        [self initTitleView:@"新增地址"];
    } else if (self.type == 5) {
    
        [self initTitleView:@"修改地址"];
    }
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = COLOR_BACK;
    [self setUp];
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,40,20)];
    [rightButton setTitle:@"发布" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(release:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
}
-(void)release:(UIButton *)sender {
    [self.view endEditing:YES];

    NSInteger index ;
    UITextField * nameTF = [[UITextField alloc] init];
    UITextField * phoneTF = [[UITextField alloc] init];
    UITextField * addressTF = [[UITextField alloc] init];
    UITextField * detailAdressTF = [[UITextField alloc] init];
    for (int i = 0; i< 4; i++) {
        index = i;
        AddAdressTableViewCell * cell = nil;
        switch (index) {
            case 0:
            {
                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
                cell = [self.BaseTableView cellForRowAtIndexPath:indexPath];
                nameTF = cell.titleTF ;

            }
                break;
            case 1:
            {
                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
                cell = [self.BaseTableView cellForRowAtIndexPath:indexPath];
                phoneTF = cell.titleTF;
             
            }
                break;
            case 2:
            {
                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
                cell = [self.BaseTableView cellForRowAtIndexPath:indexPath];
                addressTF = cell.titleTF;

                
            }
                break;
            case 3:
            {
                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
                cell = [self.BaseTableView cellForRowAtIndexPath:indexPath];
                detailAdressTF = cell.titleTF ;
                
            }
                break;
                
            default:
                break;
        }

    }
    
    if ([nameTF.text isEqualToString:@""]) {
        [SLProressHUD showErrorMessage:@"请输入收货人的名字" afterDelay:2.0];
        return;
    } else if ([phoneTF.text isEqualToString:@""]) {
        [SLProressHUD showErrorMessage:@"手机号码不能为空" afterDelay:2.0];
        return;
    } else if (phoneTF.text.length != 11) {
        [SLProressHUD showErrorMessage:@"请输入正确的手机号码" afterDelay:2.0];
        return;
    } else if ([addressTF.text isEqualToString:@""]) {
        [SLProressHUD showErrorMessage:@"请输入收货人的地址" afterDelay:2.0];
        return;
    } else if ([detailAdressTF.text isEqualToString:@""]) {
        [SLProressHUD showErrorMessage:@"请输入收货人的详细地址" afterDelay:2.0];
        return;
    }
    NSDictionary * dict = @{@"addressID":phoneTF.text,
                            @"detailAdress":detailAdressTF.text,
                            @"adress":addressTF,
                            @"phone":phoneTF.text,
                            @"consigneeName":nameTF.text,
                            };
    AdressFmdbModel * model = [[AdressFmdbModel alloc] initWithDict:dict];
    [CollectionAndLikeManager addAdress:model];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
-(void)setUp {

    [self configureTableViewAndFrame:CGRectMake(0, 0, SCREEN_WIDH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    
    

}
#pragma mark UITableViewDelegate,UITableViewDataSource 

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    AddAdressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[AddAdressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"收货人";
            cell.titleTF.placeholder = @"请输入收货人的姓名";
            break;
        case 1:
            cell.titleTF.keyboardType = UIKeyboardTypeNumberPad;
            cell.titleLabel.text = @"手机号码";
            cell.titleTF.placeholder = @"请输入收货人的手机号码";
            break;
        case 2:{
            cell.titleLabel.text = @"省市区";
            cell.locationbtn.hidden = NO;
            cell.btnClick = ^{
                [self startLocation];
            };
        }
            break;
        case 3:
            cell.titleLabel.text = @"详细地址";
            cell.titleTF.placeholder = @"请输入收货人的详细地址";
            break;
        default:
            break;
    }
  
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.01;
}

// 开启定位
-(void)startLocation {

    [self.view endEditing:YES];
    self.locationManager = [[CLLocationManager alloc] init];
    //判断定位功能是否打开
    if (![CLLocationManager locationServicesEnabled]) {
        [SLProressHUD showErrorMessage:@"系统定位服务尚不可用，请在设置中打开" afterDelay:2.0];
    }else{
        [self.locationManager requestWhenInUseAuthorization];//当应用使用期间请求运行定位
        self.locationManager.delegate = self;
        self.currentCity = [[NSString alloc] init];
        [self.locationManager startUpdatingLocation];
    }

}
#pragma mark CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

    [self.locationManager stopUpdatingLocation];
    CLLocation * userLocation = locations.lastObject;
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:userLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark * placemark = [placemarks objectAtIndex:0];
        
        if (placemark.subLocality != nil) {
            
            NSString * mapProvincesName = placemark.administrativeArea;// 省份
            NSString * mapCityName = placemark.locality;//城市
            NSString * mapAreaName = placemark.subLocality;//区
            
            if (!mapCityName) {
                mapCityName = placemark.administrativeArea;
            }
          //  NSString * mapThoroughfare = placemark.thoroughfare;//街道
//            NSString *mapCity=[NSString stringWithFormat:@"%@-%@-%@",mapCityName,mapAreaName,mapThoroughfare];
            NSString *mapCity=[NSString stringWithFormat:@"%@-%@-%@",mapProvincesName,mapCityName,mapAreaName];
            NSIndexPath * indexpath = [NSIndexPath indexPathForRow:2 inSection:0];
            AddAdressTableViewCell * cell = [self.BaseTableView cellForRowAtIndexPath:indexpath];
            cell.titleTF.text = mapCity;
          //  self.pointAnnotation.title = mapCity;
           // [self.locationService stopUserLocationService]; // 定位成功后关闭
        }
    }];
    
    
    [SLProressHUD showSuccessMessage:@"定位成功" afterDelay:2.0];
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {


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
