//
//  CarViewController.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/24.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "CarViewController.h"
#import "AngleNumberView.h"

#import "OrderPayViewController.h"

@interface CarViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,AngleNumberDelegate>

@property (nonatomic,strong) UIImageView * imageView;

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,strong) UIImage * photoImage;

@property (nonatomic,strong) NSString * filePath;

@property (nonatomic,strong) AngleNumberView * AngleView;

@end

@implementation CarViewController

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
  

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setUp];
}
-(void)setUp {


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
    
    
    
    
    UIButton * backbtn0 = [UIButton  buttonWithType:UIButtonTypeCustom];
    backbtn0.frame = CGRectMake(10, 150, 30,30);
    backbtn0.backgroundColor = [UIColor colorWithRed:251/255.0 green:75/255.0 blue:96/255.0 alpha:1];
    backbtn0.layer.masksToBounds = YES;
    backbtn0.layer.cornerRadius = 15.0;
    [backbtn0 setTitle:@"返" forState:UIControlStateNormal];
    [backbtn0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backbtn0.tag = 112;
    //    [backbtn setBackgroundImage:[UIImage imageNamed:@"back@2x.png"] forState:UIControlStateNormal];
    [backbtn0 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbtn0];
    
    
//    WKWebView * webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDH, SCREEN_HEIGHT - 49)];
//    NSString * str = @"https://detail.tmall.com/item.htm?spm=a230r.1.14.44.DCkN0i&id=535645313363&ns=1&abbucket=3";
//    NSURL * url = [NSURL URLWithString:str];
//    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
////    webView.scalesPageToFit = YES;
//    [webView loadRequest:request];
//    [self.view addSubview:webView];
    
//    for (int i = 0; i < 4; i++) {
//        
//        int row = i/3;
//        int low = i%3;
//        
//        UIImageView * imageView = [[UIImageView alloc] init];
//        imageView.frame = CGRectMake((50 +100)*low, (100 +150)* row, 100, 150);
//        imageView.userInteractionEnabled = YES;
//        imageView.backgroundColor = [UIColor yellowColor];
//        imageView.tag = i + 200;
//        self.imageView = imageView;
//        [self.view addSubview:imageView];
//        
//        
//        UIButton * backbtn = [UIButton  buttonWithType:UIButtonTypeCustom];
//        backbtn.frame = imageView.frame;
//        backbtn.tag = i + 200;
//        backbtn.backgroundColor = [UIColor clearColor];
//        [backbtn addTarget:self action:@selector(ImageSelected:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:backbtn];
//    
//    }
    
    
    
    for (int i = 0; i < 4; i++) {
        
        NSArray * numbers = [NSArray arrayWithObjects:@"5",@"6",@"10",@"11", nil];
        NSArray * titles = [NSArray arrayWithObjects:@"支",@"付",@"测",@"试", nil];
        AngleNumberView * angleView = [[AngleNumberView alloc] init];
        angleView.frame = CGRectMake(50 + (40 +30)*i, 20, 40, 40);
        angleView.delegate = self;
        [angleView.carBtn setTitle:titles[i] forState:UIControlStateNormal];
        self.AngleView = angleView;
        [angleView setShopCarCount:numbers[i]];
        [self.view addSubview:angleView];
        
    }
    
    
    
}
-(void)getNumber {

    OrderPayViewController * orderVC = [[OrderPayViewController alloc] init];
    [self.navigationController pushViewController:orderVC animated:YES];

}


-(void)back:(UIButton *)btn {
    
    

    
    
//      UIImage* image1 = [UIImage imageNamed:@"1.jpg"];
//      UIImage* image2= [UIImage imageNamed:@"1.jpg"];
//      UIImage* image3 = [UIImage imageNamed:@"1.jpg"];
//      UIImage* image4 = [UIImage imageNamed:@"1.jpg"];
//      UIImage* image5 = [UIImage imageNamed:@"1.jpg"];
//
//   
//    
//    NSData * data1 = UIImageJPEGRepresentation(image1, 0.5);
//    NSData * data2 = UIImageJPEGRepresentation(image2, 0.5);
//
//    NSData * data3 = UIImageJPEGRepresentation(image3, 0.5);
//
//    NSData * data4 = UIImageJPEGRepresentation(image4, 0.5);
//
//    NSData * data5 = UIImageJPEGRepresentation(image5, 0.5);
//
////    NSMutableArray * arr = [NSMutableArray arrayWithObjects:image5, image4,image3,image2,image1,nil];
//     NSMutableArray * arr = [NSMutableArray arrayWithObjects:data1, data2,data3,data4,data5,nil];
//    [SLTool uploadPhotos:1 datas:arr success:^(id success) {
//        
//        
//    } failure:^(NSError * error) {
//        
//        
//    }];
    
    switch (btn.tag) {
        case 111:
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.allowsEditing = YES;
            [self presentViewController:picker animated:YES completion:NULL];
        }
            break;
            case 112:
        {
            
            NSMutableArray * arr = [NSMutableArray arrayWithObjects:self.filePath, self.filePath,self.filePath,self.filePath,self.filePath,nil];
//            NSDictionary * dict = [NSDictionary dictionaryWithObject:arr forKey:@"files"];
            NSError * error = nil;
            NSString * token = [SLTool getMessageFromDefaults:TokenKey];

            
            NSString * url = [NSString stringWithFormat:@"%@/v1/auths/create/token/%@",KURL,token];
            
            
//            NSDictionary * dictionary = @{@(1):@"type",
//                                          token:@"token",
//                                          arr:@"files[]"};
//            NSDictionary * dict = [NSDictionary dictionaryWithObjects:@[@(1),token,arr] forKeys:@[@"type",@"token",@"files[]"]];
            
            NSDictionary * dict = [NSDictionary dictionaryWithObjects:@[@(1),arr] forKeys:@[@"type",@"files[]"]];
            
            NSData * data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
            
            NSURL *URL = [NSURL URLWithString:url];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
//            [request setHTTPMethod:@"POST"];
//            [request setHTTPBody:data];
//            
            
            [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];//这一行一定不能少，因为后面是转换成JSON发送的
            [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setHTTPMethod:@"POST"];
            [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
            [request setTimeoutInterval:20];
            
            
            NSURLSession *session = [NSURLSession sharedSession];

            NSURLSessionUploadTask * task = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:Nil];
                NSLog(@"返回的数据内容是 %@",dic);
            }];
            
            [task resume];
            
            

//            [SLTool uploadPhotos:1 datas:arr success:^(id success) {
//                
//                
//            } failure:^(NSError * error) {
//                
//                
//            }];
        
        }
            break;
            
        default:
            break;
    }
    
       
}
-(void)ImageSelected:(UIButton *)gesture {

    self.index = self.imageView.tag;
   

}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    _photoImage = info[UIImagePickerControllerOriginalImage];
    [self saveImage:_photoImage WithName:@"userAvatar.jpg"];
    
    //处理完毕，回到个人信息页面
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* totalPath = [documentPath stringByAppendingPathComponent:imageName];

    self.filePath = totalPath;
    //保存到 document
    [imageData writeToFile:totalPath atomically:NO];
    
    //保存到 NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:totalPath forKey:@"avatar"];
    
    //上传服务器
//    [[HSLoginClass new] uploadAvatar:totalPath];
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
