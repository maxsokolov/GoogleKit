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

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define GK_ERROR_DOMAIN @"com.googlekit.errordomain"

typedef NS_ENUM(NSInteger, GKQueryErrorCode) {

    kGKQueryErrorQueryCancelled = 1,
    kGKQueryErrorInternal
};

typedef void (^GKQueryCompletionBlock)(id results, NSError *error);

@protocol GKQueryProtocol <NSObject>
@required
- (NSURL *)queryURL;
- (void)handleQueryResponse:(NSDictionary *)response error:(NSError *)error;
@end

@interface GKQuery : NSObject <GKQueryProtocol>

@property (nonatomic, copy) GKQueryCompletionBlock completionHandler;
@property (nonatomic, strong) NSString *key;

/*
 * Description
 * @see https://developers.google.com/maps/faq#languagesupport
 */
@property (nonatomic, strong) NSString *language;

/**
 * Description
 * @see maps api for business https://developers.google.com/maps/documentation/business/webservices/
 */
@property (nonatomic, strong) NSString *clientId;
@property (nonatomic, strong) NSString *signature;

+ (instancetype)query;
- (void)performQuery;
- (void)cancelQuery;

+ (void)provideAPIKey:(NSString *)APIKey;

// debug
+ (void)loggingEnabled:(BOOL)enabled;

@end