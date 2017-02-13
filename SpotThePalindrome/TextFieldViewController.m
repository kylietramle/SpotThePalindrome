//
//  TextFieldViewController.m
//  SpotThePalindrome
//
//  Created by Kylie Tram Le on 1/26/17.
//  Copyright © 2017 Kylie Tram Le. All rights reserved.
//

#import "TextFieldViewController.h"
#import "PalindromeHistoryViewController.h"
#import "TextEntry.h"
#import "MBProgressHUD.h"
#import <Realm/Realm.h>
#import "PalindromeHistory.h"

@interface TextFieldViewController ()

@end

@implementation TextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //text field
    CGRect textFieldRect = CGRectMake(0, 0, 200, 180 );
    self.emptyTextField = [[UITextField alloc] initWithFrame:textFieldRect];
    self.emptyTextField.center = self.view.center;
    self.emptyTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.emptyTextField.placeholder = @"What you got?";
    self.emptyTextField.returnKeyType = UIReturnKeyDone;
    self.emptyTextField.delegate = self;
    
    // palindrome check button
    CGRect buttonRect = CGRectMake(280, 290, 100, 100);
    self.checkButton = [[UIButton alloc] initWithFrame:buttonRect];
    [self.checkButton setTitle:@"BAM" forState:UIControlStateNormal];
    [self.checkButton addTarget:self
               action:@selector(checkButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    
    
    // history bar button
    UIBarButtonItem *historyButton = [[UIBarButtonItem alloc] initWithTitle:@"History" style:UIBarButtonItemStylePlain target:self action:@selector(historyButtonTapped:)];
    self.navigationItem.rightBarButtonItem = historyButton;
    
    [self.view addSubview:self.emptyTextField];
    [self.view addSubview:self.checkButton];
    self.view.backgroundColor = [UIColor blueColor];
    
    // add tap gesture to dismiss keyboard
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    // NSLog(@"%@",[RLMRealmConfiguration defaultConfiguration].fileURL); <-- prints out realm url
    
}
- (void) historyButtonTapped:(id) sender{
    PalindromeHistoryViewController *palindromeHistoryVC = [[PalindromeHistoryViewController alloc] init];
    
    [self presentViewController:palindromeHistoryVC animated:YES completion:nil];
}

- (IBAction)checkButtonPressed:(UIButton *)sender {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    hud.label.text = @"Let's see...";
    hud.minSize = CGSizeMake(150.f, 100.f);
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        // run palindrome test in the background
       BOOL palindromeResult = [self palindromeCheck:self.emptyTextField.text];
        
        PalindromeHistory *sharedPalindromeHistoryManager = [PalindromeHistory sharedPalindromeHistoryManager];
        
        [sharedPalindromeHistoryManager addPalindromeEntry:(self.emptyTextField.text) withResult:palindromeResult];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
            
            // Alert condition
            NSString *palindromeNotification = [[NSString alloc] init];
            if (palindromeResult == YES) {
                palindromeNotification = @"A Palindrome!";
            } else {
                palindromeNotification = @"Not a Palindrome!";
            }
            
            // Alert message controller
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"PalindromeNotification" message: palindromeNotification  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
        });
    });
    
    
}

-(BOOL)palindromeCheck:(NSString *)string {
    // make sure string is ready to be checked
    NSMutableString *readyString = [[self convertStringForCheck:string] mutableCopy];
    
    // separate string into characters
    NSMutableArray *arrayOfChar = [[NSMutableArray alloc] initWithCapacity:[readyString length]];
    for (int i=0; i < [readyString length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [readyString characterAtIndex:i]];
        [arrayOfChar addObject:ichar];
    }
    
    // check for palindrome characteristics
    NSUInteger length = [arrayOfChar count];
    for (int j = 0; j < length; j++) {
        if (arrayOfChar[j] != (arrayOfChar[(length -1 - j)])) {
            return NO;
        }
    }
    return YES;
    
}

// removes punctation, spaces, and lowercase string
-(NSString *)convertStringForCheck:(NSString *)textEntry {
    
    NSArray *punctuations = @[ @".", @",", @"!", @"?", @":", @";" ];
    NSString *withoutPunctuation = [textEntry copy];
    for (NSUInteger i = 0; i < [punctuations count]; i++) {
        NSString *punctuation = punctuations[i];
        withoutPunctuation = [withoutPunctuation stringByReplacingOccurrencesOfString:punctuation withString:@""];
    }
    NSString *spaceless = [withoutPunctuation stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *lowercase = [spaceless lowercaseString];
    
    return lowercase;
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
    
    [self checkButtonPressed: self.checkButton];
    [self.emptyTextField resignFirstResponder];
    
    return YES;
}

@end
