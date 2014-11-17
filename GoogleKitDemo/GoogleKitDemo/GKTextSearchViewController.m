//
//  GKTextSearchViewController.m
//  GoogleKitDemo
//
//  Created by Max Sokolov on 18/11/14.
//  Copyright (c) 2014 Max Sokolov. All rights reserved.
//

#import "GKTextSearchViewController.h"
#import "GoogleKit.h"

@implementation GKTextSearchViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
  
    GKPlacesTextSearchQuery *query = [GKPlacesTextSearchQuery query];
    query.language = @"en";
    query.text = @"london";

    [query searchPlaces:^(NSArray *results, NSError *error) {
       
        if (results) {
            
            GKPlace *place = [results firstObject];
            NSLog(@"Result: %@", place.formattedAddress);
        }
    }];
}

@end