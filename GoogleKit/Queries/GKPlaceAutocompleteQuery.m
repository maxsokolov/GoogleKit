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

#import "GKPlaceAutocompleteQuery.h"

static NSString *const kGoogleKitPlaceAutocompleteURL = @"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&key=%@";

@interface GKPlaceAutocompleteQuery ()

@property (nonatomic, strong) NSCache *cache;

@end

@implementation GKPlaceAutocompleteQuery

- (id)init {
    
    self = [super init];
    if (self) {

        self.cache = [[NSCache alloc] init];        
        self.radius = 10000.0f;
    }
    return self;
}

#pragma mark - Query

- (NSURL *)queryURL {

    NSMutableString *url = [NSMutableString stringWithFormat:kGoogleKitPlaceAutocompleteURL, [self.input stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], self.key];

    if (self.offset != 0) {
        [url appendFormat:@"&offset=%@", @(self.offset)];
    }
    if (self.location.latitude != -1) {
        [url appendFormat:@"&location=%f,%f", self.location.latitude, self.location.longitude];
    }
    if (self.radius != 0) {
        [url appendFormat:@"&radius=%@", @(self.radius)];
    }
    if (self.language) {
        [url appendFormat:@"&language=%@", self.language];
    }
    if (self.types) {
        [url appendFormat:@"&types=%@", [self.types componentsJoinedByString:@"|"]];
    }
    else {
        [url appendString:@"&types=geocode"];
    }
    if (self.components) {
        [url appendFormat:@"&components=%@", [self.components componentsJoinedByString:@"|"]];
    }

    return [NSURL URLWithString:url];
}

- (void)handleQueryError:(NSDictionary *)response error:(NSError *)error {
    
    if (self.completionHandler)
        self.completionHandler(nil, error);
}

- (void)handleQueryResponse:(NSDictionary *)response {

    NSArray *array = [response objectForKey:@"predictions"];

    [self.cache setObject:array forKey:self.input];
    
    NSMutableArray *places = [NSMutableArray array];
    for (NSDictionary *place in array) {
        [places addObject:[[GKPlaceAutocomplete alloc] initWithDictionary:place]];
    }
    
    if (self.completionHandler)
        self.completionHandler(places, nil);
}

#pragma mark - Public methods

- (void)fetchPlaces:(GKQueryCompletionBlock)completionHandler {
    
    self.completionHandler = completionHandler;
    
    if (!self.input || !self.input.length) {
        
        if (self.completionHandler)
            self.completionHandler([NSArray array], nil);
        
        return;
    }

    NSArray *array = [self.cache objectForKey:self.input];
    if (array) {

        if (self.completionHandler)
            self.completionHandler(array, nil);

        return;
    }
    
    [self performQuery];
}

@end