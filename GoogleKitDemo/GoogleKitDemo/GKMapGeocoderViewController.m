//
//  GKMapGeocoderViewController.m
//  GoogleKitDemo
//
//  Created by Max Sokolov on 12/11/14.
//  Copyright (c) 2014 Max Sokolov. All rights reserved.
//

#import "GKMapGeocoderViewController.h"
#import <MapKit/MapKit.h>
#import "GoogleKit.h"

@interface GKMapGeocoderViewController () <MKMapViewDelegate>

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *labelLocation;

@end

@implementation GKMapGeocoderViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.title = @"Geocoder";

    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.delegate = self;
    mapView.showsUserLocation = YES;
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 70.0f, self.view.frame.size.width, 100.0f)];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.lineBreakMode = NSLineBreakByWordWrapping;
    self.label.numberOfLines = -1;
    
    self.labelLocation = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, self.view.frame.size.height - 50.0f, self.view.frame.size.width, 50.0f)];
    self.labelLocation.textAlignment = NSTextAlignmentCenter;

    [self.view addSubview:mapView];
    [self.view addSubview:self.label];
    [self.view addSubview:self.labelLocation];
}

- (void)lookupAddress:(NSString *)address {
    
    GKGeocoderQuery *query = [GKGeocoderQuery query];
    query.address = address;
    [query lookupAddress:^(NSArray *results, NSError *error) {
       
        GKGeocoderPlace *place = [results firstObject];
        if (place) {
            self.labelLocation.text = [NSString stringWithFormat:@"%f %f", place.location.coordinate.latitude, place.location.coordinate.longitude];
        }
    }];
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {

    CLLocationCoordinate2D coord = [mapView convertPoint:self.view.center toCoordinateFromView:self.view];

    GKGeocoderQuery *query = [GKGeocoderQuery query];
    query.location = coord;
    [query lookupLocation:^(NSArray *result, NSError *error) {
        
        GKGeocoderPlace *place = [result firstObject];
        if (place) {
            self.label.text = place.formattedAddress;
            
            [self lookupAddress:place.formattedAddress];
        }
    }];
}

@end