//
//  addCardVC.m
//  BoxyWorld
//
//  Created by Sambaran DAS on 21/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "addCardVC.h"
#import "config.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "config.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"
#import "addFundsvC.h"
@interface addCardVC ()<UIScrollViewDelegate,KPDropMenuDelegate,UITextFieldDelegate>
{
    //NSMutableArray *countryArr,*countryCodeArr,*countryPrefix;
     NSMutableArray *stateArr,*statecode;
     NSArray *monthArr,*yearArr;
     MBProgressHUD *hud;
    NSString *userId ;
    NSString *athenticationKey ;
    NSString  *SmallYR;
    NSString *state_Id;
    IBOutlet UITextField *activeField;
    
}
@end

@implementation addCardVC
@synthesize txtCardNo,txtMnth,txtYear,txtCVV,txtCardHolderName,txtAddress,txtBillingState,txtZipCode,btnAddCard,dropState,scrAddCard,dropmonth,dropyear;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    stateArr = [[NSMutableArray alloc]init];
    statecode = [[NSMutableArray alloc]init];
    [self barButtonFunction];
    [self makeLayout];
    [self loadstate];
     [self loadmonthlist];
    [self loadYearlist];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self registerForKeyboardNotifications];
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
    self.txtCardNo.inputAccessoryView = accessoryView;
    self.txtCVV.inputAccessoryView = accessoryView;
    self.txtZipCode.inputAccessoryView = accessoryView;
    
    }
- (void)selectDoneButton {
    [self.txtCardNo resignFirstResponder];
    [self.txtCVV resignFirstResponder];
    [self.txtZipCode resignFirstResponder];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    activeField = textField;
    int groupingSize = 3;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init] ;
    NSString *separator = @"-";
    [formatter setGroupingSeparator:separator];
    [formatter setGroupingSize:groupingSize];
    [formatter setUsesGroupingSeparator:YES];
    [formatter setSecondaryGroupingSize:4];
    if (textField == txtCardNo)
    {
        if(textField.text.length <19){
            if (![string  isEqual: @""] && (textField.text != nil && textField.text.length > 0)) {
                NSString *num = textField.text;
                num = [num stringByReplacingOccurrencesOfString:separator withString:@""];
                NSString *str = [formatter stringFromNumber:[NSNumber numberWithDouble:[num doubleValue]]];
                txtCardNo.text = str;
            }
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:@"no of digits should be 16" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            }
        }
        return YES;
}
-(void)makeLayout{
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //cardNo
    UIView *paddingtxtCardNo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtCardNo.leftView = paddingtxtCardNo;
    self. txtCardNo.leftViewMode = UITextFieldViewModeAlways;
    self.txtCardNo.layer.borderWidth = 1.3;
    self.txtCardNo.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtCardNo.layer.cornerRadius = 5.0f;
    
    //month
    UIView *paddingmonth = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtMnth.leftView = paddingmonth;
    self. txtMnth.leftViewMode = UITextFieldViewModeAlways;
    self.txtMnth.layer.borderWidth = 1.3;
    self.txtMnth.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtMnth.layer.cornerRadius = 5.0f;
    UIButton *btnMonth = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnMonth addTarget:self action:@selector(btnMonthPressed:) forControlEvents:UIControlEventTouchUpInside];
    btnMonth.frame = CGRectMake(self.txtMnth.bounds.size.width -60, 10, 20, 20);
    [btnMonth setBackgroundImage:[UIImage imageNamed:@"downExpArrw"] forState:UIControlStateNormal];
    [self.txtMnth addSubview:btnMonth];
    //year
    UIView *paddingyear = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtYear.leftView = paddingyear;
    self. txtYear.leftViewMode = UITextFieldViewModeAlways;
    self.txtYear.layer.borderWidth = 1.3;
    self.txtYear.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtYear.layer.cornerRadius = 5.0f;
    UIButton *btnYear = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnYear addTarget:self action:@selector(btnYearPressed:) forControlEvents:UIControlEventTouchUpInside];
    btnYear.frame = CGRectMake(self.txtYear.bounds.size.width -60, 10, 20, 20);
    [btnYear setBackgroundImage:[UIImage imageNamed:@"downExpArrw"] forState:UIControlStateNormal];
    [self.txtYear addSubview:btnYear];
    //CVV
    UIView *paddingCVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtCVV.leftView = paddingCVV;
    self. txtCVV.leftViewMode = UITextFieldViewModeAlways;
    self.txtCVV.layer.borderWidth = 1.3;
    self.txtCVV.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtCVV.layer.cornerRadius = 5.0f;
    
    //CardHolerName
    UIView *paddingName= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtCardHolderName.leftView = paddingName;
    self. txtCardHolderName.leftViewMode = UITextFieldViewModeAlways;
    self.txtCardHolderName.layer.borderWidth = 1.3;
    self.txtCardHolderName.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtCardHolderName.layer.cornerRadius = 5.0f;
    //Address
    UIView *paddingAddress= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtAddress.leftView = paddingAddress;
    self. txtAddress.leftViewMode = UITextFieldViewModeAlways;
    self.txtAddress.layer.borderWidth = 1.3;
    self.txtAddress.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtAddress.layer.cornerRadius = 5.0f;
    
    //BilingState
    UIView *paddingBilingState= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtBillingState.leftView = paddingBilingState;
    self. txtBillingState.leftViewMode = UITextFieldViewModeAlways;
    self.txtBillingState.layer.borderWidth = 1.3;
    self.txtBillingState.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtBillingState.layer.cornerRadius = 5.0f;
    UIButton *btnBilingState = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBilingState addTarget:self action:@selector(txtBillingStatePressed:) forControlEvents:UIControlEventTouchUpInside];
    btnBilingState.frame = CGRectMake(self.txtBillingState.bounds.size.width -90, 10, 20, 20);
    [btnBilingState setBackgroundImage:[UIImage imageNamed:@"downExpArrw"] forState:UIControlStateNormal];
    [self.txtBillingState addSubview:btnBilingState];

    
    //Zipcode
    UIView *paddingZipcode= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtZipCode.leftView = paddingZipcode;
    self.txtZipCode.leftViewMode = UITextFieldViewModeAlways;
    self.txtZipCode.layer.borderWidth = 1.3;
    self.txtZipCode.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtZipCode.layer.cornerRadius = 5.0f;
    
    self.btnAddCard.layer.borderWidth = 1.0;
    self.btnAddCard.layer.borderColor = [UIColor clearColor].CGColor;
    self.btnAddCard.layer.cornerRadius = 5.0f;
}

// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 10);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 10);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// for nevigation bar
-(void) barButtonFunction
{
    
    
    
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_btn"]
                                                                         style:UIBarButtonItemStylePlain target:self action:@selector(popView:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
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
    [self.navigationController popViewControllerAnimated:YES];
}


//for state list
-(void)loadstate
{
    NSLog(@"ppppppppppppppp");
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    
    
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"225",@"country_id",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_GETSTATES];
    NSLog(@"URLloadstate====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"URLURLloadstate--==%@",URL);
    NSLog(@"parametersloadstate==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        NSLog(@"stateresponseObjectloadstate---%@",json);
        // NSString *status= [json objectForKey:@"status"];
        //if([status isEqualToString:@"1"]){
        NSMutableArray *allstateArr = [[NSMutableArray alloc]init];
        allstateArr = [[json objectForKey:@"data"]objectForKey:@"states"];
        //NSLog(@"allstateArr=%@",allstateArr);
        //*stateArr,*statecode;
        for (int j=0; j<[allstateArr count]; j++) {
            // [stateArr addObject:[[allstateArr objectAtIndex:j]objectForKey:@"state_name"]];
            //[statecode addObject:[[allstateArr objectAtIndex:j]objectForKey:@"id"]];
            [stateArr addObject:[[allstateArr objectAtIndex:j]objectForKey:@"state_name"]];
            [statecode addObject:[[allstateArr objectAtIndex:j]objectForKey:@"id"]];
        }
        NSLog(@"allstateArrstatecode=%@",statecode);
        //for drop down
        CGFloat stateX = self.txtBillingState.frame.origin.x;
        CGFloat stateY = self.txtBillingState.frame.origin.y;
        CGFloat stateWidth = self.txtBillingState.frame.size.width;
        CGFloat stateHeight = self.txtBillingState.frame.size.height;
        
        dropState = [[KPDropMenu alloc] initWithFrame:CGRectMake(stateX, stateY, stateWidth, stateHeight)];
        dropState.delegate = self;
        dropState.items = stateArr;
        dropState.itemsIDs=statecode;
        //dropState.title = @"Select State";
        dropState.titleColor=[UIColor grayColor];
        dropState.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
        dropState.titleTextAlignment = NSTextAlignmentLeft;
        dropState.DirectionDown = NO;
        [self.scrAddCard insertSubview:dropState aboveSubview:self.txtBillingState];
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


//for month
-(void)loadmonthlist
{
   //[stateArr addObject:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08"@"09"@"10"@"11"@"12"];
    monthArr= @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
   
        //for drop down
        CGFloat mnthX = self.txtMnth.frame.origin.x;
        CGFloat mnthY = self.txtMnth.frame.origin.y;
        CGFloat mnthWidth = self.txtMnth.frame.size.width;
        CGFloat mnthHeight = self.txtMnth.frame.size.height;
        
        dropmonth = [[KPDropMenu alloc] initWithFrame:CGRectMake(mnthX-10, mnthY, mnthWidth-10, mnthHeight)];
        dropmonth.delegate = self;
        dropmonth.items = monthArr;
        //dropmonth.itemsIDs=statecode;
        //dropState.title = @"Select State";
        dropmonth.titleColor=[UIColor grayColor];
        dropmonth.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
        dropmonth.titleTextAlignment = NSTextAlignmentLeft;
        dropmonth.DirectionDown = YES;
        [self.scrAddCard insertSubview:dropmonth aboveSubview:self.txtMnth];
    

}
-(void)loadYearlist
{
    /*NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    
    NSString *yearString = [formatter stringFromDate:[NSDate date]];*/
     yearArr= @[@"2017",@"2018",@"2019",@"2020",@"2021",@"2022",@"2023",@"2024",@"2025",@"2026",@"2027",@"2028",@"2029",@"2030"];
    
    
    //for drop down
    CGFloat stateX = self.txtYear.frame.origin.x;
    CGFloat stateY = self.txtYear.frame.origin.y;
    CGFloat stateWidth = self.txtYear.frame.size.width;
    CGFloat stateHeight = self.txtYear.frame.size.height;
    
    dropyear = [[KPDropMenu alloc] initWithFrame:CGRectMake(stateX-25, stateY, stateWidth-25, stateHeight)];
    dropyear.delegate = self;
    dropyear.items = yearArr;
    dropyear.itemsIDs=statecode;
    //dropState.title = @"Select State";
    dropyear.titleColor=[UIColor grayColor];
    dropyear.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
    dropyear.titleTextAlignment = NSTextAlignmentLeft;
    dropyear.DirectionDown = YES;
    [self.scrAddCard insertSubview:dropyear aboveSubview:self.txtYear];
    
    
}


-(void)didSelectItem : (KPDropMenu *) dropMenu atIndex : (int) atIntedex{
    
    if(dropMenu == dropState){
        txtBillingState.text = stateArr[atIntedex];
        state_Id = statecode[atIntedex];
        NSLog(@"state_Id=====***%@",state_Id);
    }
    else if(dropMenu == dropmonth){
        txtMnth.text = monthArr[atIntedex];
        
    }
    else if(dropMenu == dropyear){
        txtYear.text = yearArr[atIntedex];
        
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

- (IBAction)addCardAction:(id)sender {
    NSString *stringTest=@"^([+-]?)(?:|0|[1-9]\\d*)?$";
    NSPredicate *numerictest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringTest];
    //Card Number
    if([txtCardNo.text isEqualToString:@""] || [numerictest evaluateWithObject:txtCardNo.text] == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Card Number should not be blank and and must be numaric" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
     else if([txtCardNo.text  length ]!=16 ){
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Card Number must be 16 digit" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
         [alert show];
     }
    //EXp date
    else if([txtMnth.text isEqualToString:@""] || [numerictest evaluateWithObject:txtMnth.text] == YES){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"select month properly" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else if([txtYear.text isEqualToString:@""] || [numerictest evaluateWithObject:txtYear.text] == NO){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"select Year properly" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //CVV
    else if([txtCVV.text isEqualToString:@""] || [numerictest evaluateWithObject:txtCVV.text] == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter CVV no" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //CardHolder Name
    else if([txtCardHolderName.text isEqualToString:@""] || [numerictest evaluateWithObject:txtCardHolderName.text] == YES){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Card holder Name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //Address
    else if([txtAddress.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Confarm your password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //Billing State
    else if([txtBillingState.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"select Billing State" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //zipcode
    else if([txtZipCode.text isEqualToString:@""] || [numerictest evaluateWithObject:txtZipCode.text] == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter proper zipcode" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }

    else{
        [self addCard];
        }
    

    
}
-(void)addCard{
    NSLog(@"sssssssssssss");
    
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
   
    UserSession *getCards = [UserAccessSession getUserSession];
    userId =getCards.reseller_id;
    athenticationKey =getCards.res_user_login_key;
    NSString *SmallYR = [txtYear.text substringFromIndex: [txtYear.text length] - 2];//[txtYear.text substringToIndex:(-2)];
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  
                   txtCardNo.text,@"cc",
                   txtCVV.text,@"cvv",
                   txtMnth.text,@"month",
                   SmallYR,@"year",
                   txtCardHolderName.text,@"card_name",
                  state_Id,@"state_id",
                 txtZipCode.text,@"zipcode",
                  txtAddress.text,@"address",


                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_ADDDEBITCARD];
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
        
        NSLog(@"responseObjectpppppppp---%@",json);
        NSString* status = [NSString stringWithFormat:@"%@", [json objectForKey:@"status"]];
        if([status isEqualToString:@"1"]){
            
            
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:[json objectForKey:@"msg"]delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            addFundsvC *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@"addFunds"];
            // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
            [[self navigationController] pushViewController:vc animated:YES];

            // [appDel setBothMenus];
        }
        else{
            //registerVC1 *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"registation1"];
           // [[self navigationController] pushViewController:vc animated:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
        }
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        //registerVC1 *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
      //  [[self navigationController] pushViewController:vc animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        //return error;
        json = nil;
        
    }];
    
}

//for keypad hide/show
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    
    //NSLog(@"keyboard==%@",aNotification);
    NSDictionary* info = [aNotification userInfo];
    //NSLog(@"text y==%f",activeField.frame.origin.y);
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrAddCard.contentInset = contentInsets;
    scrAddCard.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [scrAddCard setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrAddCard.contentInset = contentInsets;
    scrAddCard.scrollIndicatorInsets = contentInsets;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

//
-(BOOL)textFieldShouldReturn:(UITextField *)textField
//txtCardNo,txtMnth,txtYear,txtCVV,txtCardHolderName,txtAddress,txtBillingState,txtZipCode
{
    //[textField resignFirstResponder];
    NSLog(@"textFieldShouldReturn");
   /* if (textField == txtCardNo)
    {
        [txtCardNo resignFirstResponder];
        [txtCVV becomeFirstResponder];
    }
    else if (textField == txtCVV){
        [txtCVV resignFirstResponder];
        [txtCardHolderName becomeFirstResponder];
    }
    else if (textField == txtCardHolderName){
        [txtCardHolderName resignFirstResponder];
        [txtAddress becomeFirstResponder];
    }
    else if (textField == txtAddress){
        [txtAddress resignFirstResponder];
        [txtZipCode becomeFirstResponder];
    }
    else if (textField == txtZipCode){
        
        
        [txtZipCode resignFirstResponder];
        //[password becomeFirstResponder];
        
    }
        else
    {
        [textField resignFirstResponder];
    }
    */
    [textField resignFirstResponder];
    
    return YES;
}

@end
