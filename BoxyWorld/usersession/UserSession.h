//
//  UserSession.h
//  Kavings Two
//
//  Created by Matainja Technologies on 31/08/15.
//  Copyright (c) 2015 Matainja Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSession : NSObject

@property (nonatomic, retain) NSString* reseller_id;
@property (nonatomic, retain) NSString* reseller_password;
@property (nonatomic, retain) NSString* reseller_firstname;
@property (nonatomic, retain) NSString* reseller_lastname;
@property (nonatomic, retain) NSString* reseller_email;
@property (nonatomic, retain) NSString* profile_pic;
@property (nonatomic, retain) NSString* res_user_login_key;
@property (nonatomic, retain) NSString* reseller_logged_in;
@property (nonatomic, retain) NSString* user_role;
@property (nonatomic, retain) NSString* parent_id;
@property (nonatomic, retain) NSString* pinless_active;
@property (nonatomic, retain) NSString* imtu_active;
@property (nonatomic, retain) NSString* sendmoney_active;

@property (nonatomic, retain) NSString* customer_id;
@property (nonatomic, retain) NSString* customer_Name;
@property (nonatomic, retain) NSString* customer_email;
@property (nonatomic, retain) NSString* customer_phNo;
@property (nonatomic, retain) NSString* customer_address;
@property (nonatomic, retain) NSString* customer_zip;
@property (nonatomic, retain) NSString* customer_state;
@property (nonatomic, retain) NSString* customer_country;
@property (nonatomic, retain) NSString* customer_city;

//(id, countrycode, rech_country_code, countryname, countryprefix, delivery_boxypay, delivery_debit, delivery_bank, currencycode, moneyexpress_country_name)

@property (nonatomic, retain) NSString* sentMoney_CountyID;
@property (nonatomic, retain) NSString* sentMoney_CountryCode;
@property (nonatomic, retain) NSString* sentMoney_rech_country_code;
@property (nonatomic, retain) NSString* sentMoney_countryname;
@property (nonatomic, retain) NSString* sentMoney_countryprefix;
@property (nonatomic, retain) NSString* sentMoney_delivery_boxypay;
@property (nonatomic, retain) NSString* sentMoney_delivery_debit;
@property (nonatomic, retain) NSString* sentMoney_delivery_bank;
@property (nonatomic, retain) NSString* sentMoney_currencycode;
@property (nonatomic, retain) NSString* sentMoney_moneyexpress_country_name;


@property (nonatomic, retain) NSString* recipent_Name;
@property (nonatomic, retain) NSString* recipent_phone;
@property (nonatomic, retain) NSString* recipent_id;
@property (nonatomic, retain) NSString* recSelectedPhno;
@property (nonatomic, retain) NSString* recBankId;

@property (nonatomic, retain) NSString* payment_method;
@property (nonatomic, retain) NSString* pay_with;

@property (nonatomic, retain) NSString* expSent_amount_method;
@property (nonatomic, retain) NSString* expSentMoney;
@property (nonatomic, retain) NSString* expSentMoneyBankOrMobile;
@property (nonatomic, retain) NSString* expPayout_id;

@property (nonatomic, retain) NSString* convert_Amount;
@property (nonatomic, retain) NSString* exchange_rate;
@property (nonatomic, retain) NSString* sending_Amount;
@property (nonatomic, retain) NSString* sendingAmountFee;
@property (nonatomic, retain) NSString* to_cur;
@property (nonatomic, retain) NSString* setectedTabHis;


@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* latitude;
@property (nonatomic, retain) NSString* longitude;
@property (nonatomic, retain) NSString* tempLatitude;
@property (nonatomic, retain) NSString* tempLongitude;

@property (nonatomic, retain) NSString* address;
@property (nonatomic, retain) NSString* currentAddress;
@property (nonatomic, retain) NSString* locality;
@property (nonatomic, retain) NSString* previousController;
@property (nonatomic, retain) NSString* localImageFile;
@property (nonatomic, retain) NSString* settingsLatitude;
@property (nonatomic, retain) NSString* settingsLongitude;
@property (nonatomic, retain) NSString* settingsAddress;
@property (nonatomic, retain) NSString* notifyNew_follower;
@property (nonatomic, retain) NSString* notifyNew_messege;
@property (nonatomic, retain) NSString* notifyNew_offer;
@property (nonatomic, retain) NSString* notifyNew_group_deal;
//@property (nonatomic, retain) NSString* notifyRequest_join_tribe;

@end
