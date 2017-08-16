

#import "KTRawView.h"

@implementation KTRawView

@synthesize labelTitle;
@synthesize buttonCustom;
@synthesize textFieldCustom;

@synthesize activeTextField;

-(id)initWithNibName:(NSString*)nibNameOrNil {
    self = [super init];
    
    if (self) {
        // Initialization code
        NSArray* _nibContents = [[NSBundle mainBundle] loadNibNamed:nibNameOrNil
                                                              owner:self
                                                            options:nil];
        self = [_nibContents objectAtIndex:0];
        [self baseInit];
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame nibName:(NSString*)nibNameOrNil {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray* _nibContents = [[NSBundle mainBundle] loadNibNamed:nibNameOrNil
                                                              owner:self
                                                            options:nil];
        self = [_nibContents objectAtIndex:0];
        //        self.frame = frame;
        
        [self baseInit];
    }
    
    return self;
}


-(void)baseInit {
    [buttonCustom addTarget:self action:@selector(didClickButtons:) forControlEvents:UIControlEventTouchUpInside];
    textFieldCustom.delegate = self;
}


-(void)didClickButtons:(id)sender {

    [self.delegate KTRawView:self didPressedAnyButton:sender];
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
    }
    return self;
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView * view in [self subviews]) {
        if (view.userInteractionEnabled && [view pointInside:[self convertPoint:point toView:view] withEvent:event]) {
            return YES;
        }
    }
    return NO;
}

// dismisses the keyboard when a user selects the return key
- (BOOL) textFieldShouldReturn: (UITextField *) theTextField {
	[theTextField resignFirstResponder];
	return YES;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField {
    activeTextField = textField;
}

@end
