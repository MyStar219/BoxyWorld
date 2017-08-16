//
//  webViewVC.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 26/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "webViewVC.h"
#import "MBProgressHUD.h"
#import "config.h"
@interface webViewVC ()<UIWebViewDelegate>
{
    NSURL *url;
    MBProgressHUD *tribeWebLoad;
}
@end

@implementation webViewVC
@synthesize webView,fromPage;
- (void)viewDidLoad {
    [super viewDidLoad];
    if(fromPage != nil && [fromPage isEqualToString:@"sendMoney"])
    {
        self.title = @"Report";
    }
    else{
    self.title = @"TERMS AND CONDITIONS";
    }
    [self barButtonFunction];
    // Do any additional setup after loading the view.
    
    
    tribeWebLoad = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    tribeWebLoad.mode = MBProgressHUDModeIndeterminate;
    tribeWebLoad.label.text =@"Loading";
    tribeWebLoad.userInteractionEnabled = NO;
    [tribeWebLoad hideAnimated:YES afterDelay:10.f];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    if(fromPage != nil && [fromPage isEqualToString:@"sendMoney"])
    {
        url = [NSURL URLWithString:@"https://www.boxyworld.com/res-send-money.html"];
    }
    else{
    url = [NSURL URLWithString:@"https://www.boxypay.com/terms-and-conditions.html"];
    }
    NSURLRequest* request1 = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:80.0];
    [webView loadRequest:request1];
    webView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)Webview{
    //SHOW HUD
    
    //[self.view addSubview:tribeWebLoad];
   // [self.view setUserInteractionEnabled:YES];
}

-(void)Webview:(UIWebView *)Webview didFailLoadWithError:(NSError *)error{
    //KILL HUD
    
    [tribeWebLoad removeFromSuperview];
    [self.view setUserInteractionEnabled:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webview
{
    if (webview.isLoading)
        return;
    else
    {
        //KILL HUD
        
        
        
        [tribeWebLoad removeFromSuperview];
       [self.view setUserInteractionEnabled:YES];
    }
}
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
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

@end
