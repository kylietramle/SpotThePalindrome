//
//  PalindromeHistory.h
//  SpotThePalindrome
//
//  Created by Kylie Tram Le on 2/10/17.
//  Copyright © 2017 Kylie Tram Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TextEntry.h"
#import <Realm/Realm.h>

RLM_ARRAY_TYPE(TextEntry)
@interface PalindromeHistory : RLMObject
@property RLMArray<TextEntry *><TextEntry> *textEntries;

+ (id)sharedPalindromeHistoryManager;
- (void)addPalindromeEntry:(NSString *)textEntry withResult:(BOOL)isPalindrome;
- (NSMutableArray *)getPalindromeArray;
@end
