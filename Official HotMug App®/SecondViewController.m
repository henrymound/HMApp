//
//  SecondViewController.m
//  Official HotMug App®
//
//  Created by Henry Mound on 7/12/14.
//  Copyright (c) 2014 Henry Mound. All rights reserved.
//

#import "SecondViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize searchBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addressToCoords:(id)sender {
    //NSLog(@"%@", [searchBar text]);
    
    NSString *stringURL = @"http://currentlights.com/locations.plist";
    NSURL  *url = [NSURL URLWithString:stringURL];
    NSDictionary *locationsDict = [NSDictionary dictionaryWithContentsOfURL:url];
    NSString *xCoord = @"", *yCoord = @"";

    
    for(int x = 1; x < (unsigned long)[[locationsDict allKeys] count] + 1; x++){
        xCoord = [[locationsDict objectForKey:[NSString stringWithFormat:@"%d", x]] objectForKey:@"x"];
        yCoord = [[locationsDict objectForKey:[NSString stringWithFormat:@"%d", x]] objectForKey:@"y"];
        NSLog(@"Got x from value: %@", xCoord);
        NSLog(@"Got y from value: %@", yCoord);
    }
    
    NSString *theAddress = [searchBar text];
    CLLocationCoordinate2D theAddressCoord = [self geoCodeUsingAddress: theAddress];
    NSLog(@"you are at long: %f, lat: %f", theAddressCoord.longitude, theAddressCoord.latitude);
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:theAddressCoord.latitude longitude:theAddressCoord.longitude];
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:[xCoord doubleValue] longitude:[yCoord doubleValue]];
    // returns a double in meters
    CLLocationDistance distance = [location1 distanceFromLocation:location2];
    NSLog(@"The closest place is %f meters away", distance);
    
    [self.view endEditing:YES];
    
}

- (CLLocationCoordinate2D) geoCodeUsingAddress:(NSString *)address
{
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude = latitude;
    center.longitude = longitude;
    return center;
}

@end
