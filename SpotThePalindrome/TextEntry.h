//
//  TextEntry.h
//  SpotThePalindrome
//
//  Created by Kylie Tram Le on 1/26/17.
//  Copyright © 2017 Kylie Tram Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface TextEntry : RLMObject
@property (strong, nonatomic) NSString *text;
@property (nonatomic, assign) BOOL isPalindrome;
@end
