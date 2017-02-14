//
//  PalindromeHistoryViewController.h
//  SpotThePalindrome
//
//  Created by Kylie Tram Le on 2/8/17.
//  Copyright © 2017 Kylie Tram Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PalindromeHistoryViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) NSMutableArray *palindromeArray;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewCell *cell;
@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UILabel *booleanLabel;
@end
