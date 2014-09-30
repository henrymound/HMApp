//
//  FirstViewController.m
//  Official HotMug App®
//
//  Created by Henry Mound on 7/12/14.
//  Copyright (c) 2014 Henry Mound. All rights reserved.
//

#import "FirstViewController.h"
#import "MapPin.h"
#import "TableCell.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize MapViewNeabyLocations = _MapViewNeabyLocations, FindNeabyButton = _FindNeabyButton, MapOrTableView = _MapOrTableView, TableViewResults = _TableViewResults, tableAddressArray = _tableAddressArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    cellCounter = 0;
    _tableTitleArray = [[NSMutableArray alloc] init];
    _tableAddressArray = [[NSMutableArray alloc] init];
    [self populateLocationTable];
    locationCount = [self getNumberOfLocations];
    NSLog(@"Number of items in Table: %lu", (unsigned long)_tableTitleArray.count);
    [self.MapViewNeabyLocations.delegate self];
    [self.MapViewNeabyLocations setShowsUserLocation:YES];
    NSString *locationsList = [[NSBundle mainBundle] pathForResource:@"locations" ofType:@"plist"];
    NSDictionary *locationsDict = [NSDictionary dictionaryWithContentsOfFile:locationsList];
    
    NSLog(@"%@", [[locationsDict objectForKey:@"1"] objectForKey:@"x"]);
}

- (void)didReceiveMemoryWarning{[super didReceiveMemoryWarning];}
     
- (int)getNumberOfLocations{
    NSString *stringURL = @"http://currentlights.com/locations.plist";
    NSURL  *url = [NSURL URLWithString:stringURL];
    NSDictionary *locationsDict = [NSDictionary dictionaryWithContentsOfURL:url];
    return ((int)[[locationsDict allKeys] count] + 1);
}

- (IBAction)FindNearbyLocations:(id)sender {
    
    _FindNeabyButton.hidden = TRUE;
    _MapViewNeabyLocations.hidden = FALSE;
    [self MapViewNeabyLocations:_MapViewNeabyLocations didUpdateUserLocation:_MapViewNeabyLocations.userLocation];
    
    NSMutableArray *xArray = [NSMutableArray array];
    NSMutableArray *yArray = [NSMutableArray array];
    MKCoordinateRegion CoordinateRegion = {{0.0, 0.0}, {0.0, 0.0}};
    NSString *stringURL = @"http://currentlights.com/locations.plist";
    NSURL  *url = [NSURL URLWithString:stringURL];
    NSDictionary *locationsDict = [NSDictionary dictionaryWithContentsOfURL:url];

    for (int x = 0; x < locationCount; x++){
        MapPin *locationToAdd = [[MapPin alloc] init];
        locationToAdd.title = [[locationsDict objectForKey:[NSString stringWithFormat:@"%d", x]] objectForKey:@"name"];
        locationToAdd.subtitle = [[locationsDict objectForKey:[NSString stringWithFormat:@"%d", x]] objectForKey:@"address"];
        NSNumber *yCoord = [NSNumber numberWithDouble:[[[locationsDict objectForKey:[NSString stringWithFormat:@"%d", x]] objectForKey:@"y"] floatValue]];
        NSNumber *xCoord = [NSNumber numberWithDouble:[[[locationsDict objectForKey:[NSString stringWithFormat:@"%d", x]] objectForKey:@"x"] floatValue]];
        locationToAdd.coordinate = CLLocationCoordinate2DMake([xCoord doubleValue], [yCoord doubleValue]);

//        doubleDutch.coordinate = doubleDutchCoffee.center;
        [_MapViewNeabyLocations addAnnotation:locationToAdd];
    }
    

    
    
}

- (void)populateLocationTable{
    
    NSString *stringURL = @"http://currentlights.com/locations.plist";
    NSURL  *url = [NSURL URLWithString:stringURL];
    NSDictionary *locationsDict = [NSDictionary dictionaryWithContentsOfURL:url];
    
    for(int x = 1; x < (unsigned long)[[locationsDict allKeys] count] + 1; x++){
        [_tableTitleArray addObject: [[locationsDict objectForKey:[NSString stringWithFormat:@"%d", x]] objectForKey:@"name"]];
        [_tableAddressArray addObject: [[locationsDict objectForKey:[NSString stringWithFormat:@"%d", x]] objectForKey:@"address"]];
        [_tableXCoordArray addObject: [[locationsDict objectForKey:[NSString stringWithFormat:@"%d", x]] objectForKey:@"x"]];
        [_tableYCoordArray addObject: [[locationsDict objectForKey:[NSString stringWithFormat:@"%d", x]] objectForKey:@"y"]];
        NSLog(@"Added Title to array: %@", [[locationsDict objectForKey:[NSString stringWithFormat:@"%d", x]] objectForKey:@"name"]);
        NSLog(@"Added address to array: %@", [[locationsDict objectForKey:[NSString stringWithFormat:@"%d", x]] objectForKey:@"address"]);
        NSLog(@"Added X to array: %@", [[locationsDict objectForKey:[NSString stringWithFormat:@"%d", x]] objectForKey:@"x"]);
        NSLog(@"Added Y to array: %@", [[locationsDict objectForKey:[NSString stringWithFormat:@"%d", x]] objectForKey:@"y"]);
    }
    
}

- (IBAction)TextMapSwitch:(id)sender {
    
    if (_MapOrTableView.selectedSegmentIndex == 1) {
        _TableViewResults.hidden = FALSE;
        _MapViewNeabyLocations.hidden = TRUE;
    }else if (_MapOrTableView.selectedSegmentIndex == 0){
        _TableViewResults.hidden = TRUE;
        _MapViewNeabyLocations.hidden = FALSE;}
    
}

-(void)MapViewNeabyLocations:(MKMapView *)MapViewNeabyLocations didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 500, 500);//Made with location and two distance parameters (meters)
    [self.MapViewNeabyLocations setRegion:region animated:YES];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return locationCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    if(cellCounter < _tableTitleArray.count){
        cell.textLabel.text = [_tableTitleArray objectAtIndex:cellCounter];
        cell.detailTextLabel.text = [_tableAddressArray objectAtIndex:cellCounter];
        cell.imageView.image = [UIImage imageNamed:@"mugImage.png"];
        NSLog(@"Description: %@", [_tableAddressArray objectAtIndex:cellCounter]);
    }
    cellCounter++;
    return cell;
}

@end
