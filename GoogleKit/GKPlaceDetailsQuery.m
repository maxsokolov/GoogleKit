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

static NSString *const kGoogleKitPlaceDetailsURL = @"https://maps.googleapis.com/maps/api/place/details/json?key=%@&placeid=%@";

@implementation GKPlaceDetailsQuery

#pragma mark - GKQueryProtocol

- (NSURL *)queryURL {

    NSMutableString *url = [NSMutableString stringWithFormat:kGoogleKitPlaceDetailsURL, self.key, self.placeId];
    if (self.extensions) {
        [url appendFormat:@"&extensions=%@", self.extensions];
    }
    if (self.language) {
        [url appendFormat:@"&language=%@", self.language];
    }

    return [NSURL URLWithString:url];
}

- (void)handleQueryResponse:(NSDictionary *)response error:(NSError *)error {
    
    if (error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.completionHandler)
                self.completionHandler(nil, error);
        });
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.completionHandler)
            self.completionHandler([[GKPlaceDetails alloc] initWithDictionary:[response objectForKey:@"result"]], nil);
    });
}

#pragma mark - Public methods

- (void)fetchDetails:(GKPlaceDetailsQueryCompletionBlock)completionHandler {

    self.completionHandler = completionHandler;
    [self performQuery];
}

@end