//
//  TextFieldViewController.m
//  SpotThePalindrome
//
//  Created by Kylie Tram Le on 1/26/17.
//  Copyright © 2017 Kylie Tram Le. All rights reserved.
//

#import "TextFieldViewController.h"
#import "TextEntry.h"

@interface TextFieldViewController ()

@end

@implementation TextFieldViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    TextEntry *textEntry = [[TextEntry alloc] init];
    
    CGRect textFieldRect = CGRectMake(0, 0, 200, 200 );
    self.emptyTextField = [[UITextField alloc] initWithFrame:textFieldRect];
    self.emptyTextField.center = self.view.center;
    self.emptyTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.emptyTextField.placeholder = @"Palindrome Meee";
    self.emptyTextField.returnKeyType = UIReturnKeyDone;
    
    [self.view addSubview:self.emptyTextField];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.emptyTextField.delegate = self;
}

// animates textfield jumps when keyboard pops up
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.emptyTextField.frame = CGRectMake(self.emptyTextField.frame.origin.x, (self.emptyTextField.frame.origin.y - 100.0), self.emptyTextField.frame.size.width, self.emptyTextField.frame.size.height);
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.emptyTextField resignFirstResponder];
    
    return YES;
}


@end
