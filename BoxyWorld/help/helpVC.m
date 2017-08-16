//
//  helpVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 11/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "helpVC.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "config.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"

@interface helpVC ()
{
   
    AppDelegate *appDel;
    MBProgressHUD *hud;
    NSString *userId ;
    NSString *athenticationKey;
    NSMutableArray *priority;
}

@end

@implementation helpVC
@synthesize txtFrom,txtpriority,txtSub,txtmsg,btnSent,scrHelp,dropPriority;


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //faqCatagoryIcon = [[NSMutableArray alloc]init];
    self.title = @"BoxyWorld For Support";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self barButtonFunction];
    // [self buttonShowHide];
    [self makeLayout];
    appDel = [AppDelegate instance];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    priority = [NSMutableArray arrayWithObjects: @"High", @"Security Issue", @"Very Urgent",  nil];
    // Do any additional setup after loading the view.
    [self registerForKeyboardNotifications];
}
-(void)makeLayout{
    
   /* [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];*/
    
    UIView *paddingFrom = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtFrom.leftView = paddingFrom;
    txtFrom.leftViewMode = UITextFieldViewModeAlways;
    txtFrom.layer.borderWidth = 1.3;
    txtFrom.layer.borderColor = textFieldBorderColor.CGColor;
    txtFrom.layer.cornerRadius = 5.0f;
    txtFrom.delegate=self;
    
    UIView *paddingPriority = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtpriority.leftView = paddingPriority;
    txtpriority.leftViewMode = UITextFieldViewModeAlways;
    txtpriority.delegate=self;
    txtpriority.layer.borderWidth = 1.3;
    txtpriority.layer.borderColor = textFieldBorderColor.CGColor;
    txtpriority.layer.cornerRadius = 5.0f;
    //for drop down
    CGFloat phoneX = txtpriority.frame.origin.x;
    CGFloat phoneY = txtpriority.frame.origin.y;
    CGFloat phoneWidth = txtpriority.frame.size.width;
    CGFloat phoneHeight =txtpriority.frame.size.height;
    
    dropPriority = [[KPDropMenu alloc] initWithFrame:CGRectMake(phoneX, phoneY, phoneWidth, phoneHeight)];
   // dropPriority.self.layer.borderColor = [UIColor blackColor].CGColor;
    dropPriority.delegate = self;
    dropPriority.items = priority;
    //dropPriority.title = @"Select Priority";
    dropPriority.titleColor=[UIColor blackColor];
    dropPriority.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
    dropPriority.titleTextAlignment = NSTextAlignmentLeft;
    dropPriority.DirectionDown = YES;
   
    [self.scrHelp insertSubview:dropPriority aboveSubview:txtpriority];
    

    
    
    UIView *paddingsub= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtSub.leftView = paddingsub;
    txtSub.leftViewMode = UITextFieldViewModeAlways;
    txtSub.delegate=self;
    txtSub.layer.borderWidth = 1.3;
    txtSub.layer.borderColor = textFieldBorderColor.CGColor;
    txtSub.layer.cornerRadius = 5.0f;
    
    
    UIView *paddingMsg= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    //txtmsg.leftView = paddingMsg;
   // txtmsg.leftViewMode = UITextFieldViewModeAlways;
    txtmsg.delegate=self;
    txtmsg.layer.borderWidth = 1.3;
    txtmsg.layer.borderColor = textFieldBorderColor.CGColor;
    txtmsg.layer.cornerRadius = 5.0f;
    
    //self.btnSubmit.layer.borderWidth = 1.0;
    self.btnSent.layer.borderColor = [UIColor clearColor].CGColor;
    self.btnSent.layer.cornerRadius = 6.0f;
}
-(void)didSelectItem : (KPDropMenu *) dropMenu atIndex : (int) atIntedex{
    
    if(dropMenu == dropPriority){
        
        //preph.text=countryPrefix[atIntedex];
       // dropPriority.title = @"";
        txtpriority.text=priority[atIntedex];
        //country_Id=countryCodeArr[atIntedex];
       // [self loadstate:countryCodeArr[atIntedex]];
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

-(void)loadHelp
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    UserSession *addCustomer = [UserAccessSession getUserSession];
    userId =addCustomer.reseller_id;
    athenticationKey =addCustomer.res_user_login_key;
    
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  txtpriority.text,@"priority",
                  txtSub.text,@"subject",
                  txtmsg.text,@"message",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_HELP];
    //NSLog(@"URL====help%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   // NSLog(@"URL==help%@",URL);
    //NSLog(@"parameters==help%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [[NSDictionary alloc]init];
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
       // NSLog(@"help==%@",json);
        
        NSString *status =[NSString stringWithFormat:@"%@",[json objectForKey:@"status"]];
        if([status isEqualToString:@"1"]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];

           /* allFaqqstnArr = [json objectForKey:@"data"];
            [faqtblview setDataSource:self];
            [faqtblview setDelegate:self];
            [faqtblview reloadData];*/
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
        }
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        // registerVC1 *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        //[[self navigationController] pushViewController:vc animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        //return error;
        json = nil;
        
    }];
    
}
//Back Button Action
- (IBAction)btnBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:NO completion:nil];
}
// for nevigation bar
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
    [appDel setBothMenus];
    //[self.navigationController popViewControllerAnimated:YES];
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
    NSLog(@"keyboard==%@",aNotification);
    NSDictionary* info = [aNotification userInfo];
    //NSLog(@"text y==%f",activeField.frame.origin.y);
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrHelp.contentInset = contentInsets;
    scrHelp.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [scrHelp setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrHelp.contentInset = contentInsets;
    scrHelp.scrollIndicatorInsets = contentInsets;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    //[textField resignFirstResponder];
    NSLog(@"textFieldShouldReturn");
    //txtFrom,txtpriority,txtSub,txtmsg
    if (textField == txtFrom)
    {
        [txtFrom resignFirstResponder];
        [txtpriority becomeFirstResponder];
    }
        else if (textField == txtpriority){
        [txtpriority resignFirstResponder];
        [txtSub becomeFirstResponder];
        
    }
    else if (textField == txtSub){
        [txtSub resignFirstResponder];
        [txtmsg becomeFirstResponder];
        
    }
    else if (textField == txtmsg){
        [txtmsg resignFirstResponder];
        // [self.txtBusinessName becomeFirstResponder];
        
    }
    else
    {
        [textField resignFirstResponder];
    }    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnSendAction:(id)sender {
    //NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    //NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    NSString *stringTest=@"^([+-]?)(?:|0|[1-9]\\d*)?$";
    NSPredicate *numerictest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringTest];
    //BOOL phoneValidates = [phoneTest evaluateWithObject:phoneNumber];
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    //txtFrom,txtpriority,txtSub,txtmsg,
    //from
    if([self.txtFrom.text isEqualToString:@""]){
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter from" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    
    //priority
    else if([self.txtpriority.text isEqualToString:@""] ){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Select Priority" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    
    //txtSub
    else if([txtSub.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter subject" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }
       //msg
    else if([self.txtmsg.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter your massege" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    
        else{
        [self loadHelp];
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
