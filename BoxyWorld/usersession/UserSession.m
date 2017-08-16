//
//  UserSession.m
//  Kavings Two
//
//  Created by Matainja Technologies on 31/08/15.
//  Copyright (c) 2015 Matainja Technologies. All rights reserved.
//

#import "UserSession.h"

@implementation UserSession



@synthesize  reseller_id,reseller_password,reseller_firstname,reseller_lastname,reseller_email,profile_pic,res_user_login_key,reseller_logged_in,user_role,parent_id,pinless_active,imtu_active,sendmoney_active;

@synthesize customer_id,customer_Name,customer_email,customer_phNo,customer_address,customer_zip,customer_state,customer_country,customer_city;

@synthesize sentMoney_CountyID,sentMoney_CountryCode,sentMoney_rech_country_code,sentMoney_countryname,sentMoney_countryprefix,sentMoney_delivery_boxypay,sentMoney_delivery_debit,sentMoney_delivery_bank,sentMoney_currencycode,sentMoney_moneyexpress_country_name;

@synthesize recipent_Name,recipent_phone,recipent_id,recSelectedPhno,recBankId;

@synthesize payment_method,pay_with;
@synthesize expSent_amount_method;
@synthesize expSentMoney,expPayout_id;
@synthesize expSentMoneyBankOrMobile;
@synthesize convert_Amount,exchange_rate,sending_Amount,sendingAmountFee,to_cur;
@synthesize setectedTabHis;

@synthesize name;
@synthesize tempLatitude;
@synthesize tempLongitude;
@synthesize address;
@synthesize currentAddress;
@synthesize locality;
@synthesize previousController;
@synthesize localImageFile;
@synthesize settingsLatitude;
@synthesize settingsLongitude;
@synthesize settingsAddress;
@synthesize  notifyNew_follower;
@synthesize  notifyNew_messege;
@synthesize  notifyNew_offer;
@synthesize  notifyNew_group_deal;

@end
