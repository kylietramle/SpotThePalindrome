//
//  TextFieldViewController.h
//  SpotThePalindrome
//
//  Created by Kylie Tram Le on 1/26/17.
//  Copyright © 2017 Kylie Tram Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextEntry.h"

@interface TextFieldViewController : UIViewController
@property (strong, nonatomic) TextEntry *textEntry;
@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UITextField *emptyTextField;
@end
