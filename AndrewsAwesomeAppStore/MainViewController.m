//
//  MainViewController.m
//  AndrewsAwesomeAppStore
//
//  Created by Andrew Melis on 4/28/13.
//  Copyright (c) 2013 Baller Status Inc. All rights reserved.
//

#import "MainViewController.h"
#import "AppCell.h"

@interface MainViewController ()
{
    //itunes search api stuff
    NSMutableData *webData;
    NSURLConnection *connection;
    NSMutableArray *testArray;
    
    //generic collectionview arrays
    NSMutableArray *appIcons;
    NSMutableArray *appNames;
    NSMutableArray *appDevs;
    NSMutableArray *appStars;
    NSMutableArray *appPrices;
}

@end

@implementation MainViewController

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

    [[self collectionView]setDelegate:self];
    [[self collectionView]setDataSource:self];
    testArray = [[NSMutableArray alloc]init];
    
    
    appIcons = [[NSMutableArray alloc]initWithObjects:@"poopName1",@"poopName2",@"poopName3",@"poopName4",@"poopName5", nil];
    appNames = [[NSMutableArray alloc]initWithObjects:@"poopName1",@"poopName2",@"poopName3",@"poopName4",@"poopName5", nil];
    appDevs = [[NSMutableArray alloc]initWithObjects:@"poopName1",@"poopName2",@"poopName3",@"poopName4",@"poopName5", nil];
    appStars = [[NSMutableArray alloc]initWithObjects:@"poopName1",@"poopName2",@"poopName3",@"poopName4",@"poopName5", nil];
    appPrices = [[NSMutableArray alloc]initWithObjects:@"poopName1",@"poopName2",@"poopName3",@"poopName4",@"poopName5", nil];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;       //TODO set this to 5 for 1-5 stars?
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
//    return [appNames count];      TODO Do I want to set dynamically?
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"AppCell";
    
    AppCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];
    
    
    [[cell appIcon]setImage:[UIImage imageNamed:[appIcons objectAtIndex:indexPath.item]]];
    
//    [[cell nameLabel]setText:[testArray objectAtIndex:indexPath.item]];
    [[cell nameLabel]setText:[appNames objectAtIndex:indexPath.item]];
    
    [[cell devLabel]setText:[appNames objectAtIndex:indexPath.item]];
    [[cell starLabel]setText:[appNames objectAtIndex:indexPath.item]];
    [[cell priceLabel]setText:[appNames objectAtIndex:indexPath.item]];

    return cell;

}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"fail with error");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    NSArray *results                = [allDataDictionary objectForKey:@"results"];
    
    for (NSDictionary *dictionary in results) {
        NSString *appName = [dictionary objectForKey:@"trackName"];
        
        [testArray addObject:appName];
    }
    [[self collectionView]reloadData];
    
}
- (IBAction)sortButton:(UIButton *)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://jsonviewer.stack.hu/#http://itunes.apple.com/search?term=angry&country=us&entity=software"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if(connection)
    {
        webData = [[NSMutableData alloc]init];
    }
        
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
