//
//  GKMapAnnotation.h
//  GoogleKitDemo
//
//  Created by Max Sokolov on 12/11/14.
//  Copyright (c) 2014 Max Sokolov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GKMapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong, readonly) NSString *placeId;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate placeId:(NSString *)placeId;

@end