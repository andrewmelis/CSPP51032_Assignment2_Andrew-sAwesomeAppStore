//
//  MainViewController.m
//  AndrewsAwesomeAppStore
//
//  Created by Andrew Melis on 4/28/13.
//  Copyright (c) 2013 Baller Status Inc. All rights reserved.
//

//special thanks to iffytheperfect1983's youtube tutorials

#import "MainViewController.h"
#import "AppCell.h"
#import <QuartzCore/QuartzCore.h>

@interface MainViewController ()
{
    //itunes search api stuff
    NSMutableData *webData;
    NSURLConnection *connection;
//    NSMutableArray *testArray;
    
    //for search bar
    NSMutableArray *totalStrings;
    NSMutableArray *filteredStrings;
    BOOL isFiltered;
    
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

    //set delegate and data source
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.searchBar.delegate = self;
    
    self.searchBar.placeholder = @"search for an app...";
    
//    totalStrings = [[NSMutableArray alloc]initWithObjects:@"poopName1",@"poopName2",@"poopName3",@"poopName4",@"poopName5", nil];
    
    
    
    
//    testArray = [[NSMutableArray alloc]initWithObjects:@"poopName1",@"poopName2",@"poopName3",@"poopName4",@"poopName5", nil];
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
    if (isFiltered) {
        return [filteredStrings count];      //TODO Do I want to set dynamically?
    }
    //else
    return [appNames count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"AppCell";
    
    AppCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];



    if (!isFiltered) {
    
//    [[cell appIcon]setImage:[UIImage imageNamed:[appIcons objectAtIndex:indexPath.item]]];
        [[cell nameLabel]setText:[appNames objectAtIndex:indexPath.item]];
        [[cell devLabel]setText:[NSString stringWithFormat:@"by %@",[appDevs objectAtIndex:indexPath.item]]];
        [[cell starLabel]setText:[NSString stringWithFormat:@"Rating: %@/5",[appStars objectAtIndex:indexPath.item]]];
        [[cell priceLabel]setText:[NSString stringWithFormat:@"$%@",[appPrices objectAtIndex:indexPath.item]]];
        cell.backgroundColor = [UIColor purpleColor];
    }
    else {
        [[cell nameLabel]setText:[filteredStrings objectAtIndex:indexPath.item]];       //TODO need to fix this to set all fields
        cell.backgroundColor = [UIColor brownColor];
    }
    cell.layer.cornerRadius=30;         //make it pretty
    return cell;

}

//searchBar methods
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length==0) {
        isFiltered= NO;
    }
    else {
        isFiltered = YES;
        filteredStrings = [[NSMutableArray alloc]init];
        
        for(NSString *str in appNames) {
            NSRange stringRange = [str rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if(stringRange.location != NSNotFound) {
                [filteredStrings addObject:str];
            }
        }
    }
    
    [self.collectionView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //write string to memory
    //call helper function
    
    //get rid of keyboard
    [self.searchBar resignFirstResponder];
}

//get web data methods
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
        NSString *appStar = [dictionary objectForKey:@"averageUserRating"];
        NSString *appDev = [dictionary objectForKey:@"artistName"];
        NSString *appPrice = [dictionary objectForKey:@"price"];
        [appNames addObject:appName];
        [appStars addObject:appStar];
        [appDevs addObject:appDev];
        [appPrices addObject:appPrice];
        

//        UIImage *appIcon = [dictionary objectForKey:@"artworkUrl512"];
//        [appIcons addObject:appIcon];                                             //TODO get images working
        NSLog(@"added stuff to arrays");
    }
    [[self collectionView]reloadData];
    
}

//button refresh method
- (IBAction)sortButton:(UIButton *)sender {
    
    [appNames removeAllObjects];
    [appStars removeAllObjects];
    [appDevs removeAllObjects];
    [appPrices removeAllObjects];
    
    NSString *urlString = @"http://itunes.apple.com/search?term=angry+dum+bum&country=us&entity=software";
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if(connection)
    {
        webData = [[NSMutableData alloc]init];
    }
    
}

-(NSString*)urlStringBulder:(UISearchBar*)searchBar {
    NSString *urlString = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"+" options:NULL range:NSMakeRange(0,searchBar.text.length)];
    
    NSString *poop = [NSString stringWithFormat:@"http://itunes.apple.com/search?term=@%&country=us&entity=software",urlString];
    return poop;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
