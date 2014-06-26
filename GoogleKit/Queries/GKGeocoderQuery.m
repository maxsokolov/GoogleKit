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

#import "GKGeocoderQuery.h"

static NSString *const kGKGeocoderURL = @"https://maps.googleapis.com/maps/api/geocode/json?sensor=%@&key=%@";

@interface GKGeocoderQuery ()

@property (nonatomic, assign, getter = isReverseGeocoding) BOOL reverseGeocoding;

@end

@implementation GKGeocoderQuery

#pragma mark - GKQueryProtocol

- (NSURL *)queryURL {

    NSMutableString *url = [NSMutableString stringWithFormat:kGKGeocoderURL, self.sensor ? @"true" : @"false", self.key];
    
    if (self.isReverseGeocoding) {

        if (self.location.latitude != -1) {
            [url appendFormat:@"&latlng=%f,%f", self.location.latitude, self.location.longitude];
        }
    }
    else {
        
        if (self.address) {
            [url appendFormat:@"&address=%@", self.address];
        }
    }

    if (self.language) {
        [url appendFormat:@"&language=%@", self.language];
    }
    if (self.components ) {
        [url appendFormat:@"&components=%@", self.components];
    }
    
    return [NSURL URLWithString:url];
}

- (void)handleQueryError:(NSDictionary *)response error:(NSError *)error {

    if (self.completionHandler)
        self.completionHandler(response, error);
}

- (void)handleQueryResponse:(NSDictionary *)response {
    
    NSArray *results = [response objectForKey:@"results"];
    NSMutableArray *places = [NSMutableArray array];
    
    for (NSDictionary *dictionary in results) {

        [places addObject:[[GKPlaceDetails alloc] initWithDictionary:dictionary]];
    }
    
    if (self.completionHandler)
        self.completionHandler(places, nil);
}

#pragma mark - Public methods

- (void)lookupLocation:(GKQueryCompletionBlock)completionHandler {
    
    [self cancelQuery];

    self.reverseGeocoding = YES;
    self.completionHandler = completionHandler;

    [self performQuery];
}

- (void)lookupAddress:(GKQueryCompletionBlock)completionHandler {
    
    [self cancelQuery];
    
    self.reverseGeocoding = NO;
    self.completionHandler = completionHandler;

    [self performQuery];
}

@end