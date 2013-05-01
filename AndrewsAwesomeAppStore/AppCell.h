//
//  AppCell.h
//  AndrewsAwesomeAppStore
//
//  Created by Andrew Melis on 5/1/13.
//  Copyright (c) 2013 Baller Status Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *appIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *devLabel;
@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
