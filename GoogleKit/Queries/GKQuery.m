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

#import "GKQuery.h"

@interface GKQuery ()

@property (nonatomic, strong) NSOperationQueue *backgroundQueue;

@end

@implementation GKQuery

+ (instancetype)query {

    return [[self alloc] init];
}

- (id)init {

    self = [super init];
    if (self) {

        self.backgroundQueue = [[NSOperationQueue alloc] init];
        self.sensor = YES;
    }
    return self;
}

- (void)performQuery {

    NSURL *url = [self queryURL];
    if (!url) {

        [self handleQueryError:nil error:[NSError errorWithDomain:@"com.googlekit" code:0 userInfo:@{ NSLocalizedDescriptionKey: @"bad url" }]];
        return;
    }

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    [NSURLConnection sendAsynchronousRequest:request queue:self.backgroundQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        if (connectionError) {

            dispatch_async(dispatch_get_main_queue(), ^{
                [self handleQueryError:nil error:connectionError];
            });

            return;
        }

        NSError *error = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];

        if (error) {

            dispatch_async(dispatch_get_main_queue(), ^{
                [self handleQueryError:nil error:error];
            });

            return;
        }

        if ([[json objectForKey:@"status"] isEqualToString:@"OK"] ||
            [[json objectForKey:@"status"] isEqualToString:@"ZERO_RESULTS"]) {

            dispatch_async(dispatch_get_main_queue(), ^{
                [self handleQueryResponse:json];
            });

            return;
        }

        // OVER_QUERY_LIMIT, REQUEST_DENIED, INVALID_REQUEST etc.
        dispatch_async(dispatch_get_main_queue(), ^{
            [self handleQueryError:json error:[NSError errorWithDomain:@"com.googlekit" code:0 userInfo:@{ NSLocalizedDescriptionKey: [json objectForKey:@"status"] }]];
        });
    }];
}

- (void)cancelQuery {

    [self.backgroundQueue cancelAllOperations];
}

#pragma mark - GKQueryProtocol

- (NSURL *)queryURL {

    return nil;
}

- (void)handleQueryError:(NSDictionary *)response error:(NSError *)error {

    return;
}

- (void)handleQueryResponse:(NSDictionary *)response {

    return;
}

@end