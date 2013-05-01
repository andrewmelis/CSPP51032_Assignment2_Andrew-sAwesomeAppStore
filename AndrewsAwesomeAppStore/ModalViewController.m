//
//  ModalViewController.m
//  AndrewsAwesomeAppStore
//
//  Created by Andrew Melis on 5/1/13.
//  Copyright (c) 2013 Baller Status Inc. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()

-(IBAction)done:(id) sender;

@end

@implementation ModalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

//again, thanks to Jonny for this part
-(void)setLabels
{
    self.modalName.text = self.appName;
    self.modalDev.text = self.appDev;
    self.modalStars.text = [NSString stringWithFormat:@"Rating: %@/5",self.appStars];
    self.modalPrice.text = [NSString stringWithFormat:@"$%@",self.appPrice];
//    self.modalDescription.text = self.appDescription;
//    [[self moddalIcon]setImage:self.appIcon];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)favoriteButton:(UIButton *)sender
{
    //TODO
}

- (IBAction)exitButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)buyButton:(UIButton *)sender
{
    //TODO
}
//- (IBAction)done:(UIButton *)sender {
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//}


@end
