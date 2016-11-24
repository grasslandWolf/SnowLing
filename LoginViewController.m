//
//  LoginViewController.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/24.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "LoginViewController.h"

#import "RegisterViewController.h"// 注册

#import "ForgetPswViewController.h"// 忘记密码

@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *pswTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UIButton *back;
@property (weak, nonatomic) IBOutlet UIButton *login;

@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pswTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameTF.keyboardType = UIKeyboardTypeNumberPad;

    
    NSString * phone = [SLTool getMessageFromDefaults:phoneKey];
    
    NSString * passWord = [SLTool getMessageFromDefaults:PassWordKey];
    
    if (![phone isEqualToString:@""] || ![passWord isEqualToString:@""]) {
        
        self.nameTF.text = phone;
        self.pswTF.text = passWord;
    }
    
    [self setUp];
    
}

-(void)setUp {

    self.back.layer.cornerRadius = 15.0f;
    self.back.layer.masksToBounds = YES;
    
    self.login.layer.cornerRadius = 10.0f;
    self.login.layer.masksToBounds = YES;
    
    self.nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pswTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.nameTF.delegate = self;
    self.pswTF.delegate = self;
    
    [self.nameTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.nameTF) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}

- (IBAction)Login:(id)sender {
    
    
   // [SLTool login:<#(NSString *)#> password:<#(NSString *)#>];
    
    if ([self.nameTF.text isEqualToString:@""] || [self.pswTF.text isEqualToString:@""]) {
        
    [SLProressHUD showErrorMessage:@"账户或密码不能为空" afterDelay:2.0];
        return;

    } else if (![SLTool isMobileNumber:self.nameTF.text]) {
    
        [SLProressHUD showErrorMessage:@"请输入正确的手机号码" afterDelay:2.0];
        return;
    }
    
    
    
    [SLTool login:self.nameTF.text password:self.pswTF.text success:^(id success) {
        
        NSDictionary * dict = [success objectForKey:@"data"];

//        BaseModel * model = [[BaseModel alloc] initWithDict:dict];
//        NSString * message = model.message;
        
//        if ([[success objectForKey:@"success"] integerValue]==1) {
        
            UserModel * BSmodel = [[UserModel alloc] initWithDict:dict];
            
            NSString * token = BSmodel.token;
            
            NSString * psw = BSmodel.password;
            
            NSString * phone = BSmodel.phone;
            
            [SLTool saveToDefaults:psw key:PassWordKey];
            
            [SLTool saveToDefaults:phone key:phoneKey];
            
            [SLTool saveToDefaults:token key:TokenKey];
            
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            
//        } else {
//        
//            [SLProressHUD showSuccessMessage:message afterDelay:2.0];
//        }
        
    } failure:^(NSError * error) {
        
    }];
    
//    NSLog(@"获取的内容是 %@",dict);
    
}
- (IBAction)Back:(id)sender {
     
    [self.view endEditing:YES];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
   // [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)registerAcount:(id)sender {
    
    RegisterViewController * registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
//    [self presentViewController:registerVC animated:YES completion:^{
//        
//    }];
}

- (IBAction)forgetPsw:(id)sender {
    
    ForgetPswViewController * forgetVC = [[ForgetPswViewController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
    
}

#pragma mark 键盘代理
-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    
    return YES;
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
