//
//  GKNearbySearchViewController.m
//  GoogleKitDemo
//
//  Created by Max Sokolov on 12/11/14.
//  Copyright (c) 2014 Max Sokolov. All rights reserved.
//

#import "GKNearbySearchViewController.h"
#import "GoogleKit.h"
#import "GKMapAnnotation.h"
#import <MapKit/MapKit.h>

@interface GKNearbySearchViewController () <MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSString *nextPageToken;

@end

@implementation GKNearbySearchViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.title = @"Nearby Search";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next page" style:UIBarButtonItemStylePlain target:self action:@selector(handleNextPageButton:)];
    
    self.dataSource = [NSMutableArray array];
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(40.71448f, -74.00598f), 15000.0f, 15000.0f); // New York City
    [self.mapView setRegion:viewRegion];

    [self loadPlaces];
}

- (void)handleNextPageButton:(id)sender {

    [self loadPlaces];
}

- (void)loadPlaces {
    
    GKPlacesNearbySearchQuery *query = [GKPlacesNearbySearchQuery query];
    query.language = @"en";
    query.radius = 3000;
    query.types = @[ @"library" ];
    query.rankByDistance = NO;
    query.location = CLLocationCoordinate2DMake(40.71448f, -74.00598f); // New York City
    query.nextPageToken = self.nextPageToken;

    [query searchPlaces:^(NSArray *results, NSString *nextPageToken, NSError *error) {
        
        [self.dataSource addObjectsFromArray:results];
        [self buildAnnotations:results];
        
        self.nextPageToken = nextPageToken;
    }];
}

- (void)buildAnnotations:(NSArray *)places {
    
    for (GKPlace *place in places) {

        GKMapAnnotation *annotation = [[GKMapAnnotation alloc] initWithCoordinate:place.location.coordinate placeId:place.placeId];
        [self.mapView addAnnotation:annotation];
    }
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    GKMapAnnotation *annotation = view.annotation;

    GKPlaceDetailsQuery *query = [GKPlaceDetailsQuery query];
    query.placeId = annotation.placeId;
    [query fetchDetails:^(GKPlaceDetails *place, NSError *error) {
       
        if (error) return;
        
        if (place.phoneNumber) {
            
            NSLog(@"PHONE NUMBER: %@", place.phoneNumber);

            NSString *phoneNumber = [@"telprompt://" stringByAppendingString:place.phoneNumber];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
        }
    }];
}

@end