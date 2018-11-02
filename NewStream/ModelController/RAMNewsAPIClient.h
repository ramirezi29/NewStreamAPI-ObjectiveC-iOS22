//
//  RAMNewsAPIClient.h
//  NewStream
//
//  Created by Ivan Ramirez on 11/1/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RAMNews.h"


NS_ASSUME_NONNULL_BEGIN

@interface RAMNewsAPIClient : NSObject

// MARK: - fetch the objects
// NOTE: - block is what we call clousures in objective C
// NOTE: - Nullable bc sometimes its going to fail
+(void)fetchTopHeadlinesWithBlock:(void(^)(NSArray<RAMNews *> * _Nullable articles))block;

// MARK: - Fetch the images
+(void)fetchImageForUrl:(NSString *)imageUrlString withBlock: (void(^)(UIImage * _Nullable photo))block;

@end

NS_ASSUME_NONNULL_END
