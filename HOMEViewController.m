//
//  HOMEViewController.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/24.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "HOMEViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"



#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height



@interface HOMEViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>

@property (nonatomic,strong) BMKMapView * mapView;

@property (nonatomic,strong) BMKLocationService * locationService;

@property (nonatomic,strong) BMKPointAnnotation * pointAnnotation;


@end

@implementation HOMEViewController

-(void)viewWillAppear:(BOOL)animated {
    
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    
  
}
-(void)jumpPage:(NSNotification*)notification {
    
    
    // NSDictionary * dict = notification.userInfo;
    
    LoginViewController * loginVC = [[LoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    
//    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"address.sqlite"];
//    [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpPage:) name:userInfoNotification object:nil ];
    
    NSString * num = @"178.09";
    NSArray * numArr = [num componentsSeparatedByString:@"."];
    
    NSLog(@"获取到的数组是%@",numArr);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 200, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:17];
    label.textColor = [UIColor purpleColor];
    label.text = @"1708.09";
    
    NSMutableAttributedString *maxAttStr = [[NSMutableAttributedString alloc] initWithString:label.text];
    [maxAttStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(label.text.length - 3, 3)];
    
    label.attributedText = maxAttStr;
    
    [self.view addSubview:label];
    
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth/2 - 100, 44)];
    titleLabel.backgroundColor = COLOR_CLEAR;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"53度";
    self.navigationItem.titleView = titleLabel;
    
    
    
    // 返回
    UIButton * backbtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    backbtn.frame = CGRectMake(10, 100, 30,30);
    backbtn.backgroundColor = [UIColor colorWithRed:251/255.0 green:75/255.0 blue:96/255.0 alpha:1];
    backbtn.layer.masksToBounds = YES;
    backbtn.layer.cornerRadius = 15.0;
    [backbtn setTitle:@"返" forState:UIControlStateNormal];
    [backbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backbtn.tag = 111;
    //    [backbtn setBackgroundImage:[UIImage imageNamed:@"back@2x.png"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbtn];
    
    
    // 返回
    UIButton * loginOutbtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    loginOutbtn.frame = CGRectMake(SCREEN_WIDH - 50, 100, 80,80);
    loginOutbtn.backgroundColor = [UIColor colorWithRed:251/255.0 green:75/255.0 blue:96/255.0 alpha:1];
    loginOutbtn.layer.masksToBounds = YES;
    loginOutbtn.layer.cornerRadius = 40.0f;
    loginOutbtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [loginOutbtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [loginOutbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginOutbtn.tag = 112;
    //    [backbtn setBackgroundImage:[UIImage imageNamed:@"back@2x.png"] forState:UIControlStateNormal];
    [loginOutbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginOutbtn];
    
    
    BMKMapView * mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 400, SCREEN_WIDH, 330)];
    mapView.userTrackingMode = BMKUserTrackingModeNone;
    mapView.showsUserLocation = YES;
    self.mapView = mapView;
    [self.view addSubview:mapView];
    
    BMKLocationService * locationService = [[BMKLocationService alloc] init];
    locationService.delegate = self;
    self.locationService = locationService;
    if (IOS9_OR_LATER) {
        [locationService setAllowsBackgroundLocationUpdates:YES];
    }
    [locationService startUserLocationService]; //  开启定位服务
    
    BMKPointAnnotation * pointAnnotation = [[BMKPointAnnotation alloc] init];
    self.pointAnnotation = pointAnnotation;
    [mapView addAnnotation:pointAnnotation];
    [mapView selectAnnotation:pointAnnotation animated:YES];
    
    
}
-(void)back:(UIButton *)btn {
    
    switch (btn.tag) {
        case 111:
        {
            
            if (![SLTool isLogin]) {
                
                LoginViewController * loginVC = [[LoginViewController alloc] init];
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
                [self presentViewController:nav animated:YES completion:^{
                    
                }];
                
            } else {
                
                
                [SLProressHUD showSuccessMessage:@"已经登录" afterDelay:2.0];
            }
        
        }
            
            break;
            case 112:
        { [SLTool removeDefaults:TokenKey];
            [SLTool removeDefaults:phoneKey];
            [SLTool removeDefaults:PassWordKey];
            [SLProressHUD showSuccessMessage:@"退出登录" afterDelay:2.0];
            
//            dispatch_sync(dispatch_get_global_queue(0, 0), ^{
//                [self uploadImage];
//
//            });
            [self uploadImage];
            
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            [defaults removeObjectForKey:@"photoimageArr"];
            [defaults synchronize];

        }
            break;
            
        default:
            break;
    }
    
    
   
}
// 上传头像到服务器

-(void)uploadImage {


    NSString * url = [NSString stringWithFormat:@"%@/upload",KURL];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSTimeInterval timeInterval = 30;
    manager.requestSerializer.timeoutInterval =timeInterval;
    
    NSDictionary * dict = @{@"type":@"AVATOR"};
    [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        // 上传的时候需要对PNG图片进行一个压缩  不然的话图片太大 从相机拍照或者从相册选择的图片都可以进行压缩操作 如果是已知的图片要按照图片的类型进行修改png或者pig
        
        UIImage * image = [UIImage imageNamed:@"180.png"];
        
       // NSData  * data= UIImageJPEGRepresentation(image, 1);
        NSData * daTa = UIImagePNGRepresentation(image);

        
        [formData appendPartWithFileData:daTa name:@"file" fileName:@".png" mimeType:@"image/png"];
     
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
}

#pragma mark BMKMapViewDelegate

-(BMKAnnotationView*)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;

}
#pragma mark  BMKLocationServiceDelegate
-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {

    [self.mapView updateLocationData:userLocation];
    self.pointAnnotation.coordinate = userLocation.location.coordinate;
    self.mapView.centerCoordinate = self.pointAnnotation.coordinate;
    [self getCity:userLocation.location];
}
-(void)didFailToLocateUserWithError:(NSError *)error {

    [SLProressHUD showErrorMessage:@"定位失败" afterDelay:2.0];
}
// 获取城市信息
-(void)getCity:(CLLocation*)userLocation {
    
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:userLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark * placemark = [placemarks objectAtIndex:0];
        if (placemark.subLocality != nil) {
            NSString * mapProvincesName = placemark.administrativeArea;// 省份
            NSString * mapCityName = placemark.locality;//城市
            NSString * mapAreaName = placemark.subLocality;//区
           // NSString * mapThoroughfare = placemark.thoroughfare;//街道
//            NSString *mapCity=[NSString stringWithFormat:@"%@-%@-%@",mapCityName,mapAreaName,mapThoroughfare];
            NSString *mapCity=[NSString stringWithFormat:@"%@-%@-%@",mapProvincesName,mapCityName,mapAreaName];
            if (!mapCityName) {
                mapCityName = placemark.administrativeArea;
                mapCity = [NSString stringWithFormat:@"%@-%@",mapCityName,mapAreaName];
            }
          
              self.pointAnnotation.title = mapCity;
            [self.locationService stopUserLocationService]; // 定位成功后关闭
        }
    }];
    


}
-(void)viewWillDisappear:(BOOL)animated {
    
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
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
