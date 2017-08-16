//
//  config.h
//  BoxyWorld
//
//  Created by Sambaran DAS on 15/06/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//


#define isAboveiOSVersion7 ([[[UIDevice currentDevice] systemVersion] floatValue] > 6.9)
#define navigationBarColor [UIColor colorWithRed:0.03 green:0.13 blue:0.20 alpha:1.0]
#define textFieldBorderColor [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0]
#define WindowWidth [[UIScreen mainScreen] bounds].size.width
#define WindowHeight [[UIScreen mainScreen] bounds].size.height
//#define BASE_URL [NSString stringWithFormat:@"%@%@", SITE_URL, @"coupon/webservice/"]
#define HOSTNAME  @"https://www.boxyworld.com"
#define HOST @"/api/v1/reseller/account/"
#define URL_LOGIN  @"login"
#define URL_REGISTER  @"register"
#define URL_FORGOTPASSWORD  @"forgot-password"
#define URL_GETCOUNTRY  @"get-countries"
#define URL_GETSTATES  @"get-states"
#define URL_CHANGEPASSWORD  @"change-password"
#define URL_GETCUSTOMER  @"get-customers"
#define URL_ADDCUSTOMER  @"add-customer"
#define URL_UPDATECUSTOMER  @"update-customer"//HOST + "update-customer"
#define URL_GETEMPLOYEE   @"get-employees"//HOST + "get-employees"
#define URL_ADDEMPLOYEE  @"register"//HOST + "register"
#define URL_UPDATEEMPLOYEE  @"update-employee"//HOST + "update-employee"
#define URL_GETSubAgent  @"get-sub-agents"//HOST + "get-sub-agents"
#define URL_ADDSubAgent  @"add-sub-agent"//HOST + "add-sub-agent"
#define URL_UPDATESubAgent  @"update-sub-agent"//HOST + "update-sub-agent"
#define URL_ADDDEBITCARD   @"add-card"//HOST + "add-card"
#define URL_GETRESELLERCARD  @"get-cards"//HOST + "get-cards"
#define URL_BILLINGSTATE  @"get-states?country_id=225"//HOST + "get-states?country_id=225"
#define URL_ADDFUND  @"add-fund"//HOST + "add-fund"
#define URL_UPDATEDEBITCARD @"update-card"//HOST + "update-card"
#define URL_REMOVEDEBITCARD  @"remove-card"//HOST + "remove-card"

#define URL_HELP  @"get-help"//HOST + "get-help"
#define URL_DASHBOARDDATA  @"get-dashboard-data"//HOST + "get-dashboard-data"
#define URL_ALLTRANSACTIONHISTORY  @"get-transactions"//HOST + "get-transactions"
#define URL_IMTURECHARGEHISTORY  @"get-imtu-history"//HOST + "get-imtu-history"
#define URL_PINLESSRECHARGEHISTORY  @"get-pinless-recharge-history"//HOST + "get-pinless-recharge-history"
#define URL_FUNDRECHARGEHISTORY  @"get-help"//HOST+"get-help"
#define URL_UPDATEPROFILE @"update-profile"//HOST + "update-profile"
#define URL_GETTRANSACTIONCSV  @"get-transactions-csv"//HOST + "get-transactions-csv"
#define URL_ACCESSNUMBERS  @"get-access-numbers"//HOST +"get-access-numbers"
#define URL_CALLINGRATES  @"https://www.unleashmobile.com/boxypay/boxytel_script/ajax.php?loadRates=1&no_prefix=1&_=1449624671852&sEcho=32&iColumns=4&sColumns=&iDisplayStart=0&iDisplayLength=999999&sSearch="
#define URL_GETRECHARGEDTLS @"https://www.boxytel.com/nairatopup/recharge_api/index.php"
#define URL_GETPROFILE  @"get-profile"//HOST +"get-profile"
#define URL_CHECKCUSTOMERINPINLESS  @"check-customer"//HOST +"check-customer"
#define URL_SUBMITPINLESS  @"submit-pinless"//HOST +"submit-pinless"
#define URL_GETIMTUCOUNTRY  @"get-imtu-countries"//HOST +"get-imtu-countries"
#define URL_GETIMTUNETWORKS  @"get-imtu-networks"//HOST +"get-imtu-networks"
#define URL_GETIMTUDISCOUNTS  @"get-imtu-discount"//HOST +"get-imtu-discount"
#define URL_GETIMTUAMOUNTS  @"get-imtu-amounts"//HOST +"get-imtu-amounts"
#define URL_GETFAQ @"https://www.boxypay.com/api/v1/faq"
#define URL_GETKYCINFO = [NSString stringWithFormat:@"%@%@", HOSTNAME, @"/api/v1/reseller/synapse/settings_dob_ssn"]//HOSTNAME +"/api/v1/reseller/synapse/settings_dob_ssn"
#define URL_GETUPLOADPROFILE = [NSString stringWithFormat:@"%@%@", HOSTNAME, @"/api/v1/reseller/synapse/upload_picture"]//HOSTNAME +"/api/v1/reseller/synapse/upload_picture"
#define URL_VERIFYKYCWITHQUSANS = [NSString stringWithFormat:@"%@%@", HOSTNAME, @"/api/v1/reseller/synapse/question_answers"]//HOSTNAME +"/api/v1/reseller/synapse/question_answers"

#define URL_DOTOPUP @"do-topup"//HOSTNAME +"/api/v1/reseller/account/do-topup"
#define URL_GETSENDMONEYCOUNTRY  @"/api/v1/reseller/sendMoney/get_country_list"//HOSTNAME +"/api/v1/reseller/sendMoney/get_country_list"
#define URL_GETFAQQUESTIONS @"/api/v1/reseller/account/faq-category"//HOSTNAME +"/api/v1/reseller/account/faq-category"

#define URL_GETFAQCATEGORYQUESTION @"/api/v1/reseller/account/faq-category-question"//HOSTNAME +"/api/v1/reseller/account/faq-category-question"
#define URL_GETFAQANSWER  @"/api/v1/reseller/account/faq-question-answer"//HOSTNAME +"/api/v1/reseller/account/faq-question-answer"
#define URL_GETSENDMONEYREQUEST @"/api/v1/reseller/sendMoney/get_send_params"//HOSTNAME +"/api/v1/reseller/sendMoney/get_send_params"
#define URL_GETPAYOUTNOTES  @"/api/v1/reseller/sendMoney/get_payout_notes"//HOSTNAME +"/api/v1/reseller/sendMoney/get_payout_notes"

#define URL_GETSUBMITSENDMONEY  @"/api/v1/reseller/sendMoney/submit_send_money"//HOSTNAME +"/api/v1/reseller/sendMoney/submit_send_money"
#define URL_GETADDNEWCONTACT  @"/api/v1/reseller/sendMoney/add_new_contact"//HOSTNAME +"/api/v1/reseller/sendMoney/add_new_contact"
#define URL_GETUPDATECONTACTBANK @"/api/v1/reseller/sendMoney/update_contact_add_bank"//HOSTNAME +"/api/v1/reseller/sendMoney/update_contact_add_bank"
#define URL_GETPROFILEPIC = [NSString stringWithFormat:@"%@%@", HOST, @"change-profile-picture"]//HOST +"change-profile-picture"

#define URL_GETACTIVEDEACTIVEEMPLOYEE = [NSString stringWithFormat:@"%@%@", HOST, @"active-deactive-employee"]//HOST +"active-deactive-employee"
#define URL_GETSENDMONEYHISTORY  @"get-send-money-history"//HOST +"get-send-money-history"
#define URL_GETSENDMONEYHISTORYCSV = [NSString stringWithFormat:@"%@%@", HOST, @"get-send-money-csv"]//HOST +"get-send-money-csv"
#define URL_GETSUBAGENTHISTORY =[NSString stringWithFormat:@"%@%@", HOST, @"sub-get-transfer-history"]//HOST +"sub-get-transfer-history"
#define URL_GETSUBAGENTCOMMISIONDATA = [NSString stringWithFormat:@"%@%@", HOST, @"sub-get-commission-data"]//HOST +"sub-get-commission-data"
#define URL_GETTRANSFERMONEYTOSUBAGENT = [NSString stringWithFormat:@"%@%@", HOST, @"submit-sub-agent-transfer"]//HOST +"submit-sub-agent-transfer"
#define URL_GETADDMOBILENUMBER  @"/api/v1/reseller/sendMoney/add_contact_phone_number"//HOSTNAME +"/api/v1/reseller/sendMoney/add_contact_phone_number"
#define URL_GETNOTIFICATIONDATA = [NSString stringWithFormat:@"%@%@", HOSTNAME, @"/api/v1/reseller/tempSendMoney/get_data"]//HOSTNAME +"/api/v1/reseller/tempSendMoney/get_data"

#define URL_UPDATEREGISTERID = [NSString stringWithFormat:@"%@%@", HOSTNAME, @"/api/v1/reseller/account/update-registration-id"]//HOSTNAME +"/api/v1/reseller/account/update-registration-id"
#define URL_DELETETEMPNOTIFICATIONDATA = [NSString stringWithFormat:@"%@%@", HOSTNAME, @"/api/v1/reseller/sendMoney/submit_delete_temp_send_money"]//HOSTNAME +"/api/v1/reseller/sendMoney/submit_delete_temp_send_money"
#define URL_REFUNDAMOUNT = [NSString stringWithFormat:@"%@%@", HOSTNAME, @"/api/v1/reseller/account/refund-amount"]//HOSTNAME +"/api/v1/reseller/account/refund-amount"
#define URL_DELEETNOTIFICATIONDATA = [NSString stringWithFormat:@"%@%@", HOSTNAME, @"/api/v1/reseller/sendMoney/submit_delete_temp_send_money"]//HOSTNAME +"/api/v1/reseller/sendMoney/submit_delete_temp_send_money"


#define TimeStamp [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000]
