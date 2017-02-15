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
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    // button to dismiss history view
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeButton.frame = CGRectMake(10, 15, 50, 30);
    [closeButton setTitle:@"Back" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.collectionView addSubview:closeButton];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor colorWithRed:131/255.0 green:175/255.0 blue:155/255.0 alpha:1.0];
    self.view.backgroundColor  = [UIColor colorWithRed:131/255.0 green:175/255.0 blue:155/255.0 alpha:1.0];;
}

// get all the palindromes everytime view appears to load them
-(void)viewWillAppear:(BOOL)animated {
    PalindromeHistory *sharedPalindromeHistoryManager = [PalindromeHistory sharedPalindromeHistoryManager];
    self.palindromeArray = [sharedPalindromeHistoryManager getPalindromeArray];
}


- (IBAction)closeButtonTapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    self.cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    TextEntry *textAtIndexPath = self.palindromeArray[indexPath.row];
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, 80, 30)];
    self.textLabel.text = textAtIndexPath.text;
    [self.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
    
    self.booleanLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 60, 60, 30)];
    [self.booleanLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];

    
    if (textAtIndexPath.isPalindrome == NO) {
        self.booleanLabel.text = @"No";
    } else {
        self.booleanLabel.text = @"Yes";
    }
    
    [self.textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.booleanLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.cell.contentView addSubview:self.textLabel];
    [self.cell.contentView addSubview:self.booleanLabel];
    
    self.cell.backgroundColor = [UIColor colorWithRed:222/255.0 green:228/255.0 blue:213/255.0 alpha:1.0];
    
    // vertically-centered constraints for textLabel
    NSLayoutConstraint *constraint = [NSLayoutConstraint
                                      constraintWithItem: self.textLabel
                                      attribute: NSLayoutAttributeCenterY
                                      relatedBy: NSLayoutRelationEqual
                                      toItem: self.cell
                                      attribute: NSLayoutAttributeCenterY
                                      multiplier: 1
                                      constant: 0];
    
    [self.cell addConstraint:constraint];
    
    // booleanLabel constraint to same line as textLabel
        constraint = [NSLayoutConstraint
                        constraintWithItem: self.booleanLabel
                        attribute: NSLayoutAttributeBaseline
                        relatedBy: NSLayoutRelationEqual
                        toItem: self.textLabel
                        attribute: NSLayoutAttributeBaseline
                        multiplier: 1
                        constant: 0];
    
    [self.cell addConstraint:constraint];
    
    // left constraint for textLabel
    constraint = [NSLayoutConstraint
                  constraintWithItem:self.textLabel
                  attribute: NSLayoutAttributeLeft
                  relatedBy: NSLayoutRelationEqual
                  toItem: self.cell
                  attribute: NSLayoutAttributeLeft
                  multiplier: 1
                  constant: 10];
    
    [self.cell addConstraint:constraint];
    
    // right constraint for booleanLabel
    constraint = [NSLayoutConstraint
                  constraintWithItem: self.booleanLabel
                  attribute: NSLayoutAttributeRight
                  relatedBy: NSLayoutRelationEqual
                  toItem: self.cell
                  attribute: NSLayoutAttributeRight
                  multiplier: 1
                  constant: -10];
    
    [self.cell addConstraint:constraint];



    return self.cell;
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

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
