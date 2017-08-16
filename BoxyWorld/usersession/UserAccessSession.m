//
//  UserAccessSession.m
//  Kavings Two
//
//  Created by Matainja Technologies on 31/08/15.
//  Copyright (c) 2015 Matainja Technologies. All rights reserved.
//


#import "UserAccessSession.h"


#define RESELLER_ID         @"reseller_id"
#define RESELLER_LOGGEDIN @"reseller_logged_in"
#define RESELLER_USER_LOGINKEY @"res_user_login_key"
#define PASSWORD        @"reseller_password"
#define USER_FNAME       @"reseller_firstname"
#define USER_LNAME       @"reseller_lastname"
#define USER_EMAIL      @"reseller_email"
#define IMAGE_FILE      @"profile_pic"
#define USER_ROLE      @"user_role"
#define PARENT_ID      @"parent_id"
#define PINLESS_ACTIVE      @"pinless_active"
#define IMTU_ACTIVE      @"imtu_active"
#define SEND_MONEY_ACTIVE      @"sendmoney_active"


#define CUSTOMER_ID @"customer_id"
#define CUSTOMER_NAME @"customer_Name"
#define CUSTOMER_EMAIL @"customer_email"
#define CUSTOMER_PHNO @"customer_phNo"
#define CUSTOMER_ADDRESS @"customer_address"
#define CUSTOMER_ZIP @"customer_zip"
#define CUSTOMER_STATE @"customer_state"
#define CUSTOMER_COUNTRY @"customer_country"
#define CUSTOMER_CITY @"customer_city"
//@synthesize sentMoney_CountyID,sentMoney_CountryCode,sentMoney_rech_country_code,sentMoney_countryname,sentMoney_countryprefix,sentMoney_delivery_boxypay,sentMoney_delivery_debit,sentMoney_delivery_bank,sentMoney_currencycode,sentMoney_moneyexpress_country_name;
#define SM_COUNTRYID @"sentMoney_CountyID"
#define SM_COUNTRYCODE @"sentMoney_CountryCode"
#define SM_RECH_COUNTRY_CODE @"sentMoney_rech_country_code"
#define SM_COUNTRYNAME @"sentMoney_countryname"
#define SM_COUNTRYPREFIX @"sentMoney_countryprefix"
#define SM_DELIVERY_BOXYPAY @"sentMoney_delivery_boxypay"
#define SM_DELIVERY_DEBIT @"sentMoney_delivery_debit"
#define SM_DELIVERY_BANK @"sentMoney_delivery_bank"
#define SM_CURRENCYCODE @"sentMoney_currencycode"
#define SM_MONEYEXPRESS_COUNTRY_NAME @"sentMoney_moneyexpress_country_name"
//recipent_Name,recipent_phone;
#define RECIPIENT_NAME @"recipent_Name"
#define RECIPIENT_PHONE @"recipent_phone"
#define RECIPIENT_ID @"recipent_id"
#define RECIPIENT_SELECTEDPHNO @"recSelectedPhno"
#define RECIPIENT_BANKID@"recBankId"

#define PAYMENT_METHOD @"payment_method"
#define PAY_WITH @"pay_with"

#define EXP_SENT_AMOUNT @"expSent_amount_method"
#define EXP_SENT_MONEY_BY @"expSentMoney"
#define EXP_SENT_MONEYBANK_OR_MOBILE @"expSentMoneyBankOrMobile"

#define EXP_CONVERT_AMOUNT @"convert_Amount"
#define EXP_EXCHANGE_RATE @"exchange_rate"
#define EXP_SENDING_AMOUNT @"sending_Amount"
#define EXP_SENDING_AMOUNT_FEE @"sendingAmountFee"
#define EXP_TO_CUR @"to_cur"
#define EXP_PAYOUT @"expPayout_id"
#define HIS_SELECTED @"setectedTabHis"

//@synthesize expSentMoneyBankOrMobile;
//#define SM_MONEYEXPRESS_COUNTRY_NAME @"sentMoney_moneyexpress_country_name"


#define USER_NAME       @"user_name"
#define CURRENT_LAT     @"current_lat"
#define CURRENT_LONGI   @"current_longi"
#define TEMP_CURRENT_LAT     @"temp_current_lat"
#define TEMP_CURRENT_LONGI   @"temp_current_longi"
#define ADDRESS         @"address"
#define CURRENT_ADDRESS @"currentAddress"
#define PREVIOS_CONTROLLER @"previousController"
#define LOCAL_IMAGEFILE @"localImageFile"

#define SETTINGS_LATITUDE @"settingsLatitude"
#define SETTINGS_LONGITUDE @"settingsLongitude"
#define SETTINGS_ADDRESS @"settingsAddress"

#define NOTIFY_NEW_FOLLOWER @"notifyNew_follower"
#define NOTIFY_NEW_MESSAGE @"notifyNew_messege"
#define NOTIFY_NEW_OFFER @"notifyNew_offer"
#define NOTIFY_NEW_GROUP_DEAL @"notifyNew_group_deal"


//#define LOCALITY        @"locality"



@implementation UserAccessSession

+(void)storeUserSession:(UserSession*)session {
    
    [[NSUserDefaults standardUserDefaults]setObject:session.reseller_id forKey:RESELLER_ID];
    [[NSUserDefaults standardUserDefaults]setObject:session.reseller_logged_in forKey:RESELLER_LOGGEDIN];
     [[NSUserDefaults standardUserDefaults]setObject:session.res_user_login_key forKey:RESELLER_USER_LOGINKEY];
    [[NSUserDefaults standardUserDefaults]setObject:session.reseller_firstname forKey:USER_FNAME];
    [[NSUserDefaults standardUserDefaults]setObject:session.reseller_lastname forKey:USER_LNAME];
    [[NSUserDefaults standardUserDefaults]setObject:session.reseller_email forKey:USER_EMAIL];
    [[NSUserDefaults standardUserDefaults]setObject:session.reseller_password forKey:PASSWORD];
    [[NSUserDefaults standardUserDefaults]setObject:session.profile_pic forKey:IMAGE_FILE];
    [[NSUserDefaults standardUserDefaults]setObject:session.user_role forKey:USER_ROLE];
    [[NSUserDefaults standardUserDefaults]setObject:session.parent_id forKey:PARENT_ID];
    [[NSUserDefaults standardUserDefaults]setObject:session.pinless_active forKey:PINLESS_ACTIVE];
    [[NSUserDefaults standardUserDefaults]setObject:session.imtu_active forKey:IMTU_ACTIVE];
    [[NSUserDefaults standardUserDefaults]setObject:session.sendmoney_active forKey:SEND_MONEY_ACTIVE];
    //***********************
    

    
    [[NSUserDefaults standardUserDefaults]setObject:session.customer_id forKey:CUSTOMER_ID];
    [[NSUserDefaults standardUserDefaults]setObject:session.customer_Name forKey:CUSTOMER_NAME];
    [[NSUserDefaults standardUserDefaults]setObject:session.customer_email forKey:CUSTOMER_EMAIL];
    [[NSUserDefaults standardUserDefaults]setObject:session.customer_phNo forKey:CUSTOMER_PHNO];
    [[NSUserDefaults standardUserDefaults]setObject:session.customer_address forKey:CUSTOMER_ADDRESS];
    [[NSUserDefaults standardUserDefaults]setObject:session.customer_zip forKey:CUSTOMER_ZIP];
    [[NSUserDefaults standardUserDefaults]setObject:session.customer_state forKey:CUSTOMER_STATE];
    [[NSUserDefaults standardUserDefaults]setObject:session.customer_country forKey:CUSTOMER_COUNTRY];
    [[NSUserDefaults standardUserDefaults]setObject:session.customer_city forKey:CUSTOMER_CITY];

//@synthesize sentMoney_CountyID,sentMoney_CountryCode,sentMoney_rech_country_code,sentMoney_countryname,sentMoney_countryprefix,sentMoney_delivery_boxypay,sentMoney_delivery_debit,sentMoney_delivery_bank,sentMoney_currencycode,sentMoney_moneyexpress_country_name;
   
    
    [[NSUserDefaults standardUserDefaults]setObject:session.sentMoney_CountyID forKey:SM_COUNTRYID];
    [[NSUserDefaults standardUserDefaults]setObject:session.sentMoney_CountryCode forKey:SM_COUNTRYCODE];
    [[NSUserDefaults standardUserDefaults]setObject:session.sentMoney_rech_country_code forKey:SM_RECH_COUNTRY_CODE];
    [[NSUserDefaults standardUserDefaults]setObject:session.sentMoney_countryname forKey:SM_COUNTRYNAME];
    [[NSUserDefaults standardUserDefaults]setObject:session.sentMoney_countryprefix forKey:SM_COUNTRYPREFIX];
    [[NSUserDefaults standardUserDefaults]setObject:session.sentMoney_delivery_boxypay forKey:SM_DELIVERY_BOXYPAY];
    [[NSUserDefaults standardUserDefaults]setObject:session.sentMoney_delivery_debit forKey:SM_DELIVERY_DEBIT];
    [[NSUserDefaults standardUserDefaults]setObject:session.sentMoney_delivery_bank forKey:SM_DELIVERY_BANK];
    [[NSUserDefaults standardUserDefaults]setObject:session.sentMoney_currencycode forKey:SM_CURRENCYCODE];
    [[NSUserDefaults standardUserDefaults]setObject:session.sentMoney_moneyexpress_country_name forKey:SM_MONEYEXPRESS_COUNTRY_NAME];
    
    //***********************
    //recipent_Name,recipent_phone;
    [[NSUserDefaults standardUserDefaults]setObject:session.recipent_Name forKey:RECIPIENT_NAME];
    [[NSUserDefaults standardUserDefaults]setObject:session.recipent_phone forKey:RECIPIENT_PHONE];
     [[NSUserDefaults standardUserDefaults]setObject:session.recipent_id forKey:RECIPIENT_ID];
    [[NSUserDefaults standardUserDefaults]setObject:session.recSelectedPhno forKey:RECIPIENT_SELECTEDPHNO];
    [[NSUserDefaults standardUserDefaults]setObject:session.recBankId forKey:RECIPIENT_BANKID];
    
   
     [[NSUserDefaults standardUserDefaults]setObject:session.payment_method forKey:PAYMENT_METHOD];
    [[NSUserDefaults standardUserDefaults]setObject:session.pay_with forKey:PAY_WITH];
    
    [[NSUserDefaults standardUserDefaults]setObject:session.expSent_amount_method forKey:EXP_SENT_AMOUNT];
    [[NSUserDefaults standardUserDefaults]setObject:session.expSentMoney forKey:EXP_SENT_MONEY_BY];
    [[NSUserDefaults standardUserDefaults]setObject:session.expSentMoneyBankOrMobile forKey:EXP_SENT_MONEYBANK_OR_MOBILE];
    
     [[NSUserDefaults standardUserDefaults]setObject:session.convert_Amount forKey:EXP_CONVERT_AMOUNT];
    [[NSUserDefaults standardUserDefaults]setObject:session.exchange_rate forKey:EXP_EXCHANGE_RATE];
    [[NSUserDefaults standardUserDefaults]setObject:session.sending_Amount forKey:EXP_SENDING_AMOUNT];
     [[NSUserDefaults standardUserDefaults]setObject:session.sendingAmountFee forKey:EXP_SENDING_AMOUNT_FEE];
     [[NSUserDefaults standardUserDefaults]setObject:session.to_cur forKey:EXP_TO_CUR];
     [[NSUserDefaults standardUserDefaults]setObject:session.expPayout_id forKey:EXP_PAYOUT];
    
     [[NSUserDefaults standardUserDefaults]setObject:session.setectedTabHis forKey:HIS_SELECTED];

    //************************
    [[NSUserDefaults standardUserDefaults]setObject:session.address forKey:ADDRESS];
     [[NSUserDefaults standardUserDefaults]setObject:session.currentAddress forKey:CURRENT_ADDRESS];
    [[NSUserDefaults standardUserDefaults]setObject:session.tempLatitude forKey:TEMP_CURRENT_LAT];
    [[NSUserDefaults standardUserDefaults]setObject:session.tempLongitude forKey:TEMP_CURRENT_LONGI];
    [[NSUserDefaults standardUserDefaults]setObject:session.previousController forKey:PREVIOS_CONTROLLER];
    [[NSUserDefaults standardUserDefaults]setObject:session.localImageFile forKey:LOCAL_IMAGEFILE];
    [[NSUserDefaults standardUserDefaults]setObject:session.latitude forKey:CURRENT_LAT];
    [[NSUserDefaults standardUserDefaults]setObject:session.longitude forKey:CURRENT_LONGI];
    [[NSUserDefaults standardUserDefaults]setObject:session.settingsLatitude forKey:SETTINGS_LATITUDE];
    [[NSUserDefaults standardUserDefaults]setObject:session.settingsLongitude forKey:SETTINGS_LONGITUDE];
    [[NSUserDefaults standardUserDefaults]setObject:session.settingsAddress forKey:SETTINGS_ADDRESS];
    
    [[NSUserDefaults standardUserDefaults]setObject:session.notifyNew_follower forKey:NOTIFY_NEW_FOLLOWER];
    [[NSUserDefaults standardUserDefaults]setObject:session.notifyNew_messege forKey:NOTIFY_NEW_MESSAGE];
    [[NSUserDefaults standardUserDefaults]setObject:session.notifyNew_offer forKey:NOTIFY_NEW_OFFER];
    [[NSUserDefaults standardUserDefaults]setObject:session.notifyNew_group_deal forKey:NOTIFY_NEW_GROUP_DEAL];
    //[[NSUserDefaults standardUserDefaults]setObject:session.locality forKey:LOCALITY];
    
}

+(UserSession*)getUserSession {
    if([[NSUserDefaults standardUserDefaults]objectForKey:RESELLER_ID] == nil)
        return nil;
    
    UserSession* userSession = [UserSession new];
    
    userSession.reseller_id = [[NSUserDefaults standardUserDefaults]objectForKey:RESELLER_ID];
    userSession.reseller_logged_in = [[NSUserDefaults standardUserDefaults]objectForKey:RESELLER_LOGGEDIN];
    userSession.res_user_login_key = [[NSUserDefaults standardUserDefaults]objectForKey:RESELLER_USER_LOGINKEY];
    userSession.reseller_id = [[NSUserDefaults standardUserDefaults]objectForKey:RESELLER_ID];
    userSession.profile_pic = [[NSUserDefaults standardUserDefaults]objectForKey:IMAGE_FILE];
    userSession.parent_id = [[NSUserDefaults standardUserDefaults]objectForKey:PARENT_ID];
    userSession.pinless_active = [[NSUserDefaults standardUserDefaults]objectForKey:PINLESS_ACTIVE];
    userSession.imtu_active = [[NSUserDefaults standardUserDefaults]objectForKey:IMTU_ACTIVE];
    userSession.sendmoney_active = [[NSUserDefaults standardUserDefaults]objectForKey:SEND_MONEY_ACTIVE];
    userSession.reseller_firstname = [[NSUserDefaults standardUserDefaults]objectForKey:USER_FNAME];
    userSession.reseller_lastname = [[NSUserDefaults standardUserDefaults]objectForKey:USER_LNAME];
    userSession.reseller_email = [[NSUserDefaults standardUserDefaults]objectForKey:USER_EMAIL];
    userSession.reseller_password = [[NSUserDefaults standardUserDefaults]objectForKey:PASSWORD];
    //**********************


    
    userSession.customer_id = [[NSUserDefaults standardUserDefaults]objectForKey:CUSTOMER_ID];
    userSession.customer_Name = [[NSUserDefaults standardUserDefaults]objectForKey:CUSTOMER_NAME];
    userSession.customer_email = [[NSUserDefaults standardUserDefaults]objectForKey:CUSTOMER_EMAIL];
    userSession.customer_phNo = [[NSUserDefaults standardUserDefaults]objectForKey:CUSTOMER_PHNO];
    userSession.customer_address = [[NSUserDefaults standardUserDefaults]objectForKey:CUSTOMER_ADDRESS];
    userSession.customer_zip = [[NSUserDefaults standardUserDefaults]objectForKey:CUSTOMER_ZIP];
    userSession.customer_state = [[NSUserDefaults standardUserDefaults]objectForKey:CUSTOMER_STATE];
    userSession.customer_country = [[NSUserDefaults standardUserDefaults]objectForKey:CUSTOMER_COUNTRY];
    userSession.customer_city = [[NSUserDefaults standardUserDefaults]objectForKey:CUSTOMER_CITY];

    
    
    //@synthesize sentMoney_CountyID,sentMoney_CountryCode,sentMoney_rech_country_code,sentMoney_countryname,sentMoney_countryprefix,sentMoney_delivery_boxypay,sentMoney_delivery_debit,sentMoney_delivery_bank,sentMoney_currencycode,sentMoney_moneyexpress_country_name;
  
    
    userSession.sentMoney_CountyID = [[NSUserDefaults standardUserDefaults]objectForKey:SM_COUNTRYID];
    userSession.sentMoney_CountryCode = [[NSUserDefaults standardUserDefaults]objectForKey:SM_COUNTRYCODE];
    userSession.sentMoney_rech_country_code = [[NSUserDefaults standardUserDefaults]objectForKey:SM_RECH_COUNTRY_CODE];
    userSession.sentMoney_countryname = [[NSUserDefaults standardUserDefaults]objectForKey:SM_COUNTRYNAME];
    userSession.sentMoney_countryprefix = [[NSUserDefaults standardUserDefaults]objectForKey:SM_COUNTRYPREFIX];
    userSession.sentMoney_delivery_boxypay = [[NSUserDefaults standardUserDefaults]objectForKey:SM_DELIVERY_BOXYPAY];
    userSession.sentMoney_delivery_debit = [[NSUserDefaults standardUserDefaults]objectForKey:SM_DELIVERY_DEBIT];
    userSession.sentMoney_delivery_bank = [[NSUserDefaults standardUserDefaults]objectForKey:SM_DELIVERY_BANK];
    userSession.sentMoney_currencycode = [[NSUserDefaults standardUserDefaults]objectForKey:SM_CURRENCYCODE];
    userSession.sentMoney_moneyexpress_country_name = [[NSUserDefaults standardUserDefaults]objectForKey:SM_MONEYEXPRESS_COUNTRY_NAME];

    
    //************************
    userSession.recipent_Name = [[NSUserDefaults standardUserDefaults]objectForKey:RECIPIENT_NAME];
    userSession.recipent_phone = [[NSUserDefaults standardUserDefaults]objectForKey:RECIPIENT_PHONE];
    userSession.recipent_id = [[NSUserDefaults standardUserDefaults]objectForKey:RECIPIENT_ID];
    userSession.recSelectedPhno = [[NSUserDefaults standardUserDefaults]objectForKey:RECIPIENT_SELECTEDPHNO];
     userSession.recBankId = [[NSUserDefaults standardUserDefaults]objectForKey:RECIPIENT_BANKID];
    
   
     userSession.payment_method = [[NSUserDefaults standardUserDefaults]objectForKey:PAYMENT_METHOD];
     userSession.pay_with = [[NSUserDefaults standardUserDefaults]objectForKey:PAY_WITH];
   
     userSession.expSent_amount_method = [[NSUserDefaults standardUserDefaults]objectForKey:EXP_SENT_AMOUNT];
     userSession.expSentMoney = [[NSUserDefaults standardUserDefaults]objectForKey:EXP_SENT_MONEY_BY];
     userSession.expSentMoneyBankOrMobile = [[NSUserDefaults standardUserDefaults]objectForKey:EXP_SENT_MONEYBANK_OR_MOBILE];
     userSession.expPayout_id = [[NSUserDefaults standardUserDefaults]objectForKey:EXP_PAYOUT];
    
    
    userSession.convert_Amount = [[NSUserDefaults standardUserDefaults]objectForKey:EXP_CONVERT_AMOUNT];
    userSession.exchange_rate = [[NSUserDefaults standardUserDefaults]objectForKey:EXP_EXCHANGE_RATE];
     userSession.sending_Amount = [[NSUserDefaults standardUserDefaults]objectForKey:EXP_SENDING_AMOUNT];
    userSession.sendingAmountFee = [[NSUserDefaults standardUserDefaults]objectForKey:EXP_SENDING_AMOUNT_FEE];
     userSession.to_cur = [[NSUserDefaults standardUserDefaults]objectForKey:EXP_TO_CUR];
    
    userSession.setectedTabHis = [[NSUserDefaults standardUserDefaults]objectForKey:HIS_SELECTED];
    




    //************************
    userSession.name = [[NSUserDefaults standardUserDefaults]objectForKey:USER_NAME];
    userSession.latitude = [[NSUserDefaults standardUserDefaults]objectForKey:CURRENT_LAT];
    userSession.longitude = [[NSUserDefaults standardUserDefaults]objectForKey:CURRENT_LONGI];
    userSession.tempLatitude = [[NSUserDefaults standardUserDefaults]objectForKey:TEMP_CURRENT_LAT];
    userSession.tempLongitude = [[NSUserDefaults standardUserDefaults]objectForKey:TEMP_CURRENT_LONGI];
    //userSession.imageFile  = [[NSUserDefaults standardUserDefaults]objectForKey:IAMGE_FILE];
    userSession.address  = [[NSUserDefaults standardUserDefaults]objectForKey:ADDRESS];
    userSession.currentAddress  = [[NSUserDefaults standardUserDefaults]objectForKey:CURRENT_ADDRESS];
     userSession.previousController  = [[NSUserDefaults standardUserDefaults]objectForKey:PREVIOS_CONTROLLER];
    userSession.localImageFile  = [[NSUserDefaults standardUserDefaults]objectForKey:LOCAL_IMAGEFILE];
    
    userSession.settingsLatitude  = [[NSUserDefaults standardUserDefaults]objectForKey:SETTINGS_LATITUDE];
    userSession.settingsLongitude  = [[NSUserDefaults standardUserDefaults]objectForKey:SETTINGS_LONGITUDE];
    userSession.settingsAddress  = [[NSUserDefaults standardUserDefaults]objectForKey:SETTINGS_ADDRESS];
    
    userSession.notifyNew_follower  = [[NSUserDefaults standardUserDefaults]objectForKey:NOTIFY_NEW_FOLLOWER];
    userSession.notifyNew_messege  = [[NSUserDefaults standardUserDefaults]objectForKey:NOTIFY_NEW_MESSAGE];
    userSession.notifyNew_offer  = [[NSUserDefaults standardUserDefaults]objectForKey:NOTIFY_NEW_OFFER];
    userSession.notifyNew_group_deal  = [[NSUserDefaults standardUserDefaults]objectForKey:NOTIFY_NEW_GROUP_DEAL];
    //userSession.locality  = [[NSUserDefaults standardUserDefaults]objectForKey:LOCALITY];
    
    return userSession;
}

+(void)clearAllSession{
    
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:RESELLER_ID];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:RESELLER_LOGGEDIN];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:RESELLER_USER_LOGINKEY];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:USER_FNAME];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:USER_LNAME];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:USER_EMAIL];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:PASSWORD];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:IMAGE_FILE];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:USER_ROLE];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:PARENT_ID];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:PINLESS_ACTIVE];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:IMTU_ACTIVE];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:SEND_MONEY_ACTIVE];
    
    //*****************
    
    
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:CUSTOMER_ID];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:CUSTOMER_NAME];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:CUSTOMER_EMAIL];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:CUSTOMER_PHNO];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:CUSTOMER_ADDRESS];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:CUSTOMER_ZIP];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:CUSTOMER_STATE];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:CUSTOMER_COUNTRY];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:CUSTOMER_CITY];

    
    

    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:SM_COUNTRYID];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:SM_COUNTRYCODE];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:SM_RECH_COUNTRY_CODE];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:SM_COUNTRYNAME];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:SM_COUNTRYPREFIX];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:SM_DELIVERY_BOXYPAY];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:SM_DELIVERY_DEBIT];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:SM_DELIVERY_BANK];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:SM_CURRENCYCODE];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:SM_MONEYEXPRESS_COUNTRY_NAME];
    
    //*************************
   
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:RECIPIENT_NAME];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:RECIPIENT_PHONE];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:RECIPIENT_ID];
     [[NSUserDefaults standardUserDefaults]setObject:nil forKey:RECIPIENT_SELECTEDPHNO];
     [[NSUserDefaults standardUserDefaults]setObject:nil forKey:RECIPIENT_BANKID];
    
   
     [[NSUserDefaults standardUserDefaults]setObject:nil forKey:PAYMENT_METHOD];
     [[NSUserDefaults standardUserDefaults]setObject:nil forKey:PAY_WITH];
    
     [[NSUserDefaults standardUserDefaults]setObject:nil forKey:EXP_SENT_AMOUNT];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:EXP_SENT_MONEY_BY];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:EXP_SENT_MONEYBANK_OR_MOBILE];
    
     [[NSUserDefaults standardUserDefaults]setObject:nil forKey:EXP_CONVERT_AMOUNT];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:EXP_EXCHANGE_RATE];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:EXP_SENDING_AMOUNT];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:EXP_SENDING_AMOUNT_FEE];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:EXP_TO_CUR];
     [[NSUserDefaults standardUserDefaults]setObject:nil forKey:EXP_PAYOUT];
    
     [[NSUserDefaults standardUserDefaults]setObject:nil forKey:HIS_SELECTED];
    
   
    //***********************
    //[[NSUserDefaults standardUserDefaults]setObject:nil forKey:USER_ID];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:USER_NAME];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:USER_FNAME];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:USER_LNAME];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:USER_EMAIL];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:PASSWORD];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:CURRENT_LAT];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:CURRENT_LONGI];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:TEMP_CURRENT_LAT];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:TEMP_CURRENT_LONGI];
   // [[NSUserDefaults standardUserDefaults]setObject:nil forKey:IAMGE_FILE];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:ADDRESS];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:CURRENT_ADDRESS];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:PREVIOS_CONTROLLER];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:LOCAL_IMAGEFILE];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:SETTINGS_LATITUDE];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:SETTINGS_LONGITUDE];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:SETTINGS_ADDRESS];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:NOTIFY_NEW_FOLLOWER];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:NOTIFY_NEW_MESSAGE];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:NOTIFY_NEW_OFFER];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:NOTIFY_NEW_GROUP_DEAL];
    //[[NSUserDefaults standardUserDefaults]setObject:nil forKey:LOCALITY];
    
    
}
@end
