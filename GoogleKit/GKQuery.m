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

static BOOL _logging;
static NSString *_APIKey = @"default";

@interface GKQuery ()

@property (nonatomic, strong) NSURLSessionDataTask *sessionTask;

@end

@implementation GKQuery

+ (instancetype)query {

    return [self new];
}

- (void)performQuery {

    NSURL *url = [self queryURL];
    if (!url) {

        [self handleQueryResponse:nil error:[NSError errorWithDomain:GK_ERROR_DOMAIN code:kGKQueryErrorInternal userInfo:@{ NSLocalizedDescriptionKey: @"bad url" }]];
        return;
    }
    
    if (_logging) {
        NSLog(@"GOOGLE KIT REQUEST URL: %@\n\n", url);
    }

    // performs in background thread
    self.sessionTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        if (error) {
            
            if (_logging) {
                NSLog(@"GOOGLE KIT CONNECTION ERROR: %@\n\n", error);
            }

            [self handleQueryResponse:nil error:error];
            return;
        }

        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];

        if (jsonError) {
            
            if (_logging) {
                NSLog(@"GOOGLE KIT PARSING ERROR: %@\n\n", error);
            }

            [self handleQueryResponse:nil error:jsonError];
            return;
        }
        
        if (_logging) {
            NSLog(@"GOOGLE KIT RESPONSE: %@\n\n", json);
        }

        if ([[json objectForKey:@"status"] isEqualToString:@"OK"] ||
            [[json objectForKey:@"status"] isEqualToString:@"ZERO_RESULTS"]) {

            [self handleQueryResponse:json error:nil];
            return;
        }

        // OVER_QUERY_LIMIT, REQUEST_DENIED, INVALID_REQUEST etc.
        [self handleQueryResponse:nil error:[NSError errorWithDomain:GK_ERROR_DOMAIN code:kGKQueryErrorInternal userInfo:json]];
    }];

    // start the task
    [self.sessionTask resume];
}

- (void)cancelQuery {

    if (self.sessionTask)
        [self.sessionTask cancel];
}

+ (void)loggingEnabled:(BOOL)enabled {

    _logging = enabled;
}

+ (void)provideAPIKey:(NSString *)APIKey {

    _APIKey = APIKey;
}

#pragma mark - Properties

- (NSString *)key {

    if (!_key)
        return _APIKey;
    return _key;
}

#pragma mark - GKQueryProtocol

- (NSURL *)queryURL {

    return nil;
}

- (void)handleQueryResponse:(NSDictionary *)response error:(NSError *)error {

    return;
}

@end