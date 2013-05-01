//
//  MainViewController.h
//  AndrewsAwesomeAppStore
//
//  Created by Andrew Melis on 4/28/13.
//  Copyright (c) 2013 Baller Status Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NSURLConnectionDataDelegate, UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

- (IBAction)sortButton:(UIButton *)sender;

@end
