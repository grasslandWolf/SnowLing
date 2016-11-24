//
//  RegisterViewController.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/25.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *pswTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@property (nonatomic,strong) NSString * codeStr;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   // self.view.backgroundColor = [UIColor yellowColor];
    self.navigationController.navigationBarHidden = NO;
    
    self.registerBtn.layer.cornerRadius = 10.0f;
    self.registerBtn.layer.masksToBounds = YES;
    
    self.codeBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.codeBtn.layer.borderWidth = 1.0f;
    self.codeBtn.layer.masksToBounds = YES;
    self.codeBtn.layer.cornerRadius = 10.0f;
    
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pswTF.secureTextEntry = YES;
    self.pswTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.title = @"注册";
    
    
}
- (IBAction)register:(id)sender {
    
    [self.view endEditing:YES];
    
    if ([self.phoneTF.text isEqualToString:@""]){
    
    
        [SLProressHUD showErrorMessage:@"手机号码不能为空" afterDelay:2.0];
        return;
    }
    
    else if (![self.codeTF.text isEqualToString:self.codeStr]) {
        
        [SLProressHUD showErrorMessage:@"请输入正确的验证码" afterDelay:2.0];
        return;

    
    } else if (![SLTool isMobileNumber:self.phoneTF.text]) {
    
        [SLProressHUD showErrorMessage:@"请输入正确的手机号码" afterDelay:2.0];
        return;
    }
    
    
    
    [SLTool register:self.phoneTF.text codeStr:self.codeTF.text password:self.pswTF.text success:^(id success) {
        
        
        if ([[success objectForKey:@"success"] integerValue]==1) {
            
            NSDictionary * dict = [success objectForKey:@"data"];
            UserModel * BSmodel = [[UserModel alloc] initWithDict:dict];
            
            NSString * psw = BSmodel.password;
            
            NSString * phone = BSmodel.phone;
            
            [SLTool saveToDefaults:psw key:PassWordKey];
            
            [SLTool saveToDefaults:phone key:phoneKey];
            
            
        } else if ([[success objectForKey:@"success"] integerValue]==0) {
            
            NSDictionary * dict = [success objectForKey:@"data"];
            BaseModel * BSmodel = [[BaseModel alloc] initWithDict:dict];
            NSString * message =BSmodel.message;

            [SLProressHUD showSuccessMessage:message afterDelay:1.0];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
        
        
        
    } failure:^(NSError * error) {
        
        NSString * message = error.description;
        [SLProressHUD showSuccessMessage:message afterDelay:2.0];
    }];
    
   
}
- (IBAction)codeBtn:(UIButton *)sender {
    
    if ([self.phoneTF.text isEqualToString:@""]) {
        [SLProressHUD showErrorMessage:@"手机号码不能为空" afterDelay:2.0];
        return;
    } else {
    
        __block int timeout= 60; //倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [self.codeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                    self.codeBtn.userInteractionEnabled = YES;
                });
            }else{
                int seconds = timeout % 61;
                NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    //NSLog(@"____%@",strTime);
                    [UIView beginAnimations:nil context:nil];
                    [UIView setAnimationDuration:1];
                    [self.codeBtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                    [UIView commitAnimations];
                    self.codeBtn.userInteractionEnabled = NO;
                });
                timeout--;
            }
        });
        dispatch_resume(_timer);
    
    }
 
    
    [SLTool getCode:self.phoneTF.text success:^(id success)  {
        
        if ([[success objectForKey:@"success"] integerValue]==1) {
            
            NSDictionary * dict = [success objectForKey:@"data"];
            BaseModel * BSmodel = [[BaseModel alloc] initWithDict:dict];
            
            NSString * code = BSmodel.code;
            self.codeStr = code;
            
            [SLProressHUD showSuccessMessage:[NSString stringWithFormat:@"验证码是%@",code] afterDelay:2.0];
        } else {
            
            [SLProressHUD showSuccessMessage:@"发送频繁" afterDelay:2.0];
        }
        
    } failure:^(NSError * error) {
        
        
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
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
