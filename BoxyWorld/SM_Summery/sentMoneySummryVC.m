//
//  sentMoneySummryVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 26/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "sentMoneySummryVC.h"
 #import "config.h"
#import "summaryHeadCell.h"
#import "summaryFooterCell.h"
#import "summeryCell.h"
#import "UserAccessSession.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "MGUtilities.h"
#import "AFNetworking.h"
#import "webViewVC.h"
@interface sentMoneySummryVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIGestureRecognizerDelegate>
{
    NSMutableArray *dataArray;
    NSString *countryName,*Recipient_name,*rec_phone_number,*bank_Id;
    NSString *userId,*countryId,*status;
    NSString *athenticationKey,*customer_id,*recipientId,*sending_Amount,*pay_with,*payOption,*recSelectedPhno,*Sent_money_by,*bank_id;
     MBProgressHUD *hud;
}
@end

@implementation sentMoneySummryVC
@synthesize tblSummary;
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
     [self.tblSummary reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"SUMMARY";
    [self barButtonFunction];
    UserSession *review = [UserAccessSession getUserSession];
    NSString *delivert_amount = review.expSent_amount_method;
    NSString *convert_Amount = review.convert_Amount;
    NSString *exchange_rate =review.exchange_rate;
    NSString *sendingAmountFee = review.sendingAmountFee;
    NSString *to_cur =review.to_cur;
    customer_id = review.customer_id;
    recipientId = review.recipent_id;
    payOption = review.expPayout_id;
    recSelectedPhno = review.recSelectedPhno;
    countryName = review.sentMoney_countryname;
    pay_with = review.pay_with;
    Sent_money_by = review.expSentMoney;
    Recipient_name =review.recipent_Name;
    sending_Amount = review.sending_Amount;
    countryId = review.sentMoney_CountyID;
    bank_id =review.recBankId;
    userId =review.reseller_id;
    athenticationKey =review.res_user_login_key;
       /*expPayout_id
    NSString *customer_Name = review.customer_Name;
    NSString *customer_add = review.customer_address;
    NSString *customer_city = review.customer_city;
    NSString *customer_state = review.customer_state;
    NSString *customer_country = review.customer_country;
    NSString *customer_ph = review.customer_phNo;
    */
   
   // NSString *payment_method = review.payment_method;
    
   // NSString *SentMoney_bankORPn = review.expSentMoneyBankOrMobile;
    
   
    //data array
    dataArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *data1 = [[NSMutableDictionary alloc]init];
    [data1 setObject:@"You are sending :" forKey:@"key"];
    [data1 setObject:[NSString stringWithFormat:@"%@ USD",sending_Amount] forKey:@"val"];
    
    
    NSMutableDictionary *data2 = [[NSMutableDictionary alloc]init];
    [data2 setObject:@"Transaction fee:" forKey:@"key"];
    [data2 setObject:[NSString stringWithFormat:@"%@ USD",sendingAmountFee] forKey:@"val"];
    
    
    NSMutableDictionary *data3 = [[NSMutableDictionary alloc]init];
    [data3 setObject:@"Your total :" forKey:@"key"];
    [data3 setObject:[NSString stringWithFormat:@"%@ USD",delivert_amount] forKey:@"val"];
    //-------------
    NSMutableDictionary *data4 = [[NSMutableDictionary alloc]init];
    [data4 setObject:@"Recipient receives :" forKey:@"key"];
    [data4 setObject:[NSString stringWithFormat:@"%@ USD",convert_Amount] forKey:@"val"];
    
    
    NSMutableDictionary *data5 = [[NSMutableDictionary alloc]init];
    [data5 setObject:@"Exchange rate :" forKey:@"key"];
    [data5 setObject:[NSString stringWithFormat:@"1 USD = %@ %@",exchange_rate,to_cur] forKey:@"val"];
    
    
    NSMutableDictionary *data6 = [[NSMutableDictionary alloc]init];
    [data6 setObject:@"Delivery Instant :" forKey:@"key"];
    [data6 setObject:@"Instant 24 Hours" forKey:@"val"];
    
    NSMutableDictionary *data7 = [[NSMutableDictionary alloc]init];
    [data7 setObject:@"Recipient option :" forKey:@"key"];
    [data7 setObject:[NSString stringWithFormat:@"%@",Sent_money_by] forKey:@"val"];
    
    NSMutableDictionary *data8 = [[NSMutableDictionary alloc]init];
    [data8 setObject:@"Pay with your :" forKey:@"key"];
    [data8 setObject:[NSString stringWithFormat:@"%@",pay_with] forKey:@"val"];
    
    NSMutableDictionary *data9 = [[NSMutableDictionary alloc]init];
    [data9 setObject:@"" forKey:@"key"];
    [data9 setObject:@"" forKey:@"val"];
    
    [dataArray addObject:data1];
    [dataArray addObject:data2];
    [dataArray addObject:data3];
    [dataArray addObject:data4];
    [dataArray addObject:data5];
    [dataArray addObject:data6];
    [dataArray addObject:data7];
    [dataArray addObject:data8];
    [dataArray addObject:data9];

    
    
    [self.tblSummary registerNib:[UINib nibWithNibName:@"summaryHeadCell" bundle:nil]forCellReuseIdentifier:@"summaryHeadCell"];
    
    [self.tblSummary registerNib:[UINib nibWithNibName:@"summeryCell" bundle:nil]forCellReuseIdentifier:@"summeryCell"];
    
    [self.tblSummary registerNib:[UINib nibWithNibName:@"summaryFooterCell" bundle:nil]forCellReuseIdentifier:@"summaryFooterCell"];
    
    [self.tblSummary setDataSource:self];
    [self.tblSummary setDelegate:self];
    [self.tblSummary reloadData];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        static NSString *cellIdentifier = @"summaryHeadCell";
        summaryHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            cell = [[summaryHeadCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
        }
        return cell.frame.size.height;
        
        }
    else if(indexPath.row == dataArray.count+1){
        
        static NSString *cellIdentifier = @"summaryFooterCell";
        summaryHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            cell = [[summaryFooterCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
        }
        return cell.frame.size.height;
        

    }
    else if(indexPath.row == dataArray.count){
        static NSString *cellIdentifier = @"cellID";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
         return cell.frame.size.height;
    }
    else{
        static NSString *cellIdentifier = @"summeryCell";
        summeryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            cell = [[summeryCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
        }
        return cell.frame.size.height;

        }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return (dataArray.count)+2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if(indexPath.row == 0){
         static NSString *cellIdentifier = @"summaryHeadCell";
         summaryHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
         
         if (cell == nil)
         {
             cell = [[summaryHeadCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
         }
         //imgFlag,lblCusName,lblCountry;
         cell.lblCusName.text =[NSString stringWithFormat:@"%@ - ",Recipient_name];
          cell.lblCountry.text =countryName;
         
         return cell;
     }
         else if(indexPath.row == dataArray.count+1){
         
         static NSString *cellIdentifier = @"summaryFooterCell";
         summaryFooterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
         
         if (cell == nil)
         {
             cell = [[summaryFooterCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
         }
             
         cell.lblTrmsAndCondition.userInteractionEnabled = YES;
         UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(goToUserKaveWithId:)];
         tapGesture1.numberOfTapsRequired = 1;
         [tapGesture1 setDelegate:self];
         [cell.lblTrmsAndCondition addGestureRecognizer:tapGesture1];
             
         cell.btnBack.layer.borderWidth = 1.0;
         cell.btnBack.layer.borderColor = [UIColor greenColor].CGColor;
         cell.btnBack.layer.cornerRadius = 6.0f;
          [cell.btnBack addTarget:self action:@selector(popView:) forControlEvents:UIControlEventTouchUpInside];
             
         cell.btnCancel.layer.borderWidth = 1.0;
         cell.btnCancel.layer.borderColor = [UIColor redColor].CGColor;
         cell.btnCancel.layer.cornerRadius = 6.0f;
         
         cell.BtnAgreeAndSent.layer.borderWidth = 1.0;
         //cell.BtnAgreeAndSent.layer.borderColor = [UIColor blueColor].CGColor;
         cell.BtnAgreeAndSent.layer.cornerRadius = 6.0f;
             [cell.BtnAgreeAndSent addTarget:self action:@selector(summarySubmit) forControlEvents:UIControlEventTouchUpInside];
         cell.selectionStyle=NULL;
         return cell;
     }
   else if(indexPath.row == dataArray.count){
        static NSString *cellIdentifier = @"cellID";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text =@"How to report a problem?";
        cell.textLabel.textColor =[UIColor redColor];
        return cell;
    }

     else{
         
    static NSString *cellIdentifier = @"summeryCell";
    summeryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[summeryCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
    }
    NSString *key = [[[dataArray objectAtIndex:(indexPath.row-1)]objectForKey:@"key"] isKindOfClass:[NSNull class]]?@"":[[dataArray objectAtIndex:(indexPath.row-1)]objectForKey:@"key"];
    
    [cell.lbl1 setText:key];
    
    // [ cell.lblKey setTextColor:[UIColor redColor]];
    
    
    //[cell.lblKey setTextAlignment:NSTextAlignmentLeft];
    
    
    
   NSString *value = [[[dataArray objectAtIndex:(indexPath.row-1)]objectForKey:@"val"] isKindOfClass:[NSNull class]]?@"":[[dataArray objectAtIndex:(indexPath.row-1)]objectForKey:@"val"];
    
    [cell.lblValue setText:value];
    
    // [cell.lblVal setTextAlignment:NSTextAlignmentLeft];
    [ cell.lblValue setTextColor:[UIColor grayColor]];
         
    return cell;
     }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == dataArray.count)
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        webViewVC * vc2 = [storyboard instantiateViewControllerWithIdentifier:@"SBwebView"];
        vc2.fromPage = @"sendMoney";
        [self.navigationController pushViewController:vc2 animated:YES];
    }
}
 //****************

- (void) goToUserKaveWithId:(UITapGestureRecognizer *)tapRecognizer
{
    NSLog(@"tapRecognizer");
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    webViewVC * vc2 = [storyboard instantiateViewControllerWithIdentifier:@"SBwebView"];
    [self.navigationController pushViewController:vc2 animated:YES];
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
-(void)summarySubmit
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    if([Sent_money_by isEqualToString:@"Mobile Money"]){
        rec_phone_number = recSelectedPhno;
        bank_Id=@"";
    }
    else{
        bank_Id=bank_id;
         rec_phone_number =@"";
    }
    NSLog(@"userId==%@",userId);
     NSLog(@"athenticationKey==%@",athenticationKey);
     NSLog(@"customer_id==%@",customer_id);
     NSLog(@"recipientId==%@",recipientId);
    NSLog(@"sending_Amount==%@",sending_Amount);
     NSLog(@"bank_Id==%@",bank_Id);
    NSLog(@"countryId==%@",countryId);
    NSLog(@"pay_with==%@",pay_with);
    NSLog(@"payOption==%@",payOption);
    NSLog(@"rec_phone_number==%@",rec_phone_number);
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  customer_id,@"customer_id",
                  recipientId,@"contact_id",
                   @"",@"ach_debit_card_id",
                  sending_Amount,@"amount",
                  bank_Id,@"bank_account",
                   @"",@"contact_debit_card_id",
                 countryId,@"country",
                   @"",@"debit_bank_name_hidden",
                   @"",@"debit_card_id",
                  pay_with,@"pay_with_option",
                  pay_with,@"extra_pay_option",
                   @"1",@"is_save",
                  payOption,@"pay_option",
                   @"",@"pay_with_bank_id",
                   @"",@"rate_id",
                   @"",@"rec_debit_no",
                   rec_phone_number,@"rec_phone_number",
                  @"",@"schedule_amount",
                   @"",@"schedule_frequency",
                   @"",@"schedule_internal_memo",
                   @"",@"schedule_msg_to_recipient",
                   @"",@"schedule_total_transaction",
                  @"",@"topup_amount",
                  @"",@"topup_country",
                  @"",@"topup_method",
                  @"",@"topup_network",
                   @"",@"topup_org_amount",
                   @"",@"topup_phone",
                   @"",@"topup_receipt_to",
                   @"6011111111111117",@"card_number",
                   @"123",@"card_cvv",
                   @"12",@"card_exp_month",
                   @"18",@"card_exp_year",
                   @"Abcdefg",@"card_name",
                   @"",@"card_encrypted_key",
                   @"",@"dip_card_string",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@",HOSTNAME,URL_GETSUBMITSENDMONEY];
    NSLog(@"summaryURL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"summaryParameter====%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        
        NSLog(@"add_funds json %@",json);
        
        status = [NSString stringWithFormat:@"%@",[json objectForKey:@"status"]];
        if([status isEqualToString:@"1"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"successfull" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unsuccessfull" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
        }
        
        
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        //[[self navigationController] pushViewController:vc animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        //return error;
        json = nil;
        
    }];
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
