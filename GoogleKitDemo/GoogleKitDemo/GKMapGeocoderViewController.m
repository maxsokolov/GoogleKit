//
//  GKMapGeocoderViewController.m
//  GoogleKitDemo
//
//  Created by Max Sokolov on 12/11/14.
//  Copyright (c) 2014 Max Sokolov. All rights reserved.
//

#import "GKMapGeocoderViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
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
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 70.0f, self.view.frame.size.width, 70.0f)];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.lineBreakMode = NSLineBreakByWordWrapping;
    self.label.numberOfLines = -1;
    self.label.backgroundColor = [UIColor whiteColor];
    
    self.labelLocation = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, self.view.frame.size.height - 50.0f, self.view.frame.size.width, 50.0f)];
    self.labelLocation.textAlignment = NSTextAlignmentCenter;
    self.labelLocation.backgroundColor = [UIColor whiteColor];
    
    UIImageView *pin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pin"]];
    pin.center = self.view.center;

    [self.view addSubview:mapView];
    [self.view addSubview:self.label];
    [self.view addSubview:self.labelLocation];
    [self.view addSubview:pin];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(40.71448f, -74.00598f), 15000.0f, 15000.0f); // New York City
    [mapView setRegion:viewRegion];
}

- (void)lookupAddress:(NSString *)address {

    GKGeocoderQuery *query = [GKGeocoderQuery query];
    query.address = address;
    //query.bounds = @[ @(34.172684f), @(-118.604794f), @(34.236144f), @(-118.500938f) ];
    [query lookupLocation:^(NSArray *results, NSError *error) {
        
        if (error) return;
       
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
    query.coordinate = coord;
    query.language = @"en";
    [query lookupAddress:^(NSArray *result, NSError *error) {
        
        if (error) return;
        
        GKGeocoderPlace *place = [result firstObject];
        if (place) {
            self.label.text = place.formattedAddress;
            
            [self lookupAddress:place.formattedAddress];
        }
    }];
}

@end