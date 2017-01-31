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
}

-(void)viewDidAppear:(BOOL)animated {
//    [self.emptyTextField becomeFirstResponder];
}

@end
