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

#import "GKPlacesQuery.h"

static NSString *const kGKPlacesQueryNearbySearchURL = @"https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=%@";
static NSString *const kGKPlacesQueryTextSearchURL   = @"https://maps.googleapis.com/maps/api/place/textsearch/json?key=%@";
static NSString *const kGKPlacesQueryRadarSearchURL  = @"https://maps.googleapis.com/maps/api/place/radarsearch/json?key=%@";

@interface GKPlacesQuery ()

@property (nonatomic, copy) GKPlacesQueryCompletionBlock completionHandler;
@property (nonatomic, strong) NSString *baseURL;

@end

@implementation GKPlacesQuery

- (id)init {
    
    self = [super init];
    if (self) {

        self.minprice = -1;
        self.maxprice = -1;
        self.radius = 1000;
        self.rankByDistance = NO;
    }
    return self;
}

#pragma mark - GKQueryProtocol

- (NSURL *)queryURL {

    NSMutableString *url = [NSMutableString stringWithFormat:self.baseURL, self.key];

    if (self.nextPageToken && self.nextPageToken.length > 0) {

        [url appendFormat:@"&pagetoken=%@", self.nextPageToken];
        return [NSURL URLWithString:url];
    }

    if (self.location.latitude != -1) {
        [url appendFormat:@"&location=%f,%f", self.location.latitude, self.location.longitude];
    }
    if (self.rankByDistance) {
        [url appendString:@"&rankby=distance"];
    }
    else {
        [url appendString:@"&rankby=prominence"];

        if (self.radius != 0) {
            [url appendFormat:@"&radius=%@", @(self.radius)];
        }
    }
    if (self.keyword) {
        [url appendFormat:@"&keyword=%@", [self.keyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    if (self.language) {
        [url appendFormat:@"&language=%@", self.language];
    }
    if (self.minprice != -1) {
        [url appendFormat:@"&minprice=%@", @(self.minprice)];
    }
    if (self.maxprice != -1) {
        [url appendFormat:@"&maxprice=%@", @(self.maxprice)];
    }
    if (self.name) {
        [url appendFormat:@"&name=%@", [self.name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    if (self.opennow) {
        [url appendString:@"&opennow=true"];
    }
    if (self.types && self.types.count > 0) {
        [url appendFormat:@"&types=%@", [self.types componentsJoinedByString:@"|"]];
    }

    return [NSURL URLWithString:url];
}

- (void)handleQueryResponse:(NSDictionary *)response error:(NSError *)error {
    
    if (error) {

        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.completionHandler)
                self.completionHandler(nil, nil, error);
        });
        return;
    }
    
    NSString *nextPageToken = [response objectForKey:@"next_page_token"];
    
    NSArray *results = [response objectForKey:@"results"];
    NSMutableArray *places = [NSMutableArray array];

    for (NSDictionary *dictionary in results) {

        [places addObject:[[GKPlace alloc] initWithDictionary:dictionary]];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.completionHandler) {
            self.nextPageToken = self.completionHandler(places, nextPageToken, nil);
            if (self.nextPageToken) {

                [self performSelector:@selector(performQuery) withObject:nil afterDelay:2.0f];
            }
        }
    });
}

#pragma mark - Public methods

- (void)nearbySearch:(GKPlacesQueryCompletionBlock)completionHandler {

    self.nextPageToken = nil;
    self.completionHandler = completionHandler;
    self.baseURL = kGKPlacesQueryNearbySearchURL;

    [self performQuery];
}

- (void)textSearch:(GKPlacesQueryCompletionBlock)completionHandler {

    self.nextPageToken = nil;
    self.completionHandler = completionHandler;
    self.baseURL = kGKPlacesQueryTextSearchURL;
    
    [self performQuery];
}

- (void)radarSearch:(GKPlacesQueryCompletionBlock)completionHandler {

    self.nextPageToken = nil;
    self.completionHandler = completionHandler;
    self.baseURL = kGKPlacesQueryRadarSearchURL;

    [self performQuery];
}

@end