//
//  ForgetPswViewController.m
//  SnowLing
//
//  Created by 刘新乐 on 16/10/25.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "ForgetPswViewController.h"

@interface ForgetPswViewController ()
@property (weak, nonatomic) IBOutlet UIButton *determineBtn;

@end

@implementation ForgetPswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    self.determineBtn.layer.masksToBounds = YES;
    self.determineBtn.layer.cornerRadius = 10.0f;
    
}
- (IBAction)determineBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
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
