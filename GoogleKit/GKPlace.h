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

#import "GKObject.h"

/*
 Description
 @see https://developers.google.com/places/documentation/search#PlaceSearchPaging
 */
@interface GKPlace : GKObject

@property (nonatomic, strong, readonly) NSString *formattedAddress;
@property (nonatomic, assign, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong, readonly) NSString *icon;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, assign, readonly) CGFloat rating;
@property (nonatomic, strong, readonly) NSString *scope;
@property (nonatomic, strong, readonly) NSArray *types;

@property (nonatomic, assign, readonly) BOOL openNow;
@property (nonatomic, assign, readonly) NSInteger priceLevel;
@property (nonatomic, strong, readonly) NSString *placeId;
@property (nonatomic, strong, readonly) NSString *vicinity;

@end