//
//  earingSendMoneyVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 02/08/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "earingSendMoneyVC.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "config.h"
#import "AFNetworking.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "UserAccessSession.h"
#import "allTransactionCell.h"

@interface earingSendMoneyVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    AppDelegate *appDel;
    MBProgressHUD *hud;
    NSString *athenticationKey,*userId;
    int start,end;
    UIDatePicker *picker1,*picker2;
  
    NSString *tabName,*cardNo,*cardtype,*addThrough,*amount,*status,*deductAmount,*earningAmount,*action,*country,*discount;
    NSMutableArray *ListDataArray;
    NSArray *arrayForAll,*arraForFund,*arrayForPinless,*arrayForIMTU;
    NSArray *dummyArray;
    NSString *searchOption,*senderUser,*receiverName,*amountDel,*rec_currency,*Boxytel,*imtuCredit,*toatalPay,*payWith,*rec_Option,*date,*slectedTab,*feeCharge;
    NSString *searchText;
}


@end

@implementation earingSendMoneyVC
@synthesize selfTitle;
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    [self barButtonFunction];
    [self loadSendMoney];
    searchText =@"";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"selfTitle==%@",selfTitle);
    start=0;
    end=3;
    ListDataArray =[[NSMutableArray alloc]init];
    UserSession *allTrans = [UserAccessSession getUserSession];
    userId =allTrans.reseller_id;
    athenticationKey =allTrans.res_user_login_key;
    slectedTab = selfTitle;//[[NSUserDefaults standardUserDefaults] objectForKey:@"tabSelected"];// allTrans.setectedTabHis;
    NSLog(@"tabSelectedSujit===%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"tabSelected2"]);
    //[UserAccessSession clearAllSession];
    // Do any additional setup after loading the view.
    appDel = [AppDelegate instance];
    [self makeArray];
    [self makeLayout];
    //Date,Type,Name,Phone,
    //data array
    alltranListArray = [[NSMutableArray alloc]init];
    
    [self.tblallTrns registerNib:[UINib nibWithNibName:@"allTransactionCell" bundle:nil]forCellReuseIdentifier:@"allTransactionCell"];
    

}
-(void)makeLayout{
    
    //self.title = @"All Transaction";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.txtSearch.layer.borderWidth = 1.3;
    self.txtSearch.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtSearch.layer.cornerRadius = 5.0f;
    self.txtSearch.delegate =self;
    
    self.btnSender.layer.borderWidth=1.0f;
    self.btnSender.layer.borderColor=[UIColor grayColor].CGColor;
    self.btnSender.layer.cornerRadius = self.btnSender.frame.size.width * 0.5;
    
    self.btnReceiver.layer.borderWidth=1.0f;
    self.btnReceiver.layer.borderColor=[UIColor grayColor].CGColor;
    self.btnReceiver.layer.cornerRadius = self.btnReceiver.frame.size.width * 0.5;

    
    self.txtFrom.layer.borderWidth = 1.3;
    self.txtFrom.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtFrom.layer.cornerRadius = 5.0f;
    self.txtFrom.delegate =self;
    self.txtFrom.text =@"2017-01-01";
    //self.txtFrom.inputView=self.datePiker;
    
    
    NSLog(@"dsgsgds==%f",_tblallTrns.frame.origin.y);
    picker1   = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, _tblallTrns.frame.origin.y+60, [UIScreen mainScreen].bounds.size.width, 216)];
    [picker1 setDatePickerMode:UIDatePickerModeDate];
    picker1.backgroundColor = [UIColor whiteColor];
    [picker1 addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    // self.txtFrom.rightViewMode =
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Done" forState:UIControlStateNormal];
    //button.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0);
    [button addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    self.txtFrom.rightView = button;
    self.txtFrom.rightViewMode = UITextFieldViewModeAlways;
    
    
    // self.txtFrom.inputView=self.datePiker;
    
    // UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    //[self.txtFrom setLeftViewMode:UITextFieldViewModeAlways];
    //[self.txtFrom setLeftView:spacerView];
    
    
    self.txtTo.layer.borderWidth = 1.3;
    self.txtTo.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtTo.layer.cornerRadius = 5.0f;
    self.txtTo.delegate =self;
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:today];
    self.txtTo.text =dateString;
    picker2   = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, _tblallTrns.frame.origin.y+60, [UIScreen mainScreen].bounds.size.width, 216)];
    [picker2 setDatePickerMode:UIDatePickerModeDate];
    picker2.backgroundColor = [UIColor whiteColor];
    [picker2 addTarget:self action:@selector(onDatePickerValueChangedto:) forControlEvents:UIControlEventValueChanged];
    
    
    
    self.btnSearch.layer.borderWidth = 1.0;
    self.btnSearch.layer.borderColor = [UIColor greenColor].CGColor;
    self.btnSearch.layer.cornerRadius = 6.0f;
    
    self.btnReset.layer.borderWidth = 1.0;
    self.btnReset.layer.borderColor = [UIColor redColor].CGColor;
    self.btnReset.layer.cornerRadius = 6.0f;
    
    self.btnDnldCSV.layer.borderWidth = 1.0;
    self.btnDnldCSV.layer.borderColor = [UIColor blueColor].CGColor;
    self.btnDnldCSV.layer.cornerRadius = 6.0f;
    
    
    self.btnLoadeMore.layer.borderWidth = 1.0;
    self.btnLoadeMore.layer.borderColor = [UIColor redColor].CGColor;
    self.btnLoadeMore.layer.cornerRadius = 6.0f;
    [self.datePiker setHidden:YES];
    //[self  textFieldWillBeginEditing];
}
- (void)onDatePickerValueChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //dateFormatter.locale = [NSLocale currentLocale];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [dateFormatter stringFromDate:datePicker.date];
    
    NSLog(@"date =%@",stringFromDate);
    self.txtFrom.text = stringFromDate;
}
- (void)onDatePickerValueChangedto:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //dateFormatter.locale = [NSLocale currentLocale];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [dateFormatter stringFromDate:datePicker.date];
    
    NSLog(@"date =%@",stringFromDate);
    self.txtTo.text = stringFromDate;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return alltranListArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"allTransactionCell";
    allTransactionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[allTransactionCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
    }
    return cell.frame.size.height;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"----%lu",(unsigned long)dummyArray.count);
    return dummyArray.count; //8;//alltranListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"allTransactionCell";
    allTransactionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[allTransactionCell alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
    }
    /* for(int i=0;i<dummyArray.count;i++){
     [cell.lblKey setText:[dummyArray objectAtIndex:i]];
     
     }*/
   
       //@"Date",@"Sender User",@"Receiver",@"Amount",@"Receiver Gets",@"Buy Boxytel Credit",@"Fee",@"IMTU Credit",@"Total Pay",@"Pay With",@"Receive Option",@"Action",nil];
        if(indexPath.row ==0){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Date"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Date"];
            [cell.lblKey setText:@"Date"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 1){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Sender User"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Sender User"];
            [cell.lblKey setText:@"Sender User"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 2){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Receiver"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Receiver"];
            [cell.lblKey setText:@"Receiver"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 3){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Amount"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Amount"];
            [cell.lblKey setText:@"Amount"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 4){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Receiver Gets"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Receiver Gets"];
            [cell.lblKey setText:@"Receiver Gets"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 5){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Buy Boxytel Credit"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Buy Boxytel Credit"];
            [cell.lblKey setText:@"Buy Boxytel Credit"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 6){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Fee"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Fee"];
            [cell.lblKey setText:@"Fee"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 7){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"IMTU Credit"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"IMTU Credit"];
            [cell.lblKey setText:@"IMTU Credit"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 8){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Total Pay"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Total Pay"];
            [cell.lblKey setText:@"Total Pay"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 9){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Pay With"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Pay With"];
            [cell.lblKey setText:@"Pay With"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 10){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Receive Option"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Receive Option"];
            [cell.lblKey setText:@"Receive Option"];
            [cell.lblVal setText:value];
        }
        else if(indexPath.row == 11){
            NSString *value = [[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Action"] isKindOfClass:[NSNull class]]?@"":[[alltranListArray objectAtIndex:(indexPath.section)]objectForKey:@"Action"];
            [cell.lblKey setText:@"Action"];
            [cell.lblVal setText:value];
        }
        else{
            NSLog(@"hello");
        }
        
        
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 3.0;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 3.0;
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero] ;
}

-(void)makeArray{
    // NSMutableArray *arrayForAll,*arraForFund,*arrayForPinless,*arrayForIMTU;
    
    arraForFund =[[NSArray alloc]init];
    arrayForPinless =[[NSArray alloc]init];
    arrayForIMTU =[[NSArray alloc]init];
    

    
    arraForFund =[NSArray arrayWithObjects:@"Date",@"Sender User",@"Receiver",@"Amount",@"Receiver Gets",@"Buy Boxytel Credit",@"Fee",@"IMTU Credit",@"Total Pay",@"Pay With",@"Receive Option",@"Action",nil];
    
    dummyArray = arraForFund;
   
  }

//for navigation bar
-(void) barButtonFunction
{
    
    /*UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_btn"]style:UIBarButtonItemStylePlain target:self action:@selector(popView:)];
    
    self.navigationController.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationController.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
   */
    /*UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style: UIBarButtonItemStyleBordered target:self action:@selector(Back)];
    self.navigationItem.leftBarButtonItem = backButton;
    */
    
   
    /*
     SWRevealViewController *revealController = [self revealViewController];
     
     [self.view addGestureRecognizer:revealController.panGestureRecognizer];
     
     self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
     
     UIBarButtonItem *rightRevealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"rightMenu"]
     style:UIBarButtonItemStylePlain target:revealController action:@selector(rightRevealToggle:)];
     
     self.navigationItem.rightBarButtonItem = rightRevealButtonItem;
     self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
     
     
     UIImage * logoInNavigationBar = [UIImage imageNamed:@"logo"];
     UIImageView * logoView = [[UIImageView alloc] init];
     [logoView setImage:logoInNavigationBar];
     //self.navigationController.navigationItem.titleView = logoView;
     
     UIImage* logoImage = [UIImage imageNamed:@"logo"];
     self.navigationItem.titleView = [[UIImageView alloc] initWithImage:logoImage];
     */
    
    [self.navigationController.navigationBar setBarTintColor:navigationBarColor];
    
}


-(void)popView:(UIBarButtonItem *)sender
{
    // [appDel setBothMenus];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldShouldBeginEditing");
    if(textField == self.txtFrom)
    {
        [picker2 removeFromSuperview];
        [self.txtFrom resignFirstResponder];
        [self.view addSubview:picker1];
    }
    
    else if(textField == self.txtTo)
    {
        [picker1 removeFromSuperview];
        [self.txtTo resignFirstResponder];
        [self.view addSubview:picker2];
    }
    else if(textField == self.txtSearch)
    {
        return YES;
    }
    return false;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //[textField resignFirstResponder];
   // return YES;
    NSLog(@"textFieldShouldReturn");
    if (textField == self.txtFrom)
    {
        
        //[self.txtFrom resignFirstResponder];
        [self.txtTo becomeFirstResponder];
        [picker1 removeFromSuperview];
    }
    else if (textField == self.txtTo){
        
        //[self.txtTo resignFirstResponder];
        [picker2 removeFromSuperview];
    }
    
    [textField resignFirstResponder];
    
    
    return YES;
}
- (IBAction)btnActionLoadMore:(id)sender {
    searchText = [NSString stringWithFormat:@"%@",self.txtSearch.text];
    start =start+1;
    [self loadSendMoney];
}
- (IBAction)searchButtonTapped:(id)sender {
    [picker1 removeFromSuperview];
    [picker2 removeFromSuperview];
    [alltranListArray removeAllObjects];
    start =1;
    [self loadSendMoney];
}
- (IBAction)resetButtonTapped:(id)sender {
    self.txtFrom.text = @"";
    self.txtTo.text = @"";
    
}
- (IBAction)downloadCVbuttonTapped:(id)sender {
    
        hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text =@"Please Wait";
        
        [self.view addSubview:hud];
        [self.view setUserInteractionEnabled:NO];
        
        
        NSLog(@"slectedTab=%@",slectedTab);
        NSLog(@"athenticationKey=%@",athenticationKey);
        NSLog(@"start=%d",start);
        NSLog(@"end=%d",end);
        NSDictionary *parameters;
        __block NSDictionary* json;
        parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                      userId,@"user_id",
                      athenticationKey,@"authentication_key",
                      @"1",@"page",
                      @"999999",@"record_per_page",
                      searchOption,@"search_column",
                      searchText,@"search_text",
                      self.txtFrom.text,@"from_date",
                      self.txtTo.text,@"to_date",
                      @"",@"sort_by",
                      @"",@"sort_order",
                      nil];
        NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_GETTRANSACTIONCSV];
        NSLog(@"URL====%@",URL);
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
        [request setHTTPMethod:@"POST"];
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSLog(@"URL==%@",URL);
        NSLog(@"parametersAll Trans==%@",parameters);
        
        [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
            
            [hud removeFromSuperview];
            [self.view setUserInteractionEnabled:YES];
            
            NSError *err;
            json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                   options:kNilOptions
                                                     error:&err];
            NSString *Status=[json objectForKey:@"status"];
            if([[NSString stringWithFormat:@"%@",Status] isEqualToString:@"1"]){
                NSString *data =[json objectForKey:@"data"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:data]];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                [alert show];
            }
            
        }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            NSLog(@"error:%@",error.description);
            //return error;
            json = nil;
            
        }];
        
    
 
    
}

// API for pinless and Imtu
-(void)loadSendMoney
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    
    
    //NSLog(@"slectedTab=%@",slectedTab);
    NSLog(@"athenticationKey=%@",athenticationKey);
    NSLog(@"start=%d",start);
    NSLog(@"end=%d",end);
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  [NSString stringWithFormat:@"%d",start],@"page",
                  [NSString stringWithFormat:@"%d",end],@"record_per_page",
                   searchOption,@"search_column",
                  searchText,@"search_text",
                  self.txtFrom.text,@"from_date",
                  self.txtTo.text,@"to_date",
                  @"",@"sort_by",
                  @"",@"sort_order",
                  nil];
    NSString *URL;
      URL= [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_GETSENDMONEYHISTORY];
   
    NSLog(@"URL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"URL==%@",URL);
    NSLog(@"parametersAll Trans==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        NSLog(@"jsonALL TRANS==%@",json);
        NSString *status =[NSString stringWithFormat:@"%@",[json objectForKey:@"status"]];
        if([status isEqualToString:@"1"]){
            
        NSMutableArray *allDataArr = [[NSMutableArray alloc]init];
        allDataArr = [[json objectForKey:@"data"]objectForKey:@"records"];
        NSLog(@"allDataArr==%@",allDataArr);
        
        
        
         for (int i=0; i<[allDataArr count]; i++) {
         NSMutableDictionary *data1 = [[NSMutableDictionary alloc]init];
         
         date=[[allDataArr objectAtIndex:i]objectForKey:@"date"];
         senderUser = [[allDataArr objectAtIndex:i]objectForKey:@"sender_name"];
         receiverName = [[allDataArr objectAtIndex:i]objectForKey:@"rec_name"];
         amount = [[allDataArr objectAtIndex:i]objectForKey:@"amount_sent"];
         amountDel = [[allDataArr objectAtIndex:i]objectForKey:@"amount_delivered"];
         rec_currency = [[allDataArr objectAtIndex:i]objectForKey:@"rec_currency"];
         Boxytel = [[allDataArr objectAtIndex:i]objectForKey:@"extra_earn_amount"];
         imtuCredit = [[allDataArr objectAtIndex:i]objectForKey:@"topup_amount"];
        feeCharge = [[allDataArr objectAtIndex:i]objectForKey:@"fee_charged"];
         toatalPay = [[allDataArr objectAtIndex:i]objectForKey:@"total_pay_amount"];
         payWith = [[allDataArr objectAtIndex:i]objectForKey:@"pay_with_option"];
         rec_Option = [[allDataArr objectAtIndex:i]objectForKey:@"deposit_type"];
         status = [[allDataArr objectAtIndex:i]objectForKey:@"send_status"];
         
         [data1 setObject:date forKey:@"Date"];
         [data1 setObject:senderUser forKey:@"Sender User"];
         [data1 setObject:receiverName forKey:@"Receiver"];
         [data1 setObject:[NSString stringWithFormat:@"$%@",amount] forKey:@"Amount"];
         [data1 setObject:[NSString stringWithFormat:@"%@%@",amountDel,rec_currency] forKey:@"Receiver Gets"];
         [data1 setObject:[NSString stringWithFormat:@"$%@",Boxytel]  forKey:@"Buy Boxytel Credit"];
         [data1 setObject:[NSString stringWithFormat:@"$%@",feeCharge] forKey:@"Fee"];
         [data1 setObject:[NSString stringWithFormat:@"$%@",imtuCredit] forKey:@"IMTU Credit"];
         [data1 setObject:[NSString stringWithFormat:@"$%@",toatalPay] forKey:@"Total Pay"];
         [data1 setObject:payWith forKey:@"Pay With"];
         [data1 setObject:rec_Option forKey:@"Receive Option"];
         [data1 setObject:status forKey:@"Action"];
         //NSLog(@"data1===%@",data1);
         
         [alltranListArray addObject:data1];
         
         
         }
        
        
        [self.tblallTrns setDataSource:self];
        [self.tblallTrns setDelegate:self];
        [self.tblallTrns reloadData];
        NSLog(@"alltranListArray==%@",alltranListArray);
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
        }

    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        //return error;
        json = nil;
        
    }];
}
- (IBAction)btnTabSenderId:(id)sender {
    searchOption=@"sender_user_id";
    [self.btnSender setBackgroundColor:[UIColor colorWithRed:1.00 green:0.55 blue:0.00 alpha:1.0]];
    [self.btnReceiver setBackgroundColor:[UIColor whiteColor]];
}
- (IBAction)btnTabReceiverId:(id)sender {
    searchOption =@"rec_user_id";
    [self.btnReceiver setBackgroundColor:[UIColor colorWithRed:1.00 green:0.55 blue:0.00 alpha:1.0]];
    [self.btnSender setBackgroundColor:[UIColor whiteColor]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)popViews:(id)sender {
    [appDel setBothMenus];
}


@end
