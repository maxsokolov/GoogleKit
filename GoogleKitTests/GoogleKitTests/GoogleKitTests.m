//
//    Copyright (c) 2014 Max Sokolov (http://maxsokolov.net)
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy of
//    this software and associated documentation files (the "Software"), to deal in
//    the Software without restriction, including without limitation the rights to
//    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//    the Software, and to permit persons to whom the Software is furnished to do so,
//    subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "GoogleKit.h"

#define kGoogleKitKey @"your_api_key"

@interface GoogleKitTests : XCTestCase

@end

@implementation GoogleKitTests

- (void)setUp {

    [super setUp];
    
    if ([kGoogleKitKey isEqualToString:@"your_api_key"]) @throw [NSException exceptionWithName:@"GoogleKey" reason:@"Please, provide api key!" userInfo:nil];
}

- (void)tearDown {

    [super tearDown];
}

- (void)testAddressGeocoder {

    XCTestExpectation *testExpectation = [self expectationWithDescription:@"address geocoder"];

    GKGeocoderQuery *query = [GKGeocoderQuery query];
    query.key = kGoogleKitKey;
    query.address = @"New York";
    query.language = @"en";
    query.region = @"us";
    query.components = @[ @"country:US" ];
    [query lookupLocation:^(NSArray *results, NSError *error) {
        
        XCTAssertNil(error);
        XCTAssertTrue(results.count > 0);
        XCTAssertTrue([[results firstObject] isKindOfClass:[GKGeocoderPlace class]]);

        [testExpectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testLocationGeocoder {
    
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"location geocoder"];
    
    GKGeocoderQuery *query = [GKGeocoderQuery query];
    query.key = kGoogleKitKey;
    query.coordinate = CLLocationCoordinate2DMake(55.738407f, 37.612306f);
    query.language = @"en";
    query.resultType = @[ @"street_address" ];
    query.locationType = @[ @"ROOFTOP" ];
    [query lookupAddress:^(NSArray *results, NSError *error) {
        
        XCTAssertNil(error);
        XCTAssertTrue(results.count > 0);
        XCTAssertTrue([[results firstObject] isKindOfClass:[GKGeocoderPlace class]]);
        
        [testExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testNearbySearch {
    
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"nearby search"];

    GKPlacesNearbySearchQuery *query = [GKPlacesNearbySearchQuery query];
    query.key = kGoogleKitKey;
    query.coordinate = CLLocationCoordinate2DMake(40.71448f, -74.00598f);
    query.rankByDistance = NO;
    query.radius = 3000;
    query.language = @"en";
    query.keyword = @"library";
    query.minprice = 0;
    query.maxprice = 4;
    query.opennow = YES;
    query.types = @[ @"library" ];
    [query searchPlaces:^(NSArray *results, NSString *nextPageToken, NSError *error) {
        
        XCTAssertNil(error);
        XCTAssertTrue(results.count > 0);
        XCTAssertTrue(nextPageToken);
        XCTAssertTrue([[results firstObject] isKindOfClass:[GKPlace class]]);

        [testExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testTextSearch {
    
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"text search"];
    
    GKPlacesTextSearchQuery *query = [GKPlacesTextSearchQuery query];
    query.key = kGoogleKitKey;
    query.text = @"library";
    query.language = @"en";
    query.coordinate = CLLocationCoordinate2DMake(40.71448f, -74.00598f);
    query.radius = 3000;
    query.minprice = 0;
    query.maxprice = 4;
    query.opennow = YES;
    query.types = @[ @"library" ];
    [query searchPlaces:^(NSArray *results, NSError *error) {
        
        XCTAssertNil(error);
        XCTAssertTrue(results.count > 0);
        XCTAssertTrue([[results firstObject] isKindOfClass:[GKPlace class]]);
        
        [testExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testRadarSearch {
    
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"radar search"];

    GKPlacesRadarSearchQuery *query = [GKPlacesRadarSearchQuery query];
    query.key = kGoogleKitKey;
    query.coordinate = CLLocationCoordinate2DMake(40.71448f, -74.00598f);
    query.radius = 3000;
    query.language = @"en";
    query.keyword = @"library";
    query.minprice = 0;
    query.maxprice = 4;
    query.name = @"library";
    query.opennow = YES;
    query.types = @[ @"library" ];
    [query searchPlaces:^(NSArray *results, NSError *error) {

        XCTAssertNil(error);
        XCTAssertTrue(results.count > 0);
        XCTAssertTrue([[results firstObject] isKindOfClass:[GKPlace class]]);
        
        [testExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testPlaceAutocomplete {
    
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"place autocomplete"];
    
    GKPlaceAutocompleteQuery *query = [GKPlaceAutocompleteQuery query];
    query.key = kGoogleKitKey;
    query.input = @"wall street";
    query.coordinate = CLLocationCoordinate2DMake(55.738407f, 37.612306f);
    query.types = @[ @"geocode" ];
    query.components = @[ @"country:us" ];
    query.radius = 10000;
    query.offset = 3;
    query.language = @"en";
    [query fetchPlaces:^(NSArray *results, NSError *error) {

        XCTAssertNil(error);
        XCTAssertTrue(results.count > 0);
        XCTAssertTrue([[results firstObject] isKindOfClass:[GKPlaceAutocomplete class]]);
        
        [testExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testPlaceDetails {
    
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"place defails"];

    GKPlaceAutocompleteQuery *query = [GKPlaceAutocompleteQuery query];
    query.key = kGoogleKitKey;
    query.input = @"wall street";
    query.coordinate = CLLocationCoordinate2DMake(55.738407f, 37.612306f);
    query.types = @[ @"geocode" ];
    query.components = @[ @"country:us" ];
    query.radius = 10000;
    query.offset = 3;
    query.language = @"en";
    [query fetchPlaces:^(NSArray *results, NSError *error) {
        
        GKPlaceAutocomplete *place = [results firstObject];
        
        XCTAssertNil(error);
        XCTAssertTrue(results.count > 0);
        XCTAssertTrue([place isKindOfClass:[GKPlaceAutocomplete class]]);

        GKPlaceDetailsQuery *query = [GKPlaceDetailsQuery query];
        query.key = kGoogleKitKey;
        query.placeId = place.placeId;
        query.language = @"en";
        [query fetchDetails:^(GKPlaceDetails *placeDetails, NSError *error) {

            XCTAssertNil(error);
            XCTAssertNotNil(placeDetails);
            
            [testExpectation fulfill];
        }];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

@end