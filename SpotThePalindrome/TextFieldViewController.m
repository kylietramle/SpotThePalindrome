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
    
    CGRect textFieldRect = CGRectMake(0, 0, 200, 180 );
    self.emptyTextField = [[UITextField alloc] initWithFrame:textFieldRect];
    self.emptyTextField.center = self.view.center;
    self.emptyTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.emptyTextField.placeholder = @"Palindrome Meee";
    self.emptyTextField.returnKeyType = UIReturnKeyDone;
    
    CGRect buttonRect = CGRectMake(280, 290, 100, 100);
    self.checkButton = [[UIButton alloc] initWithFrame:buttonRect];
    [self.checkButton setTitle:@"BAM" forState:UIControlStateNormal];
    [self.checkButton addTarget:self
               action:@selector(checkButtonPresssed:)
     forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:self.emptyTextField];
    [self.view addSubview:self.checkButton];
    self.view.backgroundColor = [UIColor blueColor];
    
    self.emptyTextField.delegate = self;
    
    // add tap gesture
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

- (void) checkButtonPressed {
    
}

// responds to tap--dismiss keyboard & activate animation
- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

// animates textfield jumps when keyboard pops up
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.emptyTextField.frame = CGRectMake(self.emptyTextField.frame.origin.x, (self.emptyTextField.frame.origin.y - 100.0), self.emptyTextField.frame.size.width, self.emptyTextField.frame.size.height);
    self.checkButton.frame = CGRectMake(self.checkButton.frame.origin.x, (self.checkButton.frame.origin.y - 100.0), self.checkButton.frame.size.width, self.checkButton.frame.size.height);
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.emptyTextField.frame = CGRectMake(self.emptyTextField.frame.origin.x, (self.emptyTextField.frame.origin.y + 100.0), self.emptyTextField.frame.size.width, self.emptyTextField.frame.size.height);
     self.checkButton.frame = CGRectMake(self.checkButton.frame.origin.x, (self.checkButton.frame.origin.y + 100.0), self.checkButton.frame.size.width, self.checkButton.frame.size.height);
    [UIView commitAnimations];
}

// make keyboard go away
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.textEntry.enteredString = self.emptyTextField.text;
    
    [self.emptyTextField resignFirstResponder];
    
    return YES;
}


@end
