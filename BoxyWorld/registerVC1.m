//
//  registerVC1.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 12/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "registerVC1.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "config.h"
#import "AFNetworking.h"
#import "ViewController.h"
#import "AppDelegate.h"

@interface registerVC1 ()<UIScrollViewDelegate,KPDropMenuDelegate>
{
    AppDelegate *appDel;
    NSMutableArray *countryArr,*countryCodeArr,*countryPrefix;
    NSMutableArray *stateArr,*statecode;
    NSString *country_Id;
    NSString *state_Id;
    
    MBProgressHUD *hud;
}
@end

@implementation registerVC1
@synthesize firstName,lastName,email,country,phone,preph,state,RegScrlView,dropcountry,dropState,btnlogin;
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    countryArr = [[NSMutableArray alloc]init];
    countryCodeArr = [[NSMutableArray alloc]init];
     countryPrefix = [[NSMutableArray alloc]init];
    stateArr = [[NSMutableArray alloc]init];
    statecode = [[NSMutableArray alloc]init];
    
        
    [self loadCountry];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self barButtonFunction];
    
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mobileBg.png"]]];
    // Do any additional setup after loading the view.
    [self registerForKeyboardNotifications];
    //for firstname
    UIView *paddingFname = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    firstName.leftView = paddingFname;
    firstName.leftViewMode = UITextFieldViewModeAlways;
    firstName.layer.cornerRadius=8.0f;
    firstName.layer.masksToBounds=YES;
    firstName.layer.borderColor=[[UIColor whiteColor]CGColor];
    firstName.layer.borderWidth= 1.0f;
    firstName.delegate=self;
    //last name
    UIView *paddingLname = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    lastName.leftView = paddingLname;
    lastName.leftViewMode = UITextFieldViewModeAlways;
    lastName.layer.cornerRadius=8.0f;
    lastName.layer.masksToBounds=YES;
    lastName.layer.borderColor=[[UIColor whiteColor]CGColor];
    lastName.layer.borderWidth= 1.0f;
    lastName.delegate=self;
    
    //email
    UIView *paddingEmail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    email.leftView = paddingEmail;
    email.delegate=self;
    email.leftViewMode = UITextFieldViewModeAlways;
    email.layer.cornerRadius=8.0f;
    email.layer.masksToBounds=YES;
    email.layer.borderColor=[[UIColor whiteColor]CGColor];
    email.layer.borderWidth= 1.0f;
    

    
    //country
     UIView *paddingCountry = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    country.leftView = paddingCountry;
    country.leftViewMode = UITextFieldViewModeAlways;
    country.layer.cornerRadius=8.0f;
    country.layer.masksToBounds=YES;
    country.layer.borderColor=[[UIColor whiteColor]CGColor];
    country.layer.borderWidth= 1.0f;
    UIButton *btnCountry = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCountry addTarget:self action:@selector(btnCountryPressed:) forControlEvents:UIControlEventTouchUpInside];
    btnCountry.frame = CGRectMake(self.country.bounds.size.width -30, 10, 20, 20);
    [btnCountry setBackgroundImage:[UIImage imageNamed:@"downExpArrw"] forState:UIControlStateNormal];
    [self.country addSubview:btnCountry];
    //country.delegate=self;

    
    //phone
     UIView *paddingPhone = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
      phone.leftView = paddingPhone;
     phone.leftViewMode = UITextFieldViewModeAlways;
    phone.layer.cornerRadius=8.0f;
    phone.layer.masksToBounds=YES;
    phone.layer.borderColor=[[UIColor whiteColor]CGColor];
    phone.layer.borderWidth= 1.0f;
     phone.delegate=self;
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
    self.phone.inputAccessoryView = accessoryView;
    //preph
     UIView *paddingPreph = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    
    preph.leftView = paddingPreph;
    preph.leftViewMode = UITextFieldViewModeAlways;
    preph.layer.cornerRadius=8.0f;
    preph.layer.masksToBounds=YES;
    preph.layer.borderColor=[[UIColor whiteColor]CGColor];
    preph.layer.borderWidth= 1.0f;
    
    
    //state
     UIView *paddingState = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    state.leftView = paddingState;
    state.leftViewMode = UITextFieldViewModeAlways;
    state.layer.cornerRadius=8.0f;
    state.layer.masksToBounds=YES;
    state.layer.borderColor=[[UIColor whiteColor]CGColor];
    state.layer.borderWidth= 1.0f;
    UIButton *btnState = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnState addTarget:self action:@selector(btnStatePressed:) forControlEvents:UIControlEventTouchUpInside];
    btnState.frame = CGRectMake(self.state.bounds.size.width -30, 10, 20, 20);
    [btnState setBackgroundImage:[UIImage imageNamed:@"downExpArrw"] forState:UIControlStateNormal];
    [self.state addSubview:btnState];
   // state.delegate=self;
    self.btnlogin.layer.cornerRadius = 5.0f;
    [self registerForKeyboardNotifications];
    
    
}
- (void)selectDoneButton {
    [self.phone resignFirstResponder];
    //[self.txtAltrPhone resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    //sender.contentOffset.x = 0.0;
}
- (IBAction)nextBtnTab:(id)sender {
   //NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    //NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    NSString *stringTest=@"^([+-]?)(?:|0|[1-9]\\d*)?$";
    NSPredicate *numerictest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringTest];
    //BOOL phoneValidates = [phoneTest evaluateWithObject:phoneNumber];
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    //firstName
    if([firstName.text isEqualToString:@""] || [numerictest evaluateWithObject:firstName.text] == YES){
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter first Name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //lastname
    else if([lastName.text isEqualToString:@""] || [numerictest evaluateWithObject:lastName.text] == YES){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter last Name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //email
    else if([email.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter proper email id" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        
           }
    
    else if ([emailTest evaluateWithObject:email.text] == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter proper email id" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }

    //country
    else if([country.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please select proper country" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
         //Phone Number
    else if([phone.text isEqualToString:@""]|| [numerictest evaluateWithObject:phone.text] == NO){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Phone Number should not be blank and must be number" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    /* else if (![self validatePhone:phone.text]) {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter proper phone Number" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
         [alert show];
     }*/
    //state
   else if([state.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Select proper State" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else{
        //loader start
        hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text =@"Please Wait";
        
        [self.view addSubview:hud];
        [self.view setUserInteractionEnabled:NO];

    NSLog(@"phone no///*/*/==%@",[NSString stringWithFormat:@"%@%@",preph.text,phone.text]);
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    registerVC2 * vc2 = [storyboard instantiateViewControllerWithIdentifier:@"register2"];
        vc2.fname= firstName.text;
        vc2.lname= lastName.text;
        vc2.email= email.text;
        vc2.country= country_Id;
        vc2.phno= [NSString stringWithFormat:@"%@%@",preph.text,phone.text];
        vc2.state= state_Id;
    [self.navigationController pushViewController:vc2 animated:YES];
    /*
    
     @end
    NSString * storyboardName = @"Main";
    NSString * viewControllerID = @"register2";
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    registerVC2 * controller = (registerVC2 *)[storyboard instantiateViewControllerWithIdentifier:viewControllerID];
    [self presentViewController:controller animated:YES completion:nil];
     */
        
        //loader stop
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
    }
}

-(void)loadCountry
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
     hud.mode = MBProgressHUDModeIndeterminate;
     hud.label.text =@"Please Wait";
     
     [self.view addSubview:hud];
     [self.view setUserInteractionEnabled:NO];
    
    
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_GETCOUNTRY];
    NSLog(@"URL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"URL==%@",URL);
    // NSLog(@"parameters==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
         [hud removeFromSuperview];
         [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        
        NSMutableArray *allcountryArr = [[NSMutableArray alloc]init];
        allcountryArr = [[json objectForKey:@"data"]objectForKey:@"countries"];
        
         [countryArr removeAllObjects];
         [countryCodeArr removeAllObjects];
         [countryPrefix removeAllObjects];
        for (int i=0; i<[allcountryArr count]; i++) {
            [countryArr addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"countryname"]];
            [countryCodeArr addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"id"]];
            [countryPrefix addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"countryprefix"]];
        }
        
        //for drop down
        CGFloat phoneX = self.country.frame.origin.x;
        CGFloat phoneY = self.country.frame.origin.y;
        CGFloat phoneWidth = self.country.frame.size.width;
        CGFloat phoneHeight = self.country.frame.size.height;
        
        dropcountry = [[KPDropMenu alloc] initWithFrame:CGRectMake(phoneX, phoneY, phoneWidth, phoneHeight)];
        dropcountry.delegate = self;
        dropcountry.items = countryArr;
        //dropcountry.title = @"Select Country";
        dropcountry.titleColor=[UIColor whiteColor];
        dropcountry.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
        dropcountry.titleTextAlignment = NSTextAlignmentLeft;
        dropcountry.DirectionDown = YES;
        [self.RegScrlView insertSubview:dropcountry aboveSubview:self.country];
        
        //NSString* status = [NSString stringWithFormat:@"%@", [json objectForKey:@"status"]];
        
        // NSString *logged_in = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"reseller_logged_in"]];
        // dictArrayGeneric=[json objectForKey:@"result"][@"generic"];
        
        
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        registerVC1 *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        [[self navigationController] pushViewController:vc animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        //return error;
        json = nil;
        
    }];
}

-(void)loadstate:(NSString *)countrycode
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    
    
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  countrycode,@"country_id",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_GETSTATES];
    NSLog(@"URL====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"URLURL--==%@",URL);
     NSLog(@"parameters==%@",parameters);
    
    [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject){
        
        [hud removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
        
        NSError *err;
        json = [NSJSONSerialization JSONObjectWithData:responseObject
                                               options:kNilOptions
                                                 error:&err];
        NSLog(@"stateresponseObject---%@",json);
       // NSString *status= [json objectForKey:@"status"];
        //if([status isEqualToString:@"1"]){
        NSMutableArray *allstateArr = [[NSMutableArray alloc]init];
        allstateArr = [[json objectForKey:@"data"]objectForKey:@"states"];
         //NSLog(@"allstateArr=%@",allstateArr);
        //*stateArr,*statecode;
        [stateArr removeAllObjects];
        [statecode removeAllObjects];
        for (int j=0; j<[allstateArr count]; j++) {
           // [stateArr addObject:[[allstateArr objectAtIndex:j]objectForKey:@"state_name"]];
            //[statecode addObject:[[allstateArr objectAtIndex:j]objectForKey:@"id"]];
            [stateArr addObject:[[allstateArr objectAtIndex:j]objectForKey:@"state_name"]];
            [statecode addObject:[[allstateArr objectAtIndex:j]objectForKey:@"id"]];
        }
       
        //for drop down
        CGFloat stateX = self.state.frame.origin.x;
        CGFloat stateY = self.state.frame.origin.y;
        CGFloat stateWidth = self.state.frame.size.width;
        CGFloat stateHeight = self.state.frame.size.height;
        
        dropState = [[KPDropMenu alloc] initWithFrame:CGRectMake(stateX, stateY, stateWidth, stateHeight)];
        dropState.delegate = self;
        dropState.items = stateArr;
        dropState.itemsIDs=statecode;
        //dropState.title = @"Select State";
        dropState.titleColor=[UIColor whiteColor];
        dropState.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
        dropState.titleTextAlignment = NSTextAlignmentLeft;
        dropState.DirectionDown = NO;
        [self.RegScrlView insertSubview:dropState aboveSubview:self.state];
            
            
        //NSString* status = [NSString stringWithFormat:@"%@", [json objectForKey:@"status"]];
        
        // NSString *logged_in = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"reseller_logged_in"]];
        // dictArrayGeneric=[json objectForKey:@"result"][@"generic"];
        
        
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        registerVC1 *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        [[self navigationController] pushViewController:vc animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        //return error;
        json = nil;
        
    }];
}

//function validation email
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
//validation phone no
- (BOOL)validatePhone:(NSString *)phoneNumber
{
    NSLog(@"phoneNumber==%@",phoneNumber);
    NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    NSLog(@"return==%@",[phoneTest evaluateWithObject:phoneNumber]);
    return [phoneTest evaluateWithObject:phoneNumber];
}

- (IBAction)backbtn:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)didSelectItem : (KPDropMenu *) dropMenu atIndex : (int) atIntedex{
    preph.text =@"";
    //NSLog(@"ewrwerwrwerewrer===%@",dropMenu);
    if(dropMenu == dropcountry){
        
        preph.text=countryPrefix[atIntedex];
        country.text=countryArr[atIntedex];
        country_Id=countryCodeArr[atIntedex];
        [self loadstate:countryCodeArr[atIntedex]];
        //NSLog(@"%@ with TAG : %ld", dropMenu.items[atIntedex], (long)dropMenu.tag);
    }
    else if(dropMenu == dropState){
        //NSLog(@"hdfhdfhdfhd--%@",stateArr[atIntedex]);
        NSString *tempState = stateArr[atIntedex];
        self.state.text = tempState;
        state_Id = statecode[atIntedex];
    }
    else{
        //NSLog(@"fghfghfghfghfgh");
        NSString *tempState = stateArr[atIntedex];
        self.state.text = tempState;
        state_Id = statecode[atIntedex];
    }
}

-(void)didShow:(KPDropMenu *)dropMenu{
    NSLog(@"didShow");
}

-(void)didHide:(KPDropMenu *)dropMenu{
    NSLog(@"didHide");
}

// for nevigation bar
-(void) barButtonFunction
{
    
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_btn"]
                                                                         style:UIBarButtonItemStylePlain target:self action:@selector(popView:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    
    [self.navigationController.navigationBar setBarTintColor:navigationBarColor];
    
    self.navigationController.navigationBar.hidden = NO;
    
}
-(void)popView:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    //[appDel setBothMenus];
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
    RegScrlView.contentInset = contentInsets;
    RegScrlView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [RegScrlView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    RegScrlView.contentInset = contentInsets;
    RegScrlView.scrollIndicatorInsets = contentInsets;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
 activeField = textField;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
//
-(BOOL)textFieldShouldReturn:(UITextField *)textField
//firstName,lastName,email,country,phone,preph,state
{
    //[textField resignFirstResponder];
    NSLog(@"textFieldShouldReturn");
    if (textField == firstName)
    {
        [firstName resignFirstResponder];
        [lastName becomeFirstResponder];
    }
    else if (textField == lastName){
        [lastName resignFirstResponder];
        [email becomeFirstResponder];
    }
    else if (textField == email){
        [email resignFirstResponder];
        [country becomeFirstResponder];
    }
    
    else if (textField == phone){
        [phone resignFirstResponder];
        [state becomeFirstResponder];
    }
    
    else
    {
        [textField resignFirstResponder];
    }
    
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnTablogin:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
    //ViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"loginSB"];
    // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
    //[[self navigationController] pushViewController:vc animated:YES];
}

@end
