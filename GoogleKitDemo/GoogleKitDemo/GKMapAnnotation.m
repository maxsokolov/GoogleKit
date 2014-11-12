//
//  GKMapAnnotation.m
//  GoogleKitDemo
//
//  Created by Max Sokolov on 12/11/14.
//  Copyright (c) 2014 Max Sokolov. All rights reserved.
//

#import "GKMapAnnotation.h"

@interface GKMapAnnotation ()

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *placeId;

@end

@implementation GKMapAnnotation

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate placeId:(NSString *)placeId {
    
    self = [super init];
    if (self) {

        self.coordinate = coordinate;
        self.placeId = placeId;
    }
    return self;
}

@end