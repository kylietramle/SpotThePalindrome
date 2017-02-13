//
//  PalindromeHistoryViewController.m
//  SpotThePalindrome
//
//  Created by Kylie Tram Le on 2/8/17.
//  Copyright © 2017 Kylie Tram Le. All rights reserved.
//

#import "PalindromeHistoryViewController.h"
#import <Realm/Realm.h>
#import "TextEntry.h"
#import "PalindromeHistory.h"

@interface PalindromeHistoryViewController ()

@end

@implementation PalindromeHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    // button to dismiss history view
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeButton.frame = CGRectMake(15, 15, 50, 30);
    [closeButton setTitle:@"Back" forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [collectionView addSubview:closeButton];
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = [UIColor yellowColor];


}
-(void)viewWillAppear:(BOOL)animated {
    PalindromeHistory *sharedPalindromeHistoryManager = [PalindromeHistory sharedPalindromeHistoryManager];
    self.palindromeArray = [sharedPalindromeHistoryManager getPalindromeArray];
//    NSLog(@"%@", self.palindromeArray);
}

- (IBAction)closeButtonTapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    TextEntry *textAtIndexPath = self.palindromeArray[indexPath.row];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, 70, 30)];
    textLabel.text = textAtIndexPath.text;
    UILabel *booleanLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 60, 70, 30)];
    if (textAtIndexPath.isPalindrome == NO) {
        booleanLabel.text = @"No";
    } else {
        booleanLabel.text = @"Yes";
    }
    
    [cell.contentView addSubview:textLabel];
    [cell.contentView addSubview:booleanLabel];
    
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.palindromeArray.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width/2 - 20, 150);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 10, 30, 10);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexPath is %@", indexPath);
}

@end
