//
//  AppDelegate.m
//  BoxyWorld
//
//  Created by Matainja Technologies on 10/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import "AppDelegate.h"
#import "homeVC.h"
#import "leftMenuVC.h"
#import "ViewController.h"
#import "rightMenuVCViewController.h"
#import "UserAccessSession.h"
#import "customerListVC.h"
//#import "sentMoneyCustomerDetails.h"
//#import "sendMoneyCustomerList.h"



@interface AppDelegate ()<SWRevealViewControllerDelegate>
@end

@implementation AppDelegate
@synthesize window = _window;
@synthesize viewController = _viewController;
+(AppDelegate *)instance {
    
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //[self setBothMenus];
    
   /* UITabBarController *tabBarController = [[UITabBarController alloc] init];
    UIViewController *testVC = [[sentMoneyCustomerDetails alloc] init];
    UIViewController *otherVC = [[sendMoneyCustomerList alloc] init];
    UIViewController *configVC = [[ConfigViewController alloc] init];
    NSArray *viewControllers = [NSArray arrayWithObjects:testVC,otherVC, nil];
    [testVC release];
    [otherVC release];
    [configVC release];
    */
    [self setStatusBarBackgroundColor:[UIColor colorWithRed:0.07 green:0.20 blue:0.28 alpha:1.0]];
    [self goToLoginPage];
    return YES;
}
-(void)goToLoginPage{
    /*NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    ViewController * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"loginSB"];
    self.window.rootViewController = vc1;
    [self.window makeKeyAndVisible];
   */
    UserSession* user = [UserAccessSession getUserSession];
    NSLog(@"user.reseller_logged_in===%@",user.reseller_logged_in);
    BOOL userLoggedIn = [user.reseller_logged_in boolValue];
    
    if(userLoggedIn){
        NSLog(@"login");
        [self setBothMenus];
        
    }
    else{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    ViewController *targetViewController = (ViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"loginSB"];
        UINavigationController *nav;
        nav = [[UINavigationController alloc]initWithRootViewController:targetViewController];
    }
   
}
-(void)setBothMenus{
    
    UIWindow *window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window = window;
    
    //main_2VC *frontViewController = [[main_2VC alloc]initWithNibName:@"homeVC" bundle:nil];
    homeVC *frontViewController = [[homeVC alloc]initWithNibName:@"homeVC" bundle:nil];
    leftMenuVC *rearViewController = [[leftMenuVC alloc]initWithNibName:@"leftMenuVC" bundle:nil];
    
    
    
    UINavigationController *frontNavigationController = [[UINavigationController alloc]initWithRootViewController:frontViewController];
    UINavigationController *rearNavigationController = [[UINavigationController alloc]initWithRootViewController:rearViewController];
    
    SWRevealViewController *mainRevealController = [[SWRevealViewController alloc]initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
    
    
    //RightViewController *rightViewController = rightViewController = [[RightViewController alloc] init];
    rightMenuVCViewController *rightViewControllers = [[rightMenuVCViewController alloc]initWithNibName:@"rightMenuVCViewController" bundle:nil];
    mainRevealController.rightViewController = rightViewControllers;
    
    //mainRevealController.bounceBackOnOverdraw=NO;
    //mainRevealController.stableDragOnOverdraw=YES;
    
    
    
    mainRevealController.rearViewRevealWidth = [UIScreen mainScreen].bounds.size.width * 0.85;//0.8
    mainRevealController.rightViewRevealWidth = [UIScreen mainScreen].bounds.size.width * 0.85;//0.86
    mainRevealController.delegate = self;
    self.viewController = mainRevealController;
    
    
    [UIView transitionWithView:self.window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{ self.window.rootViewController = self.viewController;
                        [self.window makeKeyAndVisible];}
                    completion:nil];
    
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}


- (NSString*)stringFromFrontViewPosition:(FrontViewPosition)position
{
    NSString *str = nil;
    if ( position == FrontViewPositionLeft ) str = @"FrontViewPositionLeft";
    if ( position == FrontViewPositionRight ) str = @"FrontViewPositionRight";
    if ( position == FrontViewPositionRightMost ) str = @"FrontViewPositionRightMost";
    if ( position == FrontViewPositionRightMostRemoved ) str = @"FrontViewPositionRightMostRemoved";
    return str;
}


- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealController:(SWRevealViewController *)revealController willRevealRearViewController:(UIViewController *)rearViewController
{
    NSLog( @"%@", NSStringFromSelector(_cmd));
}

- (void)revealController:(SWRevealViewController *)revealController didRevealRearViewController:(UIViewController *)rearViewController
{
    NSLog( @"%@", NSStringFromSelector(_cmd));
}

- (void)revealController:(SWRevealViewController *)revealController willHideRearViewController:(UIViewController *)rearViewController
{
    NSLog( @"%@", NSStringFromSelector(_cmd));
}

- (void)revealController:(SWRevealViewController *)revealController didHideRearViewController:(UIViewController *)rearViewController
{
    NSLog( @"%@", NSStringFromSelector(_cmd));
}

- (void)revealController:(SWRevealViewController *)revealController willShowFrontViewController:(UIViewController *)rearViewController
{
    NSLog( @"%@", NSStringFromSelector(_cmd));
}

- (void)revealController:(SWRevealViewController *)revealController didShowFrontViewController:(UIViewController *)rearViewController
{
    NSLog( @"%@", NSStringFromSelector(_cmd));
}

- (void)revealController:(SWRevealViewController *)revealController willHideFrontViewController:(UIViewController *)rearViewController
{
    NSLog( @"%@", NSStringFromSelector(_cmd));
}

- (void)revealController:(SWRevealViewController *)revealController didHideFrontViewController:(UIViewController *)rearViewController

{
    NSLog( @"%@", NSStringFromSelector(_cmd));
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
