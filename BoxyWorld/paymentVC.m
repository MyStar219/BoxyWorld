//
//  paymentVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 22/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "paymentVC.h"
#import "config.h"
#import "reviewVC.h"
#import "UserAccessSession.h"
@interface paymentVC ()
{
    
    NSString *select,*pay_with;
    
}

@end

@implementation paymentVC
@synthesize btnDipCard,btnScanCard,btnBoxywordBlnc,btnSaveACont;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeLayout];
    [self barButtonFunction];
   
    

    // Do any additional setup after loading the view.
}
-(void)makeLayout{
    
     self.title = @"PAYMENT";
   // self.title = @"Sent Money";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
   
    
    btnDipCard.layer.borderWidth=1.0f;
    btnDipCard.layer.cornerRadius = btnDipCard.frame.size.width * 0.5;
    [btnDipCard setBackgroundColor:[UIColor whiteColor]];
    btnDipCard.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    btnScanCard.layer.borderWidth=1.0f;
    btnScanCard.layer.cornerRadius = btnScanCard.frame.size.width * 0.5;
    [btnDipCard setBackgroundColor:[UIColor whiteColor]];
    btnDipCard.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    btnBoxywordBlnc.layer.borderWidth=1.0f;
    btnBoxywordBlnc.layer.cornerRadius = btnBoxywordBlnc.frame.size.width * 0.5;
    [btnDipCard setBackgroundColor:[UIColor whiteColor]];
    btnDipCard.layer.borderColor=[UIColor lightGrayColor].CGColor;
   
    
    self.btnSaveACont.layer.borderColor = [UIColor clearColor].CGColor;
    self.btnSaveACont.layer.cornerRadius = 5.0f;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) barButtonFunction
{
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_btn"]
                                                                         style:UIBarButtonItemStylePlain target:self action:@selector(popView:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:navigationBarColor];
    
}
-(void)popView:(UIBarButtonItem *)sender
{
    //[appDel setBothMenus];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnActionDip:(id)sender {
    select = @"3";
    pay_with =@"Card";
    //session.payment_method = [NSString stringWithFormat:@"%@",@"Card Details"];
    btnDipCard.layer.borderWidth=0.0f;
    btnBoxywordBlnc.layer.borderWidth=1.0f;
    btnScanCard.layer.borderWidth=1.0f;
    [btnDipCard setBackgroundColor:[UIColor redColor]];
    [btnScanCard setBackgroundColor:[UIColor whiteColor]];
    [btnBoxywordBlnc setBackgroundColor:[UIColor whiteColor]];
    
}
- (IBAction)btnActionScan:(id)sender {
    select = @"2";
    pay_with =@"Card";
    btnScanCard.layer.borderWidth=0.0f;
    btnBoxywordBlnc.layer.borderWidth=1.0f;
    btnDipCard.layer.borderWidth=1.0f;
    [btnScanCard setBackgroundColor:[UIColor redColor]];
    [btnDipCard setBackgroundColor:[UIColor whiteColor]];
    [btnBoxywordBlnc setBackgroundColor:[UIColor whiteColor]];
}
- (IBAction)btnActionBoxyWorld:(id)sender {
    
    select = @"1";
    pay_with =@"Balance";
    btnBoxywordBlnc.layer.borderWidth=0.0f;
    btnScanCard.layer.borderWidth=1.0f;
    btnDipCard.layer.borderWidth=1.0f;
    [btnBoxywordBlnc setBackgroundColor:[UIColor redColor]];
    [btnDipCard setBackgroundColor:[UIColor whiteColor]];
    [btnScanCard setBackgroundColor:[UIColor whiteColor]];
}
- (IBAction)btnActionSaveAContinue:(id)sender {
     UserSession *session = [UserAccessSession getUserSession];
    if([select isEqualToString:@"1"]){
         session.payment_method = [NSString stringWithFormat:@"%@",@"BoxyWorld Balance"];
       
    }
    else if([select isEqualToString:@"2"]){
        session.payment_method = [NSString stringWithFormat:@"%@",@"Card Details"];
        
    }
    else{
          session.payment_method = [NSString stringWithFormat:@"%@",@"Card Details"];
    }
    session.pay_with = pay_with;
    [UserAccessSession storeUserSession:session];
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    reviewVC * vc2 = [storyboard instantiateViewControllerWithIdentifier:@"tabreview"];
    [self.navigationController pushViewController:vc2 animated:YES];
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
