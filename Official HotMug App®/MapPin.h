//
//  MapPin.h
//  Official HotMug App®
//
//  Created by Henry Mound on 7/12/14.
//  Copyright (c) 2014 Henry Mound. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapPin : NSObject<MKAnnotation>{

    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
