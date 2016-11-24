//
//  TaskDetailViewController.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/27.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "TaskDetailViewController.h"



@interface TaskDetailViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UIImageView * headImageView;

@property (nonatomic ,strong) AVPlayer * player;

@property (nonatomic,strong) NSString * filePath;

@property (nonatomic,strong) NSURL * fileUrl;



@end

@implementation TaskDetailViewController

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self setUp];
}

-(void)setUp {
    
    
    UIImageView * headImageView = [[UIImageView alloc] init];
    self.headImageView = headImageView;
    headImageView.backgroundColor = [UIColor clearColor];
    headImageView.contentMode = UIViewContentModeScaleAspectFit ;
    [self.view addSubview:headImageView];
    
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.left.and.right.equalTo(headImageView.superview);
        make.height.equalTo(@400);
    }];
    //self.headImageView.image = [UIImage imageNamed:@"640x960.png"];
    
    // 返回
    UIButton * backbtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    backbtn.frame = CGRectMake(10, 20, 30,30);
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
    UIButton * recordbtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    recordbtn.backgroundColor = [UIColor colorWithRed:251/255.0 green:75/255.0 blue:96/255.0 alpha:1];
    recordbtn.layer.masksToBounds = YES;
    recordbtn.layer.cornerRadius = 10.0;
    [recordbtn setTitle:@"视频录制" forState:UIControlStateNormal];
    [recordbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    recordbtn.tag = 112;
    //    [backbtn setBackgroundImage:[UIImage imageNamed:@"back@2x.png"] forState:UIControlStateNormal];
    [recordbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recordbtn];
    
    [recordbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(recordbtn.superview).offset(30);
        make.right.equalTo(recordbtn.superview).offset(-30);
        make.top.equalTo(headImageView.mas_bottom).offset(20);
        make.height.equalTo(@40);

        
    }];
    
    
    // 返回
    UIButton * uploadbtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    uploadbtn.backgroundColor = [UIColor colorWithRed:251/255.0 green:75/255.0 blue:96/255.0 alpha:1];
    uploadbtn.layer.masksToBounds = YES;
    uploadbtn.layer.cornerRadius = 10.0;
    [uploadbtn setTitle:@"上传认证" forState:UIControlStateNormal];
    [uploadbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    uploadbtn.tag = 113;
    //    [backbtn setBackgroundImage:[UIImage imageNamed:@"back@2x.png"] forState:UIControlStateNormal];
    [uploadbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:uploadbtn];
    
    [uploadbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(uploadbtn.superview).offset(30);
        make.right.equalTo(uploadbtn.superview).offset(-30);
        make.top.equalTo(recordbtn.mas_bottom).offset(20);
        make.height.equalTo(@40);
        
        
    }];
    
    
    
    
}

-(void)back:(UIButton *)btn {
    

    switch (btn.tag) {
        case 111:
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
            case 112:
        {
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;

            picker.videoQuality = UIImagePickerControllerQualityTypeHigh; //录像质量
            picker.videoMaximumDuration = 20.0f; // 限制视频录制最多不超过5分钟
            picker.mediaTypes = @[(NSString *)kUTTypeMovie];
            
            [self presentViewController:picker animated:YES completion:^{
                
            }];
            
          
        }
            
            break;
            case 113:
        {
            
          // NSData * data = [NSData dataWithContentsOfURL:self.fileUrl];
           // NSData * data = [NSData dataWithContentsOfFile:self.filePath];
            
            [SLTool updatevideoOrPhoto:@"AUTH_VIDEO" url:self.fileUrl image:nil success:^(id success) {
                
                BaseModel *model = [[BaseModel alloc] initWithDict:success];
                if ([model.success intValue] == 1) {
                    [SLProressHUD showSuccessMessage:@"上传视频成功" afterDelay:2.0];
                }
                else {
                
                    [SLProressHUD showSuccessMessage:model.message afterDelay:2.0];
                }
                
            } failure:^(NSError * error) {
                
                
            }];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark UIImagePickerControllerDelegate,UINavigationControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if([type isEqualToString:@"public.movie"]){
        //视频保存后 播放视频
        NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
        NSString *urlPath = [url path];
        
        AVURLAsset * asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:urlPath]];
        
        CMTime   time = [asset duration];
        int seconds = ceil(time.value/time.timescale);
        
        NSInteger   fileSize = [[NSFileManager defaultManager] attributesOfItemAtPath:urlPath error:nil].fileSize;
        CGFloat size = fileSize/1024.0/1024.0;
        
        self.filePath = urlPath;
        
        [SLProressHUD showSuccessMessage:[NSString stringWithFormat:@"时长%d秒 大小是%.1fM",seconds,size] afterDelay:2.0];

        
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlPath)) {
            
            UISaveVideoAtPathToSavedPhotosAlbum(urlPath, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
        }
    }
    
    
    NSURL *sourceURL = [info objectForKey:UIImagePickerControllerMediaURL];
    NSURL *newVideoUrl ; //一般.mp4
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    newVideoUrl = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]]] ;//这个是保存在app自己的沙盒路径里，后面可以选择是否在上传后删除掉。我建议删除掉，免得占空间。
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self convertVideoQuailtyWithInputURL:sourceURL outputURL:newVideoUrl completeHandler:nil];
    

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//视频保存后的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:( void *)contextInfo{
    
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
        //录制完之后自动播放
        NSURL *url=[NSURL fileURLWithPath:videoPath];
        _player=[AVPlayer playerWithURL:url];
        AVPlayerLayer *playerLayer=[AVPlayerLayer playerLayerWithPlayer:_player];
        playerLayer.frame = self.headImageView.frame;
        [self.headImageView.layer addSublayer:playerLayer];
        [_player play];
    }
}

// 视频压缩转码
- (void) convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                               outputURL:(NSURL*)outputURL
                         completeHandler:(void (^)(AVAssetExportSession*))handler
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
    //  NSLog(resultPath);
    exportSession.outputURL = outputURL;
    self.fileUrl = outputURL;
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse= YES;
    [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
     {
         switch (exportSession.status) {
             case AVAssetExportSessionStatusCancelled:
                 NSLog(@"AVAssetExportSessionStatusCancelled");
                 break;
             case AVAssetExportSessionStatusUnknown:
                 NSLog(@"AVAssetExportSessionStatusUnknown");
                 break;
             case AVAssetExportSessionStatusWaiting:
                 NSLog(@"AVAssetExportSessionStatusWaiting");
                 break;
             case AVAssetExportSessionStatusExporting:
                 NSLog(@"AVAssetExportSessionStatusExporting");
                 break;
             case AVAssetExportSessionStatusCompleted:
                 NSLog(@"AVAssetExportSessionStatusCompleted");
                
                 break;
             case AVAssetExportSessionStatusFailed:
                 NSLog(@"AVAssetExportSessionStatusFailed");
                 break;
         }
         
     }];
    
}

-(void)uploadVideo:(NSURL*)URL {




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
