

#import <UIKit/UIKit.h>

@class KTRawView;
@protocol KTRawViewDelegate <NSObject>

-(void) KTRawView:(KTRawView*)view didPressedAnyButton:(UIButton*)button;

@end

@interface KTRawView : UIView <UITextFieldDelegate> {
    
    __weak id <KTRawViewDelegate> _delegate;
    id _object;
}
@property (nonatomic, retain) id object;
@property (nonatomic, weak) __weak id <KTRawViewDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIButton* buttonCustom;

@property (nonatomic, retain) IBOutlet UITextField* textFieldCustom;

@property (nonatomic, retain) IBOutlet UILabel* labelTitle;
@property (nonatomic, retain) UITextField* activeTextField;
@property (weak, nonatomic) IBOutlet UIImageView *imageSlide;

-(id)initWithNibName:(NSString*)nibNameOrNil;

- (id)initWithFrame:(CGRect)frame nibName:(NSString*)nibNameOrNil;



@end