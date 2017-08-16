//
//  FAQ-catagoryVC.h
//  BoxyWorld
//
//  Created by Matainja Technologies on 10/07/17.
//  Copyright © 2017 Matainja Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAQ_catagoryVC : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *faqCollectionView;

@end
