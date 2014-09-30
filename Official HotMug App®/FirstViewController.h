//
//  FirstViewController.h
//  Official HotMug App®
//
//  Created by Henry Mound on 7/12/14.
//  Copyright (c) 2014 Henry Mound. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface FirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    IBOutlet UITableView *TableViewResults;
    NSMutableArray *tableTitleArray;
    NSMutableArray *tableDescriptionArray;
    NSMutableArray *tableAddressArray;
    NSMutableArray *tableXCoordArray;
    NSMutableArray *tableYCoordArray;
    int cellCounter;
    long locationCount;
}

    @property (strong, nonatomic) IBOutlet UIButton *FindNeabyButton;
    @property (weak, nonatomic) IBOutlet MKMapView *MapViewNeabyLocations;
    @property (strong, nonatomic) IBOutlet UISegmentedControl *MapOrTableView;
    @property (strong, nonatomic) IBOutlet UITableView *TableViewResults;

    @property (nonatomic, retain) NSMutableArray *tableTitleArray;
    @property (nonatomic, retain) NSMutableArray *tableDescriptionArray;
    @property (nonatomic, retain) NSMutableArray *tableAddressArray;
    @property (nonatomic, retain) NSMutableArray *tableXCoordArray;
    @property (nonatomic, retain) NSMutableArray *tableYCoordArray;



@end
