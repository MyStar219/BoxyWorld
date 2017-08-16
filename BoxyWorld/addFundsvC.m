//
//  addFundsvC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 16/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "addFundsvC.h"
#import "addfundsCell1.h"
#import "addCardVC.h"
#import "MGUtilities.h"
#import "MBProgressHUD.h"
#import "config.h"
#import "AFNetworking.h"
#import "UserAccessSession.h"

@interface addFundsvC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    BOOL secletToggleBtn;
    MBProgressHUD *hud;
    NSMutableArray *allCardsArr;
    NSString *userId ;
    NSString *athenticationKey ;
    NSString* status ;
    NSString *cardType;
    NSString *cardImg;
    NSString *cardNo;
    NSString *cardID;
    NSString *selectedCard;
    double rowheight;
    
}
@end

@implementation addFundsvC
@synthesize addFundsView,progressPaymentBtn,totalDueLbl,amountFld,swtView,scrollAddFunds,viewtotalDue;
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    allCardsArr = [[NSMutableArray alloc]init];
    cardType = [[NSMutableArray alloc]init];
    cardImg = [[NSMutableArray alloc]init];
    cardNo = [[NSMutableArray alloc]init];
    [self get_cards];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Add Funds";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    /* addFundsListArray = [[NSMutableArray alloc]init];
     NSMutableDictionary *card1 = [[NSMutableDictionary alloc]init];
     [card1 setObject:@"Visa" forKey:@"cardType"];
     [card1 setObject:@"visa" forKey:@"photos"];
     [card1 setObject:@"XXXX-XXXX-XXXX-1111" forKey:@"cardNo"];
     [card1 setObject:@"NO" forKey:@"selected"];
     
     NSMutableDictionary *card2 = [[NSMutableDictionary alloc]init];
     [card2 setObject:@"Mastercard" forKey:@"cardType"];
     [card2 setObject:@"masterCard" forKey:@"photos"];
     [card2 setObject:@"XXXX-XXXX-XXXX-8888" forKey:@"cardNo"];
     [card2 setObject:@"NO" forKey:@"selected"];
     
     NSMutableDictionary *card3 = [[NSMutableDictionary alloc]init];
     [card3 setObject:@"Visa" forKey:@"cardType"];
     [card3 setObject:@"visa" forKey:@"photos"];
     [card3 setObject:@"XXXX-XXXX-XXXX-1111" forKey:@"cardNo"];
     [card3 setObject:@"NO" forKey:@"selected"];
     
     _scrollAddFunds.delegate = self;
     [addFundsListArray addObject:card1];
     [addFundsListArray addObject:card2];
     [addFundsListArray addObject:card3];*/
    
    [addFundsView registerNib:[UINib nibWithNibName:@"addfundsCell1" bundle:nil]forCellReuseIdentifier:@"addfundsCell1"];
    // Do any additional setup after loading the view.
    
    // [_scrollAddFunds setFrame:CGRectMake(_scrollAddFunds.frame.origin.x, _scrollAddFunds.frame.origin.y, [UIScreen mainScreen].bounds.size.width, _scrollAddFunds.frame.size.height)];
    //[_scrollAddFunds setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 3000)];
    
    
    [addFundsView reloadData];
    addFundsView.layer.borderWidth = 0.6;
    addFundsView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    addFundsView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //addFundsView
    progressPaymentBtn.layer.cornerRadius=8.0f;
    amountFld.layer.cornerRadius=10.0f;
    amountFld.layer.borderWidth=1.0f;
    amountFld.layer.borderColor=[UIColor lightGrayColor].CGColor;
    swtView.layer.cornerRadius = 20.0f;
    amountFld.delegate = self;
    self.btnAddCard.layer.cornerRadius=5.0f;
    //btnAddCard.layer.cornerRadius = 5.0f;
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
    self.amountFld.inputAccessoryView = accessoryView;
    
}
- (void)selectDoneButton {
    if([totalDueLbl.text isEqualToString:@""]){
        NSString *a=@"0.00";
        totalDueLbl.text =[NSString stringWithFormat:@"%@",a];
    }
    else{
        totalDueLbl.text =[NSString stringWithFormat:@"$%@.00",amountFld.text];
    }

    [self.amountFld resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > 0)
        scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"addfundsCell1";
    addfundsCell1 *cell = [addFundsView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[addfundsCell1 alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
    }
    rowheight = cell.frame.size.height;
    return cell.frame.size.height;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return addFundsListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *cellIdentifier = @"addfundsCell1";
    addfundsCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[addfundsCell1 alloc] initWithStyle:UITableViewCellStyleSubtitle                               reuseIdentifier:cellIdentifier] ;
    }
    cell.selectionStyle= NO;
    
    NSString *cardNo = [[[addFundsListArray objectAtIndex:(indexPath.row)]objectForKey:@"cardNo"] isKindOfClass:[NSNull class]]?@"":[[addFundsListArray objectAtIndex:(indexPath.row)]objectForKey:@"cardNo"];
    
    [cell.cardNoLbl setText:cardNo];
    cell.cardNoLbl.layer.masksToBounds=YES;
    [cell.cardNoLbl setTextAlignment:NSTextAlignmentLeft];
    [ cell.cardNoLbl setTextColor:[UIColor colorWithRed:0.00 green:0.27 blue:0.35 alpha:1.0]];
    // [cell.prflSubnamelbl setFrame:CGRectMake(0,10,100,30)];
    
    NSString *cardtype = [[[addFundsListArray objectAtIndex:(indexPath.row)]objectForKey:@"cardType"] isKindOfClass:[NSNull class]]?@"":[[addFundsListArray objectAtIndex:(indexPath.row)]objectForKey:@"cardType"];
    
    [cell.cardTypeLbl setText:cardtype];
    cell.cardTypeLbl.layer.masksToBounds=YES;
    [cell.cardTypeLbl setTextAlignment:NSTextAlignmentLeft];
    [ cell.cardTypeLbl setTextColor:[UIColor colorWithRed:0.00 green:0.27 blue:0.35 alpha:1.0]];
    // cell.cardNoLbl.textColor = [UIColor blackColor];
    //button.layer.cornerRadius = 0.5 * button.bounds.size.width;
    
    NSString *selected = [[[addFundsListArray objectAtIndex:(indexPath.row)]objectForKey:@"selected"] isKindOfClass:[NSNull class]]?@"NO":[[addFundsListArray objectAtIndex:(indexPath.row)]objectForKey:@"selected"];
    cell.selectBtn.layer.borderWidth=1.0f;
    cell.selectBtn.layer.cornerRadius = cell.selectBtn.frame.size.width * 0.5;
    cell.selectBtn.tag = indexPath.row;
    [cell.selectBtn addTarget:self action:@selector(selectCardBtn:) forControlEvents:UIControlEventAllEvents];
    if ([selected isEqualToString:@"NO"]) {
        [cell.selectBtn setBackgroundColor:[UIColor whiteColor]];
        [cell setBackgroundColor:[UIColor whiteColor]];
        [cell.cardTypeLbl setBackgroundColor:[UIColor whiteColor]];

    }
    else
    {
        [cell.selectBtn setBackgroundColor:[UIColor redColor]];
        [cell setBackgroundColor:[UIColor lightGrayColor]];
        [cell.cardTypeLbl setBackgroundColor:[UIColor lightGrayColor]];
        cell.selectBtn.layer.borderWidth=0.0f;
    }
    //*****************
    NSString *cardImgs = [[[addFundsListArray objectAtIndex:(indexPath.row)]objectForKey:@"photos"] isKindOfClass:[NSNull class]]?@"":[[addFundsListArray objectAtIndex:(indexPath.row)]objectForKey:@"photos"];
    NSLog(@"url===/////%@",cardImgs);
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@",cardImgs]];;
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * response,
                                               NSData * data,
                                               NSError * error) {
                               if (!error){
                                   UIImage  *image = [[UIImage alloc] initWithData:data];
                                   
                                   [cell.cardImg setImage:image];
                                   
                               }
                               else{
                                   
                                   [cell.cardImg setImage:[UIImage imageNamed:@"visa"]];
                               }
                               
                           }];
    
    //***********
    NSString *card_ids = [[[addFundsListArray objectAtIndex:(indexPath.row)]objectForKey:@"Card_Id"] isKindOfClass:[NSNull class]]?@"":[[addFundsListArray objectAtIndex:(indexPath.row)]objectForKey:@"Card_Id"];
    
    //NSLog(@"imageName%d---%@",indexrow+1,imageName2);
    /* if(![cardImg isEqualToString:@""]){
     [cell.cardImg setImage:[UIImage imageNamed:cardImg]];
     }
     else
     {
     [cell.cardImg setImage:[UIImage imageNamed:@"01_logo_screen-1.png"]];
     }*/
    //cell.cardImg.contentMode =  UIViewContentModeScaleAspectFit;
    
    // [cell.contentView.layer setBorderColor:[UIColor grayColor].CGColor];
    //[cell.contentView.layer setBorderWidth:0.3f];
    return cell;
}

-(void)selectCardBtn:(UIButton *)sender
{
    int tag = (int)sender.tag;
    NSLog(@"tag==%d",tag);
    for (int i=0; i<addFundsListArray.count; i++) {
        if(i != tag)
        {
            NSString *cardType =[[addFundsListArray objectAtIndex:i]objectForKey:@"cardType"];
            NSString *photos =[[addFundsListArray objectAtIndex:i]objectForKey:@"photos"];
            NSString *cardNo =[[addFundsListArray objectAtIndex:i]objectForKey:@"cardNo"];
            NSString *selected = @"NO";
            
            NSMutableDictionary *cards = [[NSMutableDictionary alloc]init];
            [cards setObject:cardType forKey:@"cardType"];
            [cards setObject:photos forKey:@"photos"];
            [cards setObject:cardNo forKey:@"cardNo"];
            [cards setObject:selected forKey:@"selected"];
            [addFundsListArray replaceObjectAtIndex:i withObject:cards];
            selectedCard =@"";
        }
        else
        {
            NSString *cardType =[[addFundsListArray objectAtIndex:tag]objectForKey:@"cardType"];
            NSString *photos =[[addFundsListArray objectAtIndex:tag]objectForKey:@"photos"];
            NSString *cardNo =[[addFundsListArray objectAtIndex:tag]objectForKey:@"cardNo"];
            NSString *selected =[[[addFundsListArray objectAtIndex:tag]objectForKey:@"selected"] isEqualToString:@"NO"]?@"YES":@"NO";
            selectedCard =[NSString stringWithFormat:@"%d",i];
            NSMutableDictionary *cards = [[NSMutableDictionary alloc]init];
            [cards setObject:cardType forKey:@"cardType"];
            [cards setObject:photos forKey:@"photos"];
            [cards setObject:cardNo forKey:@"cardNo"];
            [cards setObject:selected forKey:@"selected"];
            [addFundsListArray replaceObjectAtIndex:tag withObject:cards];
        }
    }
    
    
    
    [addFundsView reloadData];
}




- (IBAction)addCard:(UIButton *)sender {
    NSLog(@"addCard");
    addCardVC *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"SBaddCard"];
    // registerVC1 *vc = [storyboard instantiateViewControllerWithIdentifier:@"registation1"];
    [[self navigationController] pushViewController:vc animated:YES];
    
}
-(void)get_cards{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    
    UserSession *getCards = [UserAccessSession getUserSession];
    userId =getCards.reseller_id;
    athenticationKey =getCards.res_user_login_key;
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_GETRESELLERCARD];
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
        NSLog(@"json for all cards-----%@",json);
        
        
        
        status = [NSString stringWithFormat:@"%@",[json objectForKey:@"status"]];
        if([status isEqualToString:@"1"]){
            allCardsArr = [[NSMutableArray alloc]init];
            allCardsArr = [json objectForKey:@"data"] ;
            addFundsListArray = [[NSMutableArray alloc]init];
            for (int j=0; j<[allCardsArr count]; j++){
                cardType=[[[allCardsArr objectAtIndex:j]objectForKey:@"card_type"] isKindOfClass:[NSNull class]]?@"":[[allCardsArr objectAtIndex:j]objectForKey:@"card_type"];
                cardImg=[[[allCardsArr objectAtIndex:j]objectForKey:@"imagename"] isKindOfClass:[NSNull class]]?@"":[[allCardsArr objectAtIndex:j]objectForKey:@"imagename"];
                cardNo=[[[allCardsArr objectAtIndex:j]objectForKey:@"cc_number_last_4"] isKindOfClass:[NSNull class]]?@"":[[allCardsArr objectAtIndex:j]objectForKey:@"cc_number_last_4"];
                cardID=[[[allCardsArr objectAtIndex:j]objectForKey:@"id"] isKindOfClass:[NSNull class]]?@"":[[allCardsArr objectAtIndex:j]objectForKey:@"id"];
                
                
                NSMutableDictionary *card1 = [[NSMutableDictionary alloc]init];
                [card1 setObject:cardType forKey:@"cardType"];
                [card1 setObject:cardImg forKey:@"photos"];
                [card1 setObject:[NSString stringWithFormat:@"XXXX-XXXX-XXXX-%@",cardNo]forKey:@"cardNo"];
                [card1 setObject:cardID forKey:@"Card_Id"];
                [card1 setObject:@"NO" forKey:@"selected"];
                [addFundsListArray addObject:card1];
            }
            
            
            
            [addFundsView setDataSource:self];
            [addFundsView setDelegate:self];
            [addFundsView reloadData];
            CGFloat height = self.addFundsView.rowHeight;
            
            
            if(addFundsListArray.count > 5){
                
                height = 5*rowheight;
            }
            else{
                height = addFundsListArray.count*rowheight;
            }
            
            
            
            
            NSLog(@"add funds height==%f",height);
            self.addFundsView.frame = CGRectMake(self.addFundsView.frame.origin.x, self.addFundsView.frame.origin.y, self.addFundsView.frame.size.width, height);
            self.viewtotalDue.frame = CGRectMake(self.viewtotalDue.frame.origin.x, self.addFundsView.frame.origin.y+self.addFundsView.frame.size.height+2, self.viewtotalDue.frame.size.width, self.viewtotalDue.frame.size.height);
            
            self.progressPaymentBtn.frame = CGRectMake(self.progressPaymentBtn.frame.origin.x, self.viewtotalDue.frame.origin.y+self.viewtotalDue.frame.size.height+2, self.viewtotalDue.frame.size.width, self.progressPaymentBtn.frame.size.height);
            
            NSLog(@"card1==%@",addFundsListArray);
            
            // NSLog(@"card1==%@",cardNo);
            
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
//addfunds Button action
- (IBAction)addFundsBtnAction:(id)sender {
    
    NSString *selectCard;
    NSString *flag=@"";
    for (int i=0; i<addFundsListArray.count; i++) {
        selectCard = [[addFundsListArray objectAtIndex:i]objectForKey:@"selected"];
        if([selectCard isEqualToString:@"YES"]){
            flag=@"yes";
            break;
        }
        
    }
    NSString *stringTest=@"^([+-]?)(?:|0|[1-9]\\d*)?$";
    NSPredicate *numerictest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringTest];
    /* for (int i=0; i<addFundsListArray.count; i++) {
     NSString *select=[[addFundsListArray objectAtIndex:i]objectForKey:@"selected"];
     if
     
     }*/
    //amount
    if([amountFld.text isEqualToString:@""]|| [numerictest evaluateWithObject:amountFld.text] == NO){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Amount should not be blank and must be numaric" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    //else if(addFundsListArray)
    else if([flag isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"please select debit card" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    
    else{
        [self add_funds];
    }
    
    
}

//addfunds
-(void)add_funds
{
    hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text =@"Please Wait";
    
    [self.view addSubview:hud];
    [self.view setUserInteractionEnabled:NO];
    UserSession *getfunds = [UserAccessSession getUserSession];
    userId =getfunds.reseller_id;
    athenticationKey =getfunds.res_user_login_key;
    
    NSDictionary *parameters;
    __block NSDictionary* json;
    parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                  userId,@"user_id",
                  athenticationKey,@"authentication_key",
                  cardID,@"card_id",
                  amountFld.text,@"amount",
                  nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@%@",HOSTNAME,HOST,URL_ADDFUND];
    NSLog(@"URLadd_funds====%@",URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"URLadd_funds==%@",URL);
    NSLog(@"parametersadd_funds==%@",parameters);
    
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oops" message:[json objectForKey:@"msg"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alert show];
            
            
        }
        //NSString* status = [NSString stringWithFormat:@"%@", [json objectForKey:@"status"]];
        
        // NSString *logged_in = [NSString stringWithFormat:@"%@",[json objectForKey:@"data"][@"reseller_logged_in"]];
        // dictArrayGeneric=[json objectForKey:@"result"][@"generic"];
        //NSLog(@"error:%@",error.description);
        
        
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

//for keypad hide/show
- (void)registerForKeyboardNotifications
{
    NSLog(@"registerForKeyboardNotifications");
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
    NSLog(@"keyboardWasShown");
    //NSLog(@"keyboard==%@",aNotification);
    NSDictionary* info = [aNotification userInfo];
    //NSLog(@"text y==%f",activeField.frame.origin.y);
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrollAddFunds.contentInset = contentInsets;
    scrollAddFunds.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [scrollAddFunds setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollAddFunds.contentInset = contentInsets;
    scrollAddFunds.scrollIndicatorInsets = contentInsets;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

//
-(BOOL)textFieldShouldReturn:(UITextField *)textField
//fldCustomerph,fldrechargeAmt,btnSubmit
{
    
    NSLog(@"textFieldShouldReturn");
    if (textField == amountFld)
    {
        [amountFld resignFirstResponder];
        
        //[fldrechargeAmt becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    
    return YES;
}

//addfunds Button action
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
