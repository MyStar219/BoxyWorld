//
//  reviewVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 22/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "reviewVC.h"
#import "config.h"
#import "UserAccessSession.h"
#import "sentMoneySummryVC.h"
@interface reviewVC ()

@end

@implementation reviewVC
@synthesize reclbl1,reclbl11,btnRecEdit,reclbl2,reclbl22,btnRec2;
@synthesize paymntlbl1,lblsentmnyAmt,lblFee,lbldeliveryIns;
@synthesize personLbl1,personalLbl2,personLbl3,pesonLbl4,personLbl5,personLbl6,btnSubmit;
@synthesize viewRec1,viewRec2,viewPay1,viewPer1;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     //self.title = @"Review";
     [self barButtonFunction];
    [self makeLayout ];
    UserSession *review = [UserAccessSession getUserSession];
    NSString *Recipient_name =review.recipent_Name;
    NSString *Recipient_phone =review.recipent_phone;
    
    NSString *customer_Name = review.customer_Name;
    NSString *customer_add = review.customer_address;
    NSString *customer_city = review.customer_city;
    NSString *customer_state = review.customer_state;
     NSString *customer_country = review.customer_country;
    NSString *customer_ph = review.customer_phNo;
    NSString *delivert_amount = review.expSent_amount_method;
    NSString *payment_method = review.payment_method;
    NSString *Sent_money_by = review.expSentMoney;
     NSString *SentMoney_bankORPn = review.expSentMoneyBankOrMobile;
    
    
    //#define EXP_SENT_MONEYBANK_OR_MOBILE @"expSentMoneyBankOrMobile"

    //#define EXP_SENT_MONEY_BY @"expSentMoney"
  // @synthesize reclbl1,reclbl11,btnRecEdit,reclbl2,reclbl22,btnRec2;
    reclbl1.text =Recipient_name;
    reclbl11.text= Recipient_phone;
    reclbl2.text = Sent_money_by;
    reclbl22.text= SentMoney_bankORPn;
    //@synthesize paymntlbl1,lblsentmnyAmt,lblFee,lbldeliveryIns;
    paymntlbl1.text = payment_method;
    lblsentmnyAmt.text = [NSString stringWithFormat:@"%@ USD",delivert_amount];//delivert_amount;
    lblFee.text = @"3 USD";
    lbldeliveryIns.text = @"24 hours";
  //@synthesize personLbl1,personalLbl2,personLbl3,pesonLbl4,personLbl5,personLbl6,btnSubmit;
    
    personLbl1.text = customer_Name;//[NSString stringWithFormat:@"%@%@",HOSTNAME,URL_GETSENDMONEYCOUNTRY]
    personalLbl2.text =customer_add;
    personLbl3.text =customer_city;
    pesonLbl4.text = customer_state;
    personLbl5.text = customer_country;
    personLbl6.text = customer_ph;
}
-(void)makeLayout{
    
    self.title = @"REVIEW";
    //[self.navigationController.navigationBar setTitleTextAttributes:
    // @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    //viewRec1,viewRec2,viewPay1,viewPer1
    
    
    viewRec1.layer.borderWidth = 1;
    viewRec1.layer.cornerRadius = 5.5f;
    viewRec1.layer.borderColor = [UIColor grayColor].CGColor;
    
    viewRec2.layer.borderWidth = 1;
     viewRec2.layer.cornerRadius = 5.5f;
    viewRec2.layer.borderColor = [UIColor grayColor].CGColor;
    
    viewPay1.layer.borderWidth = 1;
    viewPay1.layer.cornerRadius = 5.5f;
    viewPay1.layer.borderColor = [UIColor grayColor].CGColor;
    
    viewPer1.layer.borderWidth = 1;
    viewPer1.layer.cornerRadius = 5.5f;
    viewPer1.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    
   
    
   
    
    //self.btnSubmit.layer.borderWidth = 1.0;
    self.btnSubmit.layer.borderColor = [UIColor clearColor].CGColor;
    self.btnSubmit.layer.cornerRadius = 6.0f;
    NSLog(@"testttttt=======");
   
    
    
    
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

- (IBAction)btnActionSubmit:(id)sender {
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    sentMoneySummryVC * vc2 = [storyboard instantiateViewControllerWithIdentifier:@"SMSummery"];
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
