//
//  TextEntry.m
//  SpotThePalindrome
//
//  Created by Kylie Tram Le on 1/26/17.
//  Copyright © 2017 Kylie Tram Le. All rights reserved.
//

#import "TextEntry.h"

@implementation TextEntry
- (id) init {
    self = [super init];
    if (self) {
        self.enteredString = @"Nothing yet";
    }
    
    return self;
}
@end
