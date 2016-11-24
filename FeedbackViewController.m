//
//  FeedbackViewController.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/28.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (nonatomic,strong) UIButton * backbtn;

@property(nonatomic,strong) UIImagePickerController *imagePicker;

@property (nonatomic,assign)  NSInteger selectTag;

@property (nonatomic,strong) UIButton * uploadPhotoBtn;

@property (nonatomic,strong) NSMutableArray * emptyArr;

@property (nonatomic,strong) UIImageView * siximageView;

@property (nonatomic,strong) UIButton * sixBtn;

@property (nonatomic,strong) UIImageView * sevenimageView;

@property (nonatomic,strong) UIScrollView * backScrollView;



@end

@implementation FeedbackViewController

//-(NSMutableArray *)photosArray {
//
//
//    if (_photosArray) {
//        _photosArray = [NSMutableArray array];
//        
//    }
//    return _photosArray;
//}

//-(void)viewWillAppear:(BOOL)animated {
//    
//    [super viewWillAppear:animated];
//
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//    NSMutableArray * numbers = [defaults objectForKey:@"photoImage"];
//    for (int i = 0; i < numbers.count; i++) {
//        
//        NSData * data = numbers[i];
//        UIImage * image = [[UIImage alloc] initWithData:data];
//        [self.imageArr addObject:image];
//    }
//    
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"反馈";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    self.imagePicker.allowsEditing = YES;
    
    self.imageArr = [NSMutableArray arrayWithCapacity:0];
    // 空数组
    self.emptyArr = [NSMutableArray arrayWithCapacity:0];
    
    self.photosArray = [NSMutableArray arrayWithCapacity:0];
    
    [SLProressHUD showSuccessMessage:[NSString stringWithFormat:@"刚进来时图片数量是%lu",(unsigned long)self.imageArr.count] afterDelay:2.0];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * numbers = [defaults objectForKey:@"photoimageArr"];
    NSMutableArray * dataArr = [NSMutableArray array];
    for (int i = 0; i < numbers.count; i++) {
        
        NSData * data = numbers[i];
        UIImage * image = [[UIImage alloc] initWithData:data];
        [dataArr addObject:image];
    }
    self.imageArr = dataArr;
    
    
   [SLProressHUD showSuccessMessage:[NSString stringWithFormat:@"图片数量是%lu",(unsigned long)self.imageArr.count] afterDelay:2.0];
    
    if (self.imageArr.count == 0) {
        UIImage * image = [UIImage imageNamed:@"1@2x.png"];
        self.imageArr = [NSMutableArray arrayWithObjects:image,image,image,image,image, nil];
    }

    [self setUp];


}
-(void)setUp {
    

    UIScrollView * backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDH, SCREEN_HEIGHT)];
    self.backScrollView = backScrollView;
    backScrollView.contentSize = CGSizeMake(SCREEN_WIDH, SCREEN_HEIGHT );
    [self.view addSubview:backScrollView];
    
    
    UIButton * uploadPhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    uploadPhotoBtn.backgroundColor = [UIColor cyanColor];
    uploadPhotoBtn.frame = CGRectMake(15, SCREEN_HEIGHT - 134, SCREEN_WIDH -30, 40);
    [uploadPhotoBtn setTitle:@"立即上传" forState:UIControlStateNormal];
    [uploadPhotoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [uploadPhotoBtn addTarget:self action:@selector(uploadPhoto:) forControlEvents:UIControlEventTouchUpInside];
    uploadPhotoBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    self.uploadPhotoBtn = uploadPhotoBtn;
    //    [self.view addSubview:uploadPhotoBtn];
    [backScrollView addSubview:uploadPhotoBtn];
    
    
    
    if (self.imageArr.count >6) {
        self.backScrollView.contentSize = CGSizeMake(SCREEN_WIDH, SCREEN_HEIGHT + 200);
        self.uploadPhotoBtn.frame = CGRectMake(15, SCREEN_HEIGHT, SCREEN_WIDH-30, 40);
        
    }

    
//    NSArray *titleArr = [NSArray arrayWithObjects:@"场景照",@"自拍照",@"素颜照",@"全身照",@"侧身照",@"自由照",@"自由照",@"自由照", nil];
    for (NSInteger i = 0; i < self.imageArr.count; i++) {
        UIImageView * photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + (SCREEN_WIDH - 40)/3 * (i%3) + 10 * (i%3), 10.5f + 190 * (i/3), (SCREEN_WIDH - 40)/3, (SCREEN_WIDH - 40)/3 + 40)];
        //        [necePhotoImage setImage:[UIImage imageNamed:imagArr[i]]];
        // [necePhotoImage setImage:imageArr[i]];
        photoImageView.image = self.imageArr[i];
        photoImageView.backgroundColor = [UIColor yellowColor];
//        [self.view addSubview:photoImageView];
        photoImageView.alpha = 0.6;
        photoImageView.layer.cornerRadius = 10;
        photoImageView.layer.masksToBounds = YES;
        photoImageView.tag = i + 200;
        photoImageView.userInteractionEnabled = YES;
        [backScrollView addSubview:photoImageView];
       
        
        UIButton * backbtn = [UIButton  buttonWithType:UIButtonTypeCustom];
        backbtn.frame = photoImageView.frame;
        backbtn.tag = i + 200;
        backbtn.backgroundColor = [UIColor clearColor];
        self.backbtn = backbtn;
        [backbtn addTarget:self action:@selector(imageArrelected:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:backbtn];
        [backScrollView addSubview:backbtn];
        

    }
    
    
 
    
//    [uploadPhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(backScrollView.mas_bottom).offset(-70);
//        make.left.equalTo(backScrollView.mas_left).offset(15);
//        make.right.equalTo(backScrollView.mas_right).offset(-15);
//        make.height.equalTo(@40);
//    }];
//    
    
    
    int  i= 5;
    UIImageView * photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + (SCREEN_WIDH - 40)/3 * (i%3) + 10 * (i%3), 10.5f + 190 * (i/3), (SCREEN_WIDH - 40)/3, (SCREEN_WIDH - 40)/3 + 40)];
   // photoImageView.image = self.imageArr[i];
    photoImageView.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:photoImageView];
    photoImageView.alpha = 0.6;
    photoImageView.layer.cornerRadius = 10;
    photoImageView.layer.masksToBounds = YES;
    photoImageView.tag = i + 200;
    photoImageView.userInteractionEnabled = YES;
    photoImageView.hidden = YES;
    self.siximageView = photoImageView;
    [backScrollView addSubview:photoImageView];
    
    UIButton * backbtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    backbtn.frame = photoImageView.frame;
    backbtn.tag = i + 200;
    backbtn.backgroundColor = [UIColor clearColor];
    self.sixBtn = backbtn;
    backbtn.hidden = YES;
    [backbtn addTarget:self action:@selector(imageArrelected:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:backbtn];
    [backScrollView addSubview:backbtn];
    

    //[self siximageView];
    [self sevenImageView];
    
   


}
-(void)sixImageView {

    int  i= 5;
    UIImageView * photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + (SCREEN_WIDH - 40)/3 * (i%3) + 10 * (i%3), 10.5f + 190 * (i/3), (SCREEN_WIDH - 40)/3, (SCREEN_WIDH - 40)/3 + 40)];
    photoImageView.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:photoImageView];
    photoImageView.alpha = 0.6;
    photoImageView.layer.cornerRadius = 10;
    photoImageView.layer.masksToBounds = YES;
    photoImageView.tag = i + 200;
    photoImageView.userInteractionEnabled = YES;
    photoImageView.hidden = YES;
    self.siximageView = photoImageView;
    [self.backScrollView addSubview:photoImageView];
    
    UIButton * backbtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    backbtn.frame = photoImageView.frame;
    backbtn.tag = i + 200;
    backbtn.backgroundColor = [UIColor clearColor];
    self.backbtn = backbtn;
    [backbtn addTarget:self action:@selector(imageArrelected:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:backbtn];
    [self.backScrollView addSubview:backbtn];
}

-(void)sevenImageView {
    
    int  i= 6;
    UIImageView * photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + (SCREEN_WIDH - 40)/3 * (i%3) + 10 * (i%3), 10.5f + 190 * (i/3), (SCREEN_WIDH - 40)/3, (SCREEN_WIDH - 40)/3 + 40)];
    photoImageView.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:photoImageView];
    photoImageView.alpha = 0.6;
    photoImageView.layer.cornerRadius = 10;
    photoImageView.layer.masksToBounds = YES;
    photoImageView.tag = i + 200;
    photoImageView.userInteractionEnabled = YES;
    photoImageView.hidden = YES;
    self.sevenimageView = photoImageView;
    [self.backScrollView addSubview:photoImageView];
    
    UIButton * backbtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    backbtn.frame = photoImageView.frame;
    backbtn.tag = i + 200;
    backbtn.backgroundColor = [UIColor clearColor];
    self.backbtn = backbtn;
    [backbtn addTarget:self action:@selector(imageArrelected:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:backbtn];
    [self.backScrollView addSubview:backbtn];
}


// 上传
-(void)uploadPhoto:(UIButton*)btn {

    if (self.emptyArr.count < 5) {
        [SLProressHUD showErrorMessage:@"至少上传五张照片" afterDelay:2.0];
    }
//    } else {
//    
//        [SLProressHUD showSuccessMessage:@"上传成功" afterDelay:2.0];
//    }
    if (self.emptyArr.count == 6 && self.imageArr.count < self.emptyArr.count) {
        [SLProressHUD showErrorMessage:@"请上传第六张图片" afterDelay:2.0];

    }

}
//
-(void)imageArrelected:(UIButton *)btn {
    
    self.selectTag = btn.tag;

    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pickImageFromCamera]; //从摄像头获取活动图片
    }];
    
    UIAlertAction *selectAction = [UIAlertAction actionWithTitle:@"相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pickImageFromAlbum]; //从用户相册获取活动图片
    }];
    [alert addAction:cameraAction];
    [alert addAction:selectAction];
    [alert addAction:cancleAction];
    [self presentViewController:alert animated:YES completion:^{
        
    }];


}

- (void)pickImageFromCamera
{
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
    
}

- (void)pickImageFromAlbum
{
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
    
}

#pragma mark
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [self.photosArray removeAllObjects];
    long index = self.selectTag - 200;
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIImageView * imageView = (UIImageView*)[self.view viewWithTag:self.selectTag];
    imageView.image = image;
    
    NSString * number = [NSString stringWithFormat:@"%ld",(long)index];

    
    if (self.emptyArr.count == 0) {
        
        [self.emptyArr addObject:number];
    } else {
    
        if (![self.emptyArr containsObject:number]) {
            [self.emptyArr addObject:number];
        }
    }
    if (self.emptyArr.count < 5) {
        
        [self.imageArr replaceObjectAtIndex:index withObject:image];
        
    } else {
    
        if (self.emptyArr.count == 5) {
            
            // [self.imageArr insertObject:image atIndex:5];
            self.siximageView.hidden = NO;
            self.sixBtn.hidden = NO;
            [SLProressHUD showSuccessMessage:@"成功添加第六张照片" afterDelay:2.0];
        }
        
        if (self.emptyArr.count == 6) {
            
            self.backScrollView.contentSize = CGSizeMake(SCREEN_WIDH, SCREEN_HEIGHT + 200);
            self.uploadPhotoBtn.frame = CGRectMake(15, SCREEN_HEIGHT, SCREEN_WIDH -30, 40);
            self.sevenimageView.hidden = NO;
            
            [self.imageArr insertObject:image atIndex:5];
            [SLProressHUD showSuccessMessage:@"成功添加第七张照片照片" afterDelay:2.0];
        }
        
        if (self.emptyArr.count == 7) {
            
            [self.imageArr insertObject:image atIndex:6];
            [SLProressHUD showSuccessMessage:@"成功添加第八张照片照片" afterDelay:2.0];
        }
        

    
    }
    

    for (int i = 0 ; i< self.imageArr.count; i++) {
        
//        self.photosArray = [NSMutableArray array];
        UIImage * image = self.imageArr[i];
        NSData * data = UIImageJPEGRepresentation(image, 0.5);
        [self.photosArray addObject:data];
        
    }
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.photosArray forKey:@"photoimageArr"];
    [defaults synchronize];
    
    [SLProressHUD showSuccessMessage:[NSString stringWithFormat:@"数量是%lu",(unsigned long)self.photosArray.count] afterDelay:2.0];

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
