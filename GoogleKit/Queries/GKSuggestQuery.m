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

#import "GKSuggestQuery.h"

static NSString *const kGoogleKitSuggestqueriesURL = @"http://suggestqueries.google.com/complete/search?client=firefox&q=%@";

@implementation GKSuggestQuery

- (NSURL *)queryURL {
    
    NSMutableString *url = [NSMutableString stringWithString:kGoogleKitSuggestqueriesURL];
    if (self.input) {
        [url appendFormat:@"%@", [self.input stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    
    return [NSURL URLWithString:url];
}

- (void)handleQueryError:(NSError *)error {

    if (self.completionHandler)
        self.completionHandler(nil, error);
}

- (void)handleQueryResponse:(NSDictionary *)response {
    
    NSMutableArray *suggestions = [NSMutableArray array];
    
    for (id item in response) {
        
        if ([item isKindOfClass:[NSArray class]]) {
    
            for (id suggestion in item) {
                if ([suggestion isKindOfClass:[NSString class]]) {
                    
                    [suggestions addObject:[NSString stringWithFormat:@"%@", suggestion]];
                }
                else if ([suggestion isKindOfClass:[NSArray class]]) {
                    
                    if ([(NSArray *)suggestion count] > 0) {
                        
                        [suggestions addObject:[NSString stringWithFormat:@"%@", [(NSArray *)suggestion objectAtIndex:0]]];
                    }
                }
            }
            
            break;
        }
    }

    if (self.completionHandler)
        self.completionHandler(suggestions, nil);
}

#pragma mark - Public methods

- (void)fetchSuggestions:(GKQueryCompletionBlock)completionHandler {
    
    [self cancelQuery];

    self.completionHandler = completionHandler;
    
    [self performQuery];
}

@end