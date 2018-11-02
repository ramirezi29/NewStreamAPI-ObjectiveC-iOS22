//
//  RAMNews.h
//  NewStream
//
//  Created by Ivan Ramirez on 11/1/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RAMNews : NSObject

// MARK: - Properties on the Api

// NOTE: - We could skipp an article if they dont hae a title 
@property(nonatomic, copy, readonly) NSString *title;

// NOTE: - in the JSON some of the authors, image, content
@property(nonatomic, copy, readonly, nullable) NSString *author;
@property(nonatomic, copy, readonly) NSString *source;
@property(nonatomic, copy, readonly, nullable) NSString *imageUrl;
@property(nonatomic, copy, readonly, nullable) NSString *content;

// NOTE: - Were going to skip entering in all the properites above and skip the middle man
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
