//
//  UIRootViewController.m
//  GoogleKitDemo
//
//  Created by Max Sokolov on 30/04/14.
//  Copyright (c) 2014 Max Sokolov. All rights reserved.
//

#import "UIRootViewController.h"
#import <MapKit/MapKit.h>

NSString *const kGoogleKitAPIKey = @"AIzaSyDYSyHklqn-3aFjic9XatFN5fm8b5Uz15M";

@interface UIRootViewController () <MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;

@property (nonatomic, strong) GKPlaceAutocompleteQuery *autocompleteQuery;
@property (nonatomic, strong) GKGeocoderQuery *geocoderQuery;
@property (nonatomic, strong) GKPlacesQuery *placesQuery;

@end

@implementation UIRootViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    [self.view addSubview:self.mapView];
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [self.mapView addGestureRecognizer:recognizer];
    
    self.autocompleteQuery = [[GKPlaceAutocompleteQuery alloc] init];
    self.autocompleteQuery.key = kGoogleKitAPIKey;
    self.autocompleteQuery.input = @"кра";
    self.autocompleteQuery.language = @"ru";
    self.autocompleteQuery.components = @[ @"country:ru" ];
    self.autocompleteQuery.location = CLLocationCoordinate2DMake(55.738407f, 37.612306f);
    self.autocompleteQuery.radius = 50000;
    
    [self.autocompleteQuery fetchPlaces:^(NSArray *results, NSError *error) {
       
        for (GKPlaceAutocomplete *place in results) {
            
            NSLog(@"\n%@", place.description);
            
            for (GKPlaceAutocompleteTerm *term in place.terms)
                NSLog(@"%@", term.value);
        }
    }];
}

- (void)handleGesture:(UITapGestureRecognizer *)recognizer {
    
    //CGPoint touchPoint = [recognizer locationInView:self.mapView];
    //CLLocationCoordinate2D coordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    /*self.geocoderQuery.location = coordinate;
    [self.geocoderQuery lookupLocation:^(NSArray *results, NSError *error) {
        
        GKPlaceDetails *place = [results firstObject];
       
        NSLog(@"adr: %@ %@", place.route, place.streetNumber);
    }];*/

    /*GKPlacesQuery *query = [GKPlacesQuery query];
    query.key = kGoogleKitAPIKey;
    query.types = @[@"car_repair"];
    query.radius = 3000;
    query.language = @"ru";
    query.location = coordinate;
    [query nearbySearch:^(NSArray *result, NSError *error) {
       
        
    }];*/

    /*GKPlaceDetailsQuery *query = [GKPlaceDetailsQuery query];
    query.key = kGoogleKitAPIKey;
    query.language = @"ru";
    query.reference = @"CoQBfwAAAEkNF33Byo-dLTwpI_e48RvxYR1iGj32Zmol3Dj7dVVhgUN6feBgpsIyjTmlazY5H6PAolAUTEj8VVeSoxGHUxrYydn4tM8_79u27PIwqUDVDWgIoxXjg9uHQSMpfNDfnTCWgbo7uPpfChX5lOy75c8Mx3RjSbKmlGGL-dw-LAlvEhDXIjJvvKiPxWfU4NG2n9J8GhQNyWy6xLc5iimEvGolriVHsppq4g";
    [query fetchDetails:^(GKPlaceDetailsQueryResult *result, NSError *error) {

        NSLog(@"x: %@ %@ %@", result.streetNumber, result.country, error);
    }];*/
}

#pragma mark - MKMapViewDelegate

/*- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    self.mapView.centerCoordinate = userLocation.location.coordinate;
    
    static int x1 = 0;
    
    x1++;
    
    if (x1 == 1) {
        
        self.autocompleteQuery.location = userLocation.location.coordinate;
        [self.autocompleteQuery fetchPlaces:^(NSArray *places, NSError *error) {

            for (GKPlaceAutocomplete *place in places) {
                
                NSLog(@"%@", place.name);
            }
        }];
    }
}*/

@end