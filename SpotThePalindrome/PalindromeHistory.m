//
//  PalindromeHistory.m
//  SpotThePalindrome
//
//  Created by Kylie Tram Le on 2/10/17.
//  Copyright © 2017 Kylie Tram Le. All rights reserved.
//

#import "PalindromeHistory.h"
#import <Realm/Realm.h>

@implementation PalindromeHistory

- (void)addPalindromeEntry:(NSString *)textEntry withResult:(BOOL *)isPalindrome {
    TextEntry *palindromeObject = [[TextEntry alloc] init];
    palindromeObject.text = textEntry;
    palindromeObject.isPalindrome = isPalindrome;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
        
        [realm transactionWithBlock:^{
            [realm addObject:palindromeObject];
        }];
}

- (NSMutableArray *)getPalindromeArray {
    RLMResults<TextEntry *> *tempPalindromeArray = [TextEntry allObjects];
    
    NSMutableArray *palindromeArray = [[NSMutableArray alloc] init];
    for (RLMObject *palindrome in tempPalindromeArray) {
        [palindromeArray addObject:palindrome];
    }
    
    return palindromeArray;
}

// singleton
+ (id)sharedPalindromeHistoryManager {
    static PalindromeHistory *sharedMyManager = nil;
    @synchronized(self) {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
    return sharedMyManager;
}

@end
