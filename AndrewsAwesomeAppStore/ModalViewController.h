//
//  ModalViewController.h
//  AndrewsAwesomeAppStore
//
//  Created by Andrew Melis on 5/1/13.
//  Copyright (c) 2013 Baller Status Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModalViewController : UIViewController

@property (weak) IBOutlet UIImageView *appIcon;

@property (nonatomic, weak) NSString *appName;
@property (nonatomic, weak) NSString *appDev;
@property (nonatomic, weak) NSString *appStars;
@property (nonatomic, weak) NSString *appPrice;
@property (nonatomic, weak) NSString *appDescription;

@property (weak, nonatomic) IBOutlet UIImageView *modalIcon;
@property (weak, nonatomic) IBOutlet UILabel *modalName;
@property (weak, nonatomic) IBOutlet UILabel *modalDev;
@property (weak, nonatomic) IBOutlet UILabel *modalStars;
@property (weak, nonatomic) IBOutlet UILabel *modalPrice;
@property (weak, nonatomic) IBOutlet UILabel *modalDescription;



- (IBAction)buyButton:(UIButton *)sender;
- (IBAction)favoriteButton:(UIButton *)sender;
- (IBAction)exitButton:(UIButton *)sender;

-(void)setLabels;




@end
