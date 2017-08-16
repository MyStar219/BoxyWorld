//
//  exploreVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 14/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "exploreVC.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "config.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"
#import "recipientVC.h"

@interface exploreVC ()<UIScrollViewDelegate,KPDropMenuDelegate,UITextFieldDelegate>
{
    NSString *userId,*athenticationKey,*country_Id,*country_preFix,*customer_id,*flag1,*amount,*currencycodeFrom;
    NSMutableArray *countryArr,*countryCodeArr,*countryPrefix,*currencycodeFromArr,*sentMoneyPayOut,*dataArr,*allcountryArr;
    MBProgressHUD *hud;
    NSString *currncyCode,*convertAmount_val;
    NSString *sentMoney_by,*payOutIcon1,*payOutIcon2,*label1,*label2;
    NSString *payOutID,*payOutID1,*payOutID2;
    SWRevealViewController *revealController;
    UserAccessSession *sessions;
    NSString *convert_Amount,*exchange_rate,*sending_Amount,*sendingAmountFee,*to_cur;
   

}

@end

@implementation exploreVC
@synthesize txtmoneySentTo,txtAmt1,txtAmt2,txtUsd1,txtUsd2,btnSaveCon,dropcountry,scrExpor;
@synthesize btnforBank,btnForMobile,lblForBank,lblForMobile,viewBySentMoney;
@synthesize btnSaveConstraint,stackExplore,lblrecieveMoney;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"EXPLORE";
    countryArr =[[NSMutableArray alloc]init];
    countryCodeArr = [[NSMutableArray alloc]init];
    countryPrefix = [[NSMutableArray alloc]init];
    currencycodeFromArr=[[NSMutableArray alloc]init];
    sentMoneyPayOut = [[NSMutableArray alloc]init];
    dataArr = [[NSMutableArray alloc]init];
    allcountryArr = [[NSMutableArray alloc]init];
    flag1 =@"0";
     revealController = self.revealViewController;
    // Do any additional setup after loading the view.
    [self makeLayout];
    [self loadCountry];
    sentMoney_by =@"";
    // [self registerForKeyboardNotifications];
    float appWidth = CGRectGetWidth([UIScreen mainScreen].applicationFrame);
    UIToolbar *accessoryView = [[UIToolbar alloc]
                                initWithFrame:CGRectMake(0, 0, appWidth, 0.1 * appWidth)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]
                              initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                              target:nil
                              action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                             target:self
                             action:@selector(selectDoneButton)];
    accessoryView.items = @[space, done, space];
    self.txtAmt1.inputAccessoryView = accessoryView;
    
    
    //scrExpor.initWithFrame:CGRectMake(self.scrExpor.frame.origin.x, 64,self.scrExpor.frame.size.width, self.scrExpor.frame.size.height);

}
- (void)selectDoneButton {
    [self.txtAmt1 resignFirstResponder];
    [self sentMoneyRequest];
}
-(void)makeLayout{
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:
    @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
   
    
   
    
   
    
    UIView *paddingtxtFName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    txtmoneySentTo.leftView = paddingtxtFName;
    txtmoneySentTo.leftViewMode = UITextFieldViewModeAlways;
    txtmoneySentTo.layer.borderWidth = 1.3;
    txtmoneySentTo.layer.borderColor = textFieldBorderColor.CGColor;
    txtmoneySentTo.layer.cornerRadius = 5.0f;
    txtmoneySentTo.delegate=self;
    
   // UIView *paddingtxtFNameR = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    //txtmoneySentTo.rightView = paddingtxtFNameR;
   /* [txtmoneySentTo setRightViewMode:UITextFieldViewModeAlways];
    txtmoneySentTo.rightView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"downExpArrw"]];*/
    UIButton *btnColor = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnColor addTarget:self action:@selector(btnColorPressed:) forControlEvents:UIControlEventTouchUpInside];
    btnColor.frame = CGRectMake(self.txtmoneySentTo.bounds.size.width -30, 10, 20, 20);
    [btnColor setBackgroundImage:[UIImage imageNamed:@"downExpArrw"] forState:UIControlStateNormal];
    [self.txtmoneySentTo addSubview:btnColor];
    
    
    UIView *paddingtxtLName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtAmt1.leftView = paddingtxtLName;
    txtAmt1.leftViewMode = UITextFieldViewModeAlways;
    txtAmt1.delegate=self;
    self.txtAmt1.layer.borderWidth = 1.3;
    self.txtAmt1.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtAmt1.layer.cornerRadius = 5.0f;
    
    UIView *paddingmail= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtAmt2.leftView = paddingmail;
    txtAmt2.leftViewMode = UITextFieldViewModeAlways;
    txtAmt2.delegate=self;
    self.txtAmt2.layer.borderWidth = 1.3;
    self.txtAmt2.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtAmt2.layer.cornerRadius = 5.0f;
    
    UIView *paddingUsd1= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
      txtUsd1.leftView = paddingUsd1;
      txtUsd1.leftViewMode = UITextFieldViewModeAlways;
    txtUsd1.delegate=self;
    self.txtUsd1.layer.borderWidth = 1.3;
    self.txtUsd1.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtUsd1.layer.cornerRadius = 5.0f;
    UIButton *btntxtUsd1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btntxtUsd1 addTarget:self action:@selector(btntxtUsd1Pressed:) forControlEvents:UIControlEventTouchUpInside];
    btntxtUsd1.frame = CGRectMake(self.txtUsd1.bounds.size.width -20, 7, 15, 15);
    [btntxtUsd1 setBackgroundImage:[UIImage imageNamed:@"downExpArrw"] forState:UIControlStateNormal];
    [self.txtUsd1 addSubview:btntxtUsd1];

    
    UIView *paddingUsd2= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtUsd2.leftView = paddingUsd2;
    txtUsd2.leftViewMode = UITextFieldViewModeAlways;
    txtUsd2.delegate=self;
    self.txtUsd2.layer.borderWidth = 1.3;
    self.txtUsd2.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtUsd2.layer.cornerRadius = 5.0f;
    UIButton *btntxtUsd2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btntxtUsd2 addTarget:self action:@selector(btntxtUsd2Pressed:) forControlEvents:UIControlEventTouchUpInside];
    btntxtUsd2.frame = CGRectMake(self.txtUsd2.bounds.size.width -20, 7, 15, 15);
    [btntxtUsd2 setBackgroundImage:[UIImage imageNamed:@"downExpArrw"] forState:UIControlStateNormal];
    [self.txtUsd2 addSubview:btntxtUsd2];
    
       //self.btnSubmit.layer.borderWidth = 1.0;
    self.btnSaveCon.layer.borderColor = [UIColor clearColor].CGColor;
    self.btnSaveCon.layer.cornerRadius = 6.0f;
    NSLog(@"testttttt=======");
    
    
    //**********test***********
    
    btnforBank.hidden=YES;
    btnForMobile.hidden = YES;
    lblForBank.hidden = YES;
    lblForMobile.hidden = YES;
    viewBySentMoney.hidden = YES;

    
    //***********test************
    //_stackViewHeight.constant = 32;
    //_saveBtnHeight.constant = 32;
   /*
    viewBySentMoney.hidden = YES;
    btnforBank.hidden=YES;
    btnForMobile.hidden = YES;
    lblForBank.hidden = YES;
    lblForMobile.hidden = YES;
    */
    //self.stackExplore.hidden = YES;
    
    
    //CGRect tempFrame =self.viewBySentMoney.frame;
    //
    
    //[self.viewBySentMoney removeFromSuperview];
    NSLog(@"lblrecieveMoneyyyyy=%f",lblrecieveMoney.frame.origin.y);
   
    self.btnSaveCon.frame =  CGRectMake(self.lblrecieveMoney.frame.origin.x, lblrecieveMoney.frame.origin.y + lblrecieveMoney.frame.size.height + 8, self.lblrecieveMoney.frame.size.width, 30.0);
     NSLog(@"btnSaveConyyyy=%f",btnSaveCon.frame.origin.y);
    //[self.scrExpor addSubview:self.btnSaveCon];
    
    //self.viewBySentMoney.frame =  CGRectMake(self.viewBySentMoney.frame.origin.x, self.btnSaveCon.frame.origin.y + btnSaveCon.frame.size.height + 8, self.viewBySentMoney.frame.size.width, self.viewBySentMoney.frame.size.height);
    
    //self.viewBySentMoney.hidden  = YES;
    
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
   // [self.presentedViewController.navigationBar setBarTintColor:navigationBarColor];
    
}
-(void)popView:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)loadCountry
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    UserSession *addCustomer = [UserAccessSession getUserSession];
    NSLog(@"addCustomer===%@",addCustomer);
    userId =addCustomer.reseller_id;
    athenticationKey =addCustomer.res_user_login_key;
    customer_id = addCustomer.customer_id;
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@",HOSTNAME,URL_GETSENDMONEYCOUNTRY];
    NSLog(@"URL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"URL==%@",URL);
     NSLog(@"parameters==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        NSLog(@"explore==%@",json);
        
       allcountryArr = [[NSMutableArray alloc]init];
        allcountryArr = [json objectForKey:@"data"];//valueForKey:@"countryname"];
       // NSLog(@"allcountryArr*****%@",allcountryArr);
        for (int i=0; i<[allcountryArr count]; i++) {
            [countryArr addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"countryname"]];
            [countryCodeArr addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"id"]];
            [countryPrefix addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"countryprefix"]];
           // [currencycodeFromArr addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"currencycode"]];
        }
       // NSLog(@"countryArr*****%@",currencycodeFromArr);
        //NSLog(@"countryPrefix*****%@",countryPrefix);
        //for drop down
        CGFloat phoneX = self.txtmoneySentTo.frame.origin.x;
        CGFloat phoneY = self.txtmoneySentTo.frame.origin.y;
        CGFloat phoneWidth = self.txtmoneySentTo.frame.size.width;
        CGFloat phoneHeight = self.txtmoneySentTo.frame.size.height;
        
        dropcountry = [[KPDropMenu alloc] initWithFrame:CGRectMake(phoneX, phoneY, phoneWidth, phoneHeight)];
        dropcountry.delegate = self;
        dropcountry.items = countryArr;
        dropcountry.title = @"Select Country";
        dropcountry.titleColor=[UIColor whiteColor];
        dropcountry.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
        dropcountry.titleTextAlignment = NSTextAlignmentLeft;
        dropcountry.DirectionDown = YES;
        [self.scrExpor insertSubview:dropcountry aboveSubview:self.txtmoneySentTo];
      /*
       
       */
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
       // registerVC1 *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
       // [[self navigationController] pushViewController:vc animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        //return error;
        json = nil;
        
    }];
}
-(void)didSelectItem : (KPDropMenu *) dropMenu atIndex : (int) atIntedex{
    
    if(dropMenu == dropcountry){
        
        //preph.text=countryPrefix[atIntedex];
        txtmoneySentTo.text=countryArr[atIntedex];
         country_Id=countryCodeArr[atIntedex];
        country_preFix = countryPrefix[atIntedex];
        dataArr = allcountryArr[atIntedex];
      
       
       
        UserSession *session = [UserAccessSession getUserSession];
      //@synthesize sentMoney_CountyID,sentMoney_CountryCode,sentMoney_rech_country_code,sentMoney_countryname,sentMoney_countryprefix,sentMoney_delivery_boxypay,sentMoney_delivery_debit,sentMoney_delivery_bank,sentMoney_currencycode,sentMoney_moneyexpress_country_name;
        session.sentMoney_CountyID = [NSString stringWithFormat:@"%@",[dataArr valueForKey:@"id"]];
        session.sentMoney_CountryCode =[NSString stringWithFormat:@"%@",[dataArr valueForKey:@"countrycode"]];
        
        session.sentMoney_rech_country_code =[NSString stringWithFormat:@"%@",[dataArr valueForKey:@"rech_country_code"]];
        
        session.sentMoney_countryname = [NSString stringWithFormat:@"%@",[dataArr valueForKey:@"countryname"]];
        
        session.sentMoney_countryprefix = [NSString stringWithFormat:@"%@",[dataArr valueForKey:@"countryprefix"]];
        
        session.sentMoney_delivery_boxypay =[NSString stringWithFormat:@"%@",[dataArr valueForKey:@"delivery_boxypay"]];
        
        session.sentMoney_delivery_debit = [NSString stringWithFormat:@"%@",[dataArr valueForKey:@"delivery_debit"]];
        
        session.sentMoney_delivery_bank = [NSString stringWithFormat:@"%@",[dataArr valueForKey:@"delivery_bank"]];
        
        session.sentMoney_currencycode = [NSString stringWithFormat:@"%@",[dataArr valueForKey:@"currencycode"]];
        
         session.sentMoney_moneyexpress_country_name = [NSString stringWithFormat:@"%@",[dataArr valueForKey:@"moneyexpress_country_name"]];
        
        [UserAccessSession storeUserSession:session];
        

        
       
        [self sentMoneyRequest];
         // [self showBankAndMobile];
        //NSLog(@"%@ with TAG : %ld", dropMenu.items[atIntedex], (long)dropMenu.tag);
    }
        else{
        // NSLog(@"%@", dropMenu.items[atIntedex]);
    }
}

-(void)didShow:(KPDropMenu *)dropMenu{
    NSLog(@"didShow");
}

-(void)didHide:(KPDropMenu *)dropMenu{
    NSLog(@"didHide");
}
-(void)showBankAndMobile
{
     if(sentMoneyPayOut.count == 1){
         
         btnforBank.hidden=NO;
         btnForMobile.hidden = YES;
         lblForBank.hidden = NO;
         lblForMobile.hidden = YES;
         viewBySentMoney.hidden = NO;
     }
     else if(sentMoneyPayOut.count == 2){
         btnforBank.hidden=NO;
         btnForMobile.hidden = NO;
         lblForBank.hidden = NO;
         lblForMobile.hidden = NO;
         viewBySentMoney.hidden = NO;
         
     }
     else{
         btnforBank.hidden=YES;
         btnForMobile.hidden = YES;
         lblForBank.hidden = YES;
         lblForMobile.hidden = YES;
         viewBySentMoney.hidden = YES;
         
     }
    //NSString *payoutCount=[NSString stringWithFormat:@"%lu",(unsigned long)];
 
   
}
//SentMoneyRequest
-(void)sentMoneyRequest
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    UserSession *addCustomer = [UserAccessSession getUserSession];
    NSLog(@"addCustomer===%@",addCustomer);
    userId =addCustomer.reseller_id;
    athenticationKey =addCustomer.res_user_login_key;
    customer_id =addCustomer.customer_id;
   NSLog(@"customer Id=====%@",addCustomer.customer_id);
    if([flag1 isEqualToString:@"0"])
    {
        amount =@"1";
    }
    else{
        amount = self.txtAmt1.text;
        
    }
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  customer_id,@"customer_id",
                  amount,@"amount",
                  country_Id,@"country_id",
                  @"balance",@"pay_option_with",
                  @"1",@"rate_type",
                  @"get_data_by_country",@"type",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@",HOSTNAME,URL_GETSENDMONEYREQUEST];
    NSLog(@"URL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"URL==%@",URL);
    NSLog(@"parameters==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        NSLog(@"sentMoney***** Request==%@",json);
        if(json.count>0){
            flag1 =@"1";
        }
        currncyCode =[json objectForKey:@"currencycode"];
        convertAmount_val =[json objectForKey:@"convert_amount_val"];
        convert_Amount = [json objectForKey:@"convert_amount"];
        exchange_rate = [json objectForKey:@"exchange_rate"];
        sending_Amount= [json objectForKey:@"sending_amount"];
        sendingAmountFee = [json objectForKey:@"sending_amount_with_fee"];
        to_cur = [json objectForKey:@"to_cur"];
        sentMoneyPayOut = [json objectForKey:@"payout_options"];
        //***************************
        
        
        if(sentMoneyPayOut.count == 1){
            
            payOutIcon1 =[[sentMoneyPayOut objectAtIndex:0]objectForKey:@"icon"];
            label1 = [[sentMoneyPayOut objectAtIndex:0]objectForKey:@"name"];
            payOutID1 = [[sentMoneyPayOut objectAtIndex:0]objectForKey:@"payout_id"];
            NSLog(@"payOutIcon1==%@",payOutIcon1);
            NSLog(@"label1==%@",label1);
            NSURL *url1 =[NSURL URLWithString:[NSString stringWithFormat:@"%@",payOutIcon1]];;
            NSURLRequest *request1 =[NSURLRequest requestWithURL:url1];
            [NSURLConnection sendAsynchronousRequest:request1
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse * response,
                                                       NSData * data,
                                                       NSError * error) {
                                       if (!error){
                                           UIImage  *image = [[UIImage alloc] initWithData:data];
                                           
                                           [btnforBank setImage:image forState:UIControlStateNormal];
                                           //cell.profileImage.clipsToBounds = YES;
                                       }
                                       else{
                                           // cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width / 2;
                                           //cell.profileImage.clipsToBounds = YES;
                                           //[cell.profileImage setImage:[UIImage imageNamed:@"userIcon"]];
                                       }
                                       
                                   }];
            
            lblForBank.text = label1;
            if([flag1 isEqualToString:@"1"])
            {
                [self showBankAndMobile];
            }
        }
        else if(sentMoneyPayOut.count == 2){
            
            payOutIcon1 =[[sentMoneyPayOut objectAtIndex:0]objectForKey:@"icon"];
            payOutIcon2 = [[sentMoneyPayOut objectAtIndex:1]objectForKey:@"icon"];
            label1 = [[sentMoneyPayOut objectAtIndex:0]objectForKey:@"name"];
            label2 = [[sentMoneyPayOut objectAtIndex:1]objectForKey:@"name"];
             payOutID1 = [[sentMoneyPayOut objectAtIndex:0]objectForKey:@"payout_id"];
             payOutID2 = [[sentMoneyPayOut objectAtIndex:1]objectForKey:@"payout_id"];
            NSURL *url1 =[NSURL URLWithString:[NSString stringWithFormat:@"%@",payOutIcon1]];;
            NSURLRequest *request1 =[NSURLRequest requestWithURL:url1];
            [NSURLConnection sendAsynchronousRequest:request1
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse * response,
                                                       NSData * data,
                                                       NSError * error) {
                                       if (!error){
                                           UIImage  *image = [[UIImage alloc] initWithData:data];
                                           
                                           [btnforBank setImage:image forState:UIControlStateNormal];
                                           //cell.profileImage.clipsToBounds = YES;
                                       }
                                       else{
                                           // cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width / 2;
                                           //cell.profileImage.clipsToBounds = YES;
                                           //[cell.profileImage setImage:[UIImage imageNamed:@"userIcon"]];
                                       }
                                       
                                   }];
            NSURL *url2 =[NSURL URLWithString:[NSString stringWithFormat:@"%@",payOutIcon2]];;
            NSURLRequest *request2 =[NSURLRequest requestWithURL:url2];
            [NSURLConnection sendAsynchronousRequest:request2
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse * response,
                                                       NSData * data,
                                                       NSError * error) {
                                       if (!error){
                                           UIImage  *image = [[UIImage alloc] initWithData:data];
                                           
                                           [btnForMobile setImage:image forState:UIControlStateNormal];
                                           //cell.profileImage.clipsToBounds = YES;
                                       }
                                       else{
                                           // cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width / 2;
                                           //cell.profileImage.clipsToBounds = YES;
                                           //[cell.profileImage setImage:[UIImage imageNamed:@"userIcon"]];
                                       }
                                       
                                       }];
                                       
             lblForBank.text = label1;
             lblForMobile.text = label2;
            if([flag1 isEqualToString:@"1"])
            {
                [self showBankAndMobile];
            }
            
        }
         else{
             btnforBank.hidden=YES;
             btnForMobile.hidden = YES;
             lblForBank.hidden = YES;
             lblForMobile.hidden = YES;
         }
        
             //****************************
    
        txtUsd1.text =@"USD";
        txtUsd2.text =currncyCode;
        txtAmt1.text =amount;
        txtAmt2.text =[NSString stringWithFormat:@"%@",convertAmount_val];//convertAmount;
        }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        // registerVC1 *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        // [[self navigationController] pushViewController:vc animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        //return error;
        json = nil;
        
    }];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:TRUE];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y -80., self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
    
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:TRUE];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y +80., self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}
//for keypad hide/show
/*- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
*/
// Called when the UIKeyboardDidShowNotification is sent.
/*- (void)keyboardWasShown:(NSNotification*)aNotification
{
    //NSLog(@"keyboard==%@",aNotification);
    NSDictionary* info = [aNotification userInfo];
    //NSLog(@"text y==%f",activeField.frame.origin.y);
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrExpor.contentInset = contentInsets;
    scrExpor.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [viewExp setContentOffset:scrollPoint animated:YES];
    }
}
*/
// Called when the UIKeyboardWillHideNotification is sent
/*- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    viewExp.contentInset = contentInsets;
    viewExp.scrollIndicatorInsets = contentInsets;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

*/
-(BOOL)textFieldShouldReturn:(UITextField *)textField

{
    
    //[textField resignFirstResponder];
  /*  NSLog(@"textFieldShouldReturn");
    if (textField == txtAmt1)
    {
         [self sentMoneyRequest];
        [txtAmt1 resignFirstResponder];
        //[txtAmt2 becomeFirstResponder];
        
    }
    else{
        NSLog(@"hello");
        
    }*/
     [textField resignFirstResponder];
    return YES;
}
- (IBAction)btnActionBank:(id)sender {
    payOutID = payOutID1;
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",payOutID] forKey:@"optionID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    sentMoney_by= [NSString stringWithFormat:@"%@",label1];//@"Direct To Bank";
    
    self.btnForMobile.layer.borderWidth = 0.0;
    self.btnForMobile.layer.borderColor = [UIColor whiteColor].CGColor;
    self.btnForMobile.layer.cornerRadius = 0.0f;
    
    self.btnforBank.layer.borderWidth = 1.0;
    self.btnforBank.layer.borderColor = [UIColor grayColor].CGColor;
    self.btnforBank.layer.cornerRadius = 6.0f;

    
}
- (IBAction)btnActionMobile:(id)sender {
    payOutID = payOutID2;
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",payOutID] forKey:@"optionID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    sentMoney_by= [NSString stringWithFormat:@"%@",label2];
    
    self.btnForMobile.layer.borderWidth = 1.0;
    self.btnForMobile.layer.borderColor = [UIColor grayColor].CGColor;
    self.btnForMobile.layer.cornerRadius = 6.0f;
    
    self.btnforBank.layer.borderWidth = 0.0;
    self.btnforBank.layer.borderColor = [UIColor whiteColor].CGColor;
    self.btnforBank.layer.cornerRadius = 0.0f;
   // sentMoney_by = @"Mobile Money";
}
- (IBAction)btnActionSaveAndContinue:(id)sender {
    //txtmoneySentTo,txtAmt1,txtAmt2,txtUsd1,txtUsd2
    NSLog(@"sentMoney_by==%@",sentMoney_by);
    if([txtmoneySentTo.text isEqualToString:@""] ){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"please select country" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
   else if([txtAmt1.text isEqualToString:@""] ){
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter amount" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
   else if([sentMoney_by isEqualToString:@""]){
       
       
       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please select money transfer by"delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
       [alert show];
   }

   else{
       
       UserSession *session = [UserAccessSession getUserSession];
       
       session.expSent_amount_method = [NSString stringWithFormat:@"%@",txtAmt1.text];
       session.expSentMoney = sentMoney_by;
       // NSString *convert_Amount,*exchange_rate,*sending_Amount,*sendingAmountFee,*to_cur;
       session.sending_Amount = sending_Amount;
       session.convert_Amount = convert_Amount;
       session.exchange_rate = exchange_rate;
       session.sendingAmountFee = sendingAmountFee;
        session.to_cur = to_cur;
       session.expPayout_id= payOutID;
    [UserAccessSession storeUserSession:session];

       [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",amount] forKey:@"Sm_Amount"];
       [[NSUserDefaults standardUserDefaults] synchronize];
       
      /* NSString * storyboardName = @"Main";
       UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
       recipientVC * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"tabRecipient"];
       vc1.flagTransBy = sentMoney_by;
       [revealController pushFrontViewController:vc1 animated:YES];*/
       NSString * storyboardName = @"Main";
       UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
       recipientVC * vc2 = [storyboard instantiateViewControllerWithIdentifier:@"tabRecipient"];
       vc2.flagTransBy= sentMoney_by;
       
       
       [self.navigationController pushViewController:vc2 animated:YES];
   }
    
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
