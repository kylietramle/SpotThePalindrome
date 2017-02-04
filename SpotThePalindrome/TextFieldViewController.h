//
//  TextFieldViewController.h
//  SpotThePalindrome
//
//  Created by Kylie Tram Le on 1/26/17.
//  Copyright © 2017 Kylie Tram Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextEntry.h"

@class MBProgressHUD;

@interface TextFieldViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) TextEntry *textEntry;
@property (strong, nonatomic) UIButton *checkButton;
@property (strong, nonatomic) UITextField *emptyTextField;
@property (strong, nonatomic) MBProgressHUD *HUD;

-(BOOL)palindromeCheck:(NSString *)string;
-(NSString *)convertStringForCheck:(NSString *)userEntry;
@end
