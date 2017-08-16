//
//  addSubAgentVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 23/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "addSubAgentVC.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "config.h"
#import "AFNetworking.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "UserAccessSession.h"
#import "ViewController.h"
#import "subAgentVC.h"

@interface addSubAgentVC ()<UITextFieldDelegate>
{
    AppDelegate *appDel;
    NSMutableArray* countryArr ;
    NSMutableArray *countryCodeArr,*countryPrefix;
    NSMutableArray *stateArr,*statecode;
    NSString *country_Id;
    NSString *state_Id;
    NSString *userId ;
    NSString *athenticationKey ;
    NSString *prephno;
    
    
    MBProgressHUD *hud;
    NSString *CCode,*stateCode;
    
}
@end

@implementation addSubAgentVC
@synthesize scrollAddSubAgent;
@synthesize dropcountry,dropState;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self barButtonFunction];
    [self makeLayout];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     appDel = [AppDelegate instance];
    countryArr = [[NSMutableArray alloc] init];
    stateArr = [[NSMutableArray alloc] init];
    statecode = [[NSMutableArray alloc]init];
    countryPrefix = [[NSMutableArray alloc]init];
    countryCodeArr = [[NSMutableArray alloc]init];
    
    [self loadCountry];
    [self registerForKeyboardNotifications];
    
    UserSession *userData = [UserAccessSession getUserSession];
    userId =userData.reseller_id;
    athenticationKey =userData.res_user_login_key;
    
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
    self.txtPhone.inputAccessoryView = accessoryView;
    self.txtAltrPhone.inputAccessoryView = accessoryView;
    self.txtZipCode.inputAccessoryView = accessoryView;
    self.txtZipCode.keyboardType = UIKeyboardTypePhonePad;
    
}

- (void)selectDoneButton {
    [self.txtPhone resignFirstResponder];
    [self.txtAltrPhone resignFirstResponder];
    [self.txtZipCode resignFirstResponder];
}
/*-(void)dp_Selected:(id)dp {
    if(dp == self.downPicker)
    {
        NSString* selectedValue = [self.downPicker text];
         NSLog(@"countryCode===%@",countryCodeArr[self.downPicker.selectedIndex]);
        CCode = countryCodeArr[self.downPicker.selectedIndex];
        NSLog(@"selectedValue==%@",selectedValue);
        // do what you want
        //[self.txtCCode setText:countryCodeArr[self.downPicker.selectedIndex]];
        prephno = countryCodeArr[self.downPicker.selectedIndex];
        [self loadstate:countryCodeArr[self.downPicker.selectedIndex]];
    }
}
-(void)dp_SelectedState:(id)dp {
    if(dp == self.downPickerState)
    {
        NSString* selectedValue = [self.downPickerState text];
        NSLog(@"statecode===%@",statecode[self.downPickerState.selectedIndex]);
        stateCode = statecode[self.downPickerState.selectedIndex];
        NSLog(@"selectedValue==%@",selectedValue);
        self.txtCCode.text=prephno;
        
    }
    // do what you want
}
 */
-(void)makeLayout{
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIView *paddingtxtFName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtFName.leftView = paddingtxtFName;
    self.txtFName.leftViewMode = UITextFieldViewModeAlways;
    self.txtFName.layer.borderWidth = 1.3;
    self.txtFName.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtFName.layer.cornerRadius = 5.0f;
    self.txtFName.delegate = self;
    
    UIView *paddingtxtLName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtLName.leftView = paddingtxtLName;
    self.txtLName.leftViewMode = UITextFieldViewModeAlways;
    self.txtLName.layer.borderWidth = 1.3;
    self.txtLName.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtLName.layer.cornerRadius = 5.0f;
    self.txtLName.delegate = self;
    
    UIView *paddingtxtEmail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtEmail.leftView = paddingtxtEmail;
    self.txtEmail.leftViewMode = UITextFieldViewModeAlways;
    self.txtEmail.layer.borderWidth = 1.3;
    self.txtEmail.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtEmail.layer.cornerRadius = 5.0f;
    self.txtEmail.delegate = self;
    
    UIView *paddingtxtCCode = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtCCode.leftView = paddingtxtCCode;
    self.txtCCode.leftViewMode = UITextFieldViewModeAlways;
    self.txtCCode.layer.borderWidth = 1.3;
    self.txtCCode.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtCCode.layer.cornerRadius = 5.0f;
    self.txtCCode.delegate = self;
    
    UIView *paddingtxtPhone = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtPhone.leftView = paddingtxtPhone;
    self.txtPhone.leftViewMode = UITextFieldViewModeAlways;
    self.txtPhone.layer.borderWidth = 1.3;
    self.txtPhone.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtPhone.layer.cornerRadius = 5.0f;
    self.txtPhone.delegate = self;
    
    UIView *paddingtxtAltrPhone = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtAltrPhone.leftView = paddingtxtAltrPhone;
    self.txtAltrPhone.leftViewMode = UITextFieldViewModeAlways;
    self.txtAltrPhone.layer.borderWidth = 1.3;
    self.txtAltrPhone.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtAltrPhone.layer.cornerRadius = 5.0f;
    self.txtAltrPhone.delegate = self;
    
    UIView *paddingtxtAddress = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtAddress.leftView = paddingtxtAddress;
    self.txtAddress.leftViewMode = UITextFieldViewModeAlways;
    self.txtAddress.layer.borderWidth = 1.3;
    self.txtAddress.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtAddress.layer.cornerRadius = 5.0f;
    self.txtAddress.delegate = self;
    
    UIView *paddingtxtCountry = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtCountry.leftView = paddingtxtCountry;
    self.txtCountry.leftViewMode = UITextFieldViewModeAlways;
    self.txtCountry.layer.borderWidth = 1.3;
    self.txtCountry.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtCountry.layer.cornerRadius = 5.0f;
    self.txtCountry.delegate = self;
    UIButton *btnCountry = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCountry addTarget:self action:@selector(btnCountryPressed:) forControlEvents:UIControlEventTouchUpInside];
    btnCountry.frame = CGRectMake(self.txtCountry.bounds.size.width -30, 10, 20, 20);
    [btnCountry setBackgroundImage:[UIImage imageNamed:@"downExpArrw"] forState:UIControlStateNormal];
    [self.txtCountry addSubview:btnCountry];
    
    UIView *paddingtxtCity = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtCity.leftView = paddingtxtCity;
    self.txtCity.leftViewMode = UITextFieldViewModeAlways;
    self.txtCity.layer.borderWidth = 1.3;
    self.txtCity.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtCity.layer.cornerRadius = 5.0f;
    self.txtCity.delegate = self;
    
    UIView *paddingtxtPwd = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtPwd.leftView = paddingtxtPwd;
    self.txtPwd.leftViewMode = UITextFieldViewModeAlways;
    self.txtPwd.layer.borderWidth = 1.3;
    self.txtPwd.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtPwd.layer.cornerRadius = 5.0f;
    self.txtPwd.delegate = self;
    
    UIView *paddingtxtCPWD = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtCPWD.leftView = paddingtxtCPWD;
    self.txtCPWD.leftViewMode = UITextFieldViewModeAlways;
    self.txtCPWD.layer.borderWidth = 1.3;
    self.txtCPWD.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtCPWD.layer.cornerRadius = 5.0f;
    self.txtCPWD.delegate = self;
    
    UIView *paddingtxtState = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtState.leftView = paddingtxtState;
    self.txtState.leftViewMode = UITextFieldViewModeAlways;
    self.txtState.layer.borderWidth = 1.3;
    self.txtState.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtState.layer.cornerRadius = 5.0f;
    self.txtState.delegate = self;
    UIButton *btnState = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnState addTarget:self action:@selector(btnStatePressed:) forControlEvents:UIControlEventTouchUpInside];
    btnState.frame = CGRectMake(self.txtState.bounds.size.width -80, 10, 20, 20);
    [btnState setBackgroundImage:[UIImage imageNamed:@"downExpArrw"] forState:UIControlStateNormal];
    [self.txtState addSubview:btnState];
    
    UIView *paddingtxtZipCode = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtZipCode.leftView = paddingtxtZipCode;
    self.txtZipCode.leftViewMode = UITextFieldViewModeAlways;
    self.txtZipCode.layer.borderWidth = 1.3;
    self.txtZipCode.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtZipCode.layer.cornerRadius = 5.0f;
    self.txtZipCode.delegate = self;
    
    UIView *paddingtxtBusinessName = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtBusinessName.leftView = paddingtxtBusinessName;
    self.txtBusinessName.leftViewMode = UITextFieldViewModeAlways;
    self.txtBusinessName.layer.borderWidth = 1.3;
    self.txtBusinessName.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtBusinessName.layer.cornerRadius = 5.0f;
    self.txtBusinessName.delegate = self;
    
    UIView *paddingtxtCommision = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.txtCommision.leftView = paddingtxtCommision;
    self.txtCommision.leftViewMode = UITextFieldViewModeAlways;
    self.txtCommision.layer.borderWidth = 1.3;
    self.txtCommision.layer.borderColor = textFieldBorderColor.CGColor;
    self.txtCommision.layer.cornerRadius = 5.0f;
    self.txtCommision.delegate = self;
    
    //self.btnSubmit.layer.borderWidth = 1.0;
    self.btnSubmit.layer.borderColor = [UIColor clearColor].CGColor;
    self.btnSubmit.layer.cornerRadius = 6.0f;
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
    scrollAddSubAgent.contentInset = contentInsets;
    scrollAddSubAgent.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [scrollAddSubAgent setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollAddSubAgent.contentInset = contentInsets;
    scrollAddSubAgent.scrollIndicatorInsets = contentInsets;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

//
-(BOOL)textFieldShouldReturn:(UITextField *)textField


{
    //[textField resignFirstResponder];
   /* NSLog(@"textFieldShouldReturn");
    if (textField == self.txtFName)
    {
        [self.txtFName resignFirstResponder];
        [self.txtLName becomeFirstResponder];
    }
    else if (textField == self.txtLName){
        [self.txtLName resignFirstResponder];
        [self.txtEmail becomeFirstResponder];
    }
    else if (textField == self.txtEmail){
        [self.txtEmail resignFirstResponder];
        [self.txtPhone becomeFirstResponder];
    }
    else if (textField == self.txtPhone){
        [self.txtPhone resignFirstResponder];
        [self.txtAltrPhone becomeFirstResponder];
        
    }
    else if (textField == self.txtAltrPhone){
        [self.txtAltrPhone resignFirstResponder];
        [self.txtAddress becomeFirstResponder];
    }
    else if (textField == self.txtAddress){
        [self.txtAddress resignFirstResponder];
        [self.txtCity becomeFirstResponder];
        
    }
    else if (textField == self.txtCity){
        
        [self.txtCity  resignFirstResponder];
        [self.txtZipCode becomeFirstResponder];
        
    }
    else if (textField == self.txtZipCode){
        [self.txtZipCode resignFirstResponder];
        [self.txtPwd becomeFirstResponder];
        
    }
    else if (textField == self.txtPwd){
        [self.txtPwd resignFirstResponder];
        [self.txtCPWD becomeFirstResponder];
        
    }
    else if (textField == self.txtCPWD){
        [self.txtCPWD resignFirstResponder];
        [self.txtBusinessName becomeFirstResponder];
        
    }
    else if (textField == self.txtBusinessName){
        [self.txtBusinessName resignFirstResponder];
        [self.txtCommision becomeFirstResponder];
        
    }
    else
    {
    */
        [textField resignFirstResponder];
    //}
    
    return YES;
}
- (IBAction)submitAddSubAgent:(id)sender {
    
    //NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    //NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    NSString *stringTest=@"^([+-]?)(?:|0|[1-9]\\d*)?$";
    NSPredicate *numerictest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringTest];
    //BOOL phoneValidates = [phoneTest evaluateWithObject:phoneNumber];
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    //firstName
    if([self.txtFName.text isEqualToString:@""] || [numerictest evaluateWithObject: self.txtFName.text] == YES){
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter first Name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //lastname
    else if([self.txtLName.text isEqualToString:@""] || [numerictest evaluateWithObject:self.txtLName.text] == YES){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter last Name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //email
    else if([self.txtEmail.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter proper email id" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }
    
    else if ([emailTest evaluateWithObject:self.txtEmail.text] == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter proper email id" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //country
    else if([self.txtCountry.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please select proper country" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //state
    else if([self.txtState.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Select proper State" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }

    //Phone Number
    else if([self.txtPhone.text isEqualToString:@""]|| [numerictest evaluateWithObject:self.txtPhone.text] == NO){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Phone Number should not be blank and must be number" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //alter Phone Number
   /* else if( ![self.txtAltrPhone.text isEqualToString:@""]){
        if([numerictest evaluateWithObject:self.txtAltrPhone.text] == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Phone Number should not be blank and must be number" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
         [alert show];
        }
    }
*/
    //txtAddress
    else if([self.txtAddress.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter your address" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }

      //txtCity
    else if([self.txtCity.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter your city" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //zipcode
    else if([self.txtZipCode.text isEqualToString:@""] || [numerictest evaluateWithObject:self.txtZipCode.text] == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter proper zipcode" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }

    //password
    else if([self.txtPwd.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //cPassword
    else if([self.txtCPWD.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Confarm your password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else if(![self.txtCPWD.text isEqualToString:self.txtPwd.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@" password not match" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }
   
    
    //busnessName
    else if([ self.txtBusinessName.text isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please select proper busnessName" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //self.txtCommision
    else if([self.txtCommision.text isEqualToString:@""] || [numerictest evaluateWithObject:self.txtCommision.text] == NO){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Commission" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    else{
         [self SaveAddSubAgent];
    }
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
         NSLog(@"json==%@",json);
        NSMutableArray *allcountryArr = [[NSMutableArray alloc]init];
        allcountryArr = [[json objectForKey:@"data"]objectForKey:@"countries"];
       // countryCodeArr = [[NSMutableArray alloc]init];
        
        NSLog(@"allcountryArr==%@",allcountryArr);
        
         [countryArr removeAllObjects];
         [countryCodeArr removeAllObjects];
         [countryPrefix removeAllObjects];
        
        
        
        for (int i=0; i<[allcountryArr count]; i++) {
            NSLog(@"countryPref%d==%@",i,[[allcountryArr objectAtIndex:i]objectForKey:@"countryprefix"]);
            [countryArr addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"countryname"]];
            [countryCodeArr addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"id"]];
            [countryPrefix addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"countryprefix"]];
            //[countryPrefix addObject:[[allcountryArr objectAtIndex:i]objectForKey:@"countryprefix"]];
        }
       // NSLog(@"countryArr==%@",countryArr);
         NSLog(@"countryCodeArr==%@",countryCodeArr);
         //NSLog(@"countryprefix==%@",countryPrefix);
        
        // bind yourTextField to DownPicker
      /*  self.downPicker = [[DownPicker alloc] initWithTextField:self.txtCountry withData:countryArr];
        [self.downPicker addTarget:self
                            action:@selector(dp_Selected:)
                  forControlEvents:UIControlEventValueChanged];*/
        CGFloat phoneX = self.txtCountry.frame.origin.x;
        CGFloat phoneY = self.txtCountry.frame.origin.y;
        CGFloat phoneWidth = self.txtCountry.frame.size.width;
        CGFloat phoneHeight = self.txtCountry.frame.size.height;
        dropcountry = [[KPDropMenu alloc] initWithFrame:CGRectMake(phoneX, phoneY, phoneWidth, phoneHeight)];
        dropcountry.delegate = self;
        dropcountry.items = countryArr;
        //dropcountry.title = @"Select Country";
        dropcountry.titleColor=[UIColor whiteColor];
        dropcountry.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
        dropcountry.titleTextAlignment = NSTextAlignmentLeft;
        dropcountry.DirectionDown = YES;
        [self.scrollAddSubAgent insertSubview:dropcountry aboveSubview:self.txtCountry];
        
        //NSString* status = [NSString stringWithFormat:@"%@", [json objectForKey:@"status"]];
        
        // NSString *logged_in = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"reseller_logged_in"]];
        // dictArrayGeneric=[json objectForKey:@"result"][@"generic"];
        
        
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
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
        
        // bind yourTextField to DownPicker
       /* self.downPickerState = [[DownPicker alloc] initWithTextField:self.txtState withData:stateArr];
        [self.downPickerState addTarget:self
                            action:@selector(dp_SelectedState:)
                  forControlEvents:UIControlEventValueChanged];*/
        CGFloat stateX = self.txtState.frame.origin.x;
        CGFloat stateY = self.txtState.frame.origin.y;
        CGFloat stateWidth = self.txtState.frame.size.width;
        CGFloat stateHeight = self.txtState.frame.size.height;
        dropState = [[KPDropMenu alloc] initWithFrame:CGRectMake(stateX, stateY, stateWidth, stateHeight)];
        dropState.delegate = self;
        dropState.items = stateArr;
        dropState.itemsIDs=statecode;
        //dropState.title = @"Select State";
        dropState.titleColor=[UIColor whiteColor];
        dropState.itemsFont = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
        dropState.titleTextAlignment = NSTextAlignmentLeft;
        dropState.DirectionDown = YES;
        [self.scrollAddSubAgent insertSubview:dropState aboveSubview:self.txtState];
        
        
        //NSString* status = [NSString stringWithFormat:@"%@", [json objectForKey:@"status"]];
        
        // NSString *logged_in = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"reseller_logged_in"]];
        // dictArrayGeneric=[json objectForKey:@"result"][@"generic"];
        
        
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        NSLog(@"error:%@",error.description);
        //return error;
        json = nil;
        
    }];
}
-(void)didSelectItem : (KPDropMenu *) dropMenu atIndex : (int) atIntedex{
    
    if(dropMenu == dropcountry){
        
        prephno = countryPrefix[atIntedex];
        self.txtCountry.text=countryArr[atIntedex];
        country_Id=countryCodeArr[atIntedex];
        [self loadstate:country_Id];//countryCodeArr[atIntedex]];
        //NSLog(@"%@ with TAG : %ld", dropMenu.items[atIntedex], (long)dropMenu.tag);
    }
    else if(dropMenu == dropState){
        NSLog(@"prephno==%@",prephno);
        self.txtState.text = stateArr[atIntedex];
        NSLog(@"value==%@",self.txtState.text);
        state_Id = statecode[atIntedex];
        self.txtCCode.text = prephno;
    }
    else{
        // NSLog(@"%@", dropMenu.items[atIntedex]);
    }
}

-(void)SaveAddSubAgent
{
    NSLog(@"SubmitAddCustomer");
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    
    UserSession *addCustomer = [UserAccessSession getUserSession];
    userId =addCustomer.reseller_id;
    athenticationKey =addCustomer.res_user_login_key;
    
       NSString *phone = [NSString stringWithFormat:@"%@%@",self.txtCCode.text,self.txtPhone.text];
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  self.txtFName.text,@"firstname",
                  self.txtLName.text,@"lastname",
                  self.txtEmail.text,@"email",
                  phone,@"phone",
                 country_Id,@"country",
                  state_Id,@"state",
                  self.txtZipCode.text,@"zipcode",
                  self.txtAddress.text,@"address",
                  self.txtCity.text,@"city",
                  self.txtAltrPhone.text,@"alt_phone",
                  self.txtBusinessName.text,@"business_name",
                  self.txtCommision.text,@"commission",
                  @"1",@"from_sub_account",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_ADDSubAgent];
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
        NSString  *status = [NSString stringWithFormat:@"%@",[json objectForKey:@"status"]];
        NSLog(@"get_userDetailsByPhno==%@",json);
        if([status isEqualToString:@"1"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"successfull" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
           subAgentVC *vc=[mainStoryboard instantiateViewControllerWithIdentifier:@"subAgentlist"];
            // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
            [[self navigationController] pushViewController:vc animated:YES];
        }
        else{
            if([[json objectForKey:@"msg"] isEqualToString:@"Authentication key is invalid."])
            {
                [UserAccessSession clearAllSession];
                NSLog(@"clickedButtonAtIndex");
                SWRevealViewController *revealController = self.revealViewController;
                NSString * storyboardName = @"Main";
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
                ViewController * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"loginSB"];
                // [revealController setFrontViewPosition:vc1 animated:YES];
                UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
                [revealController pushFrontViewController:frontNavigationController animated:YES];
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
            
        }
        
        
        
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        
        // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
        // [[self navigationController] pushViewController:vc animated:YES];
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
