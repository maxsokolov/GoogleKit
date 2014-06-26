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

#import "GKPlaceDetailsQuery.h"

static NSString *const kGoogleKitPlaceDetailsURL = @"https://maps.googleapis.com/maps/api/place/details/json?reference=%@&sensor=%@&key=%@";

@implementation GKPlaceDetailsQuery

#pragma mark - Query

- (NSURL *)queryURL {
    
    NSMutableString *url = [NSMutableString stringWithFormat:kGoogleKitPlaceDetailsURL, self.reference, self.sensor ? @"true" : @"false", self.key];
    if (self.extensions) {
        [url appendFormat:@"&extensions=%@", self.extensions];
    }
    if (self.language) {
        [url appendFormat:@"&language=%@", self.language];
    }

    return [NSURL URLWithString:url];
}

- (void)handleQueryError:(NSDictionary *)response error:(NSError *)error {

    if (self.completionHandler)
        self.completionHandler(nil, error);
}

- (void)handleQueryResponse:(NSDictionary *)response {
    
    //NSDictionary *dictionary = [response objectForKey:@"result"];
    //GKPlaceDetails *placeDetails = [[GKPlaceDetails alloc] initWithDictionary:dictionary];
}

#pragma mark - Public methods

- (void)fetchDetails:(GKQueryCompletionBlock)completionHandler {
    
    self.completionHandler = completionHandler;
    
    if (!self.reference || !self.reference.length) {
        
        if (self.completionHandler)
            self.completionHandler([NSArray array], nil);
        
        return;
    }
    
    [self performQuery];
}

@end