//
//  RAMNews.m
//  NewStream
//
//  Created by Ivan Ramirez on 11/1/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

#import "RAMNews.h"

@implementation RAMNews

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    // Step 1: Get all the values i need from the dictionary
    NSString *title = dictionary[@"title"];
    
    // NOTE: - Some of the authors are nill
    NSString *author = dictionary[@"author"];
    NSString *imageUrl = dictionary[@"urlToImage"];
    
    // NOTE: - 'source' will return you a dictionary. we want to get to the name property. We double tap into that ditionary and we get what we want by puttin g[][] back to back
    NSString *source = dictionary[@"source"][@"name"];
    NSString *content = dictionary[@"content"];
    
    // MARK: - Check against nill
    if (![title isKindOfClass:[NSString class]] ||
        ![author isKindOfClass:[NSString class]] ||
        ![imageUrl isKindOfClass:[NSString class]] ||
        ![content isKindOfClass:[NSString class]] ||
        ![source isKindOfClass:[NSString class]]){
        return nil;
    }
    
    // Step 2: Actually initalize self and set properties
    self = [super init];
    if (self){
        _title = title;
        _author = author;
        _imageUrl = imageUrl;
        _source = source;
        _content = content;
    }
    return self;
}

@end
