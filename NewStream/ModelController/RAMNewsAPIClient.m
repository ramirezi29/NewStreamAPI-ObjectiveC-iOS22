//
//  RAMNewsAPIClient.m
//  NewStream
//
//  Created by Ivan Ramirez on 11/1/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

#import "RAMNewsAPIClient.h"
#import <UIKit/UIKit.h>
@implementation RAMNewsAPIClient


// GOAL: https://newsapi.org/v2/top-headlines?country=us&apiKey=48dceec25e1d477895ff41d3ef444161

+(NSString *)baseUrlString {
    return @"https://newsapi.org/v2/top-headlines";
}

+ (void)fetchTopHeadlinesWithBlock:(void (^)(NSArray * _Nullable))block
{
    // Step 1: Construct our URL
    NSURL *baseurl = [[NSURL alloc] initWithString: [RAMNewsAPIClient baseUrlString]];
    
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:baseurl resolvingAgainstBaseURL:YES];
    
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:@"us"];
    
    // NOTE: - Get this from our custom plist
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"apiKey" value: [RAMNewsAPIClient apiKey]];
    
    // NOTE: - init a new NSArray
    
    [components setQueryItems: [[NSArray alloc]initWithObjects:countryQuery, apiKeyQuery, nil]];
    
    NSURL *finalURL = [components URL];
    
    //TEST Print
    NSLog(@"%@", [finalURL absoluteString]);
    
    // Step 2: DataTask, Seralize Objects, Resume
    
    // NOTE: - the 'response' needs to be printe dout to help
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error in %s, %@, %@", __PRETTY_FUNCTION__, error, error.localizedDescription);
            block(nil);
            return;
        }
        //Print Test
        NSLog(@"%@", response);
        
        if (!data){
            NSLog(@"No DATA AVALIABLE");
            block(nil);
            return;
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        
        
        NSArray<NSDictionary *> *articlesDictionary = jsonDictionary[@"articles"];
        
        NSMutableArray *articles = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dictionary in articlesDictionary){
            RAMNews *news = [[RAMNews alloc] initWithDictionary:dictionary];
            [articles addObject:news];
        }
        block(articles);
    }]resume];
}

+ (void)fetchImageForUrl:(NSString *)imageUrlString withBlock:(void (^)(UIImage * _Nullable))block
{
    // Step 1: Construct the URL
    NSURL *imageUrl = [[NSURL alloc] initWithString:imageUrlString];
    
    //Test Print
    NSLog(@"%@", imageUrl);
    
    // Step 2: Data Task, resume
    [[[NSURLSession sharedSession] dataTaskWithURL:imageUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error in %s, %@, %@", __PRETTY_FUNCTION__, error, error.localizedDescription);
            block(nil);
            return;
        }
        //Print Test
        NSLog(@"%@", response);
        
        if (!data){
            NSLog(@"No DATA AVALIABLE");
            block(nil);
            return;
        }
        UIImage *photo = [[UIImage alloc] initWithData:data];
        block(photo);
        return;
        
    }]resume];
    
}

+(NSString *)apiKey {
    static NSString *apiKey = nil;
    static dispatch_once_t onceToken;
    // NOTE: - the address were the at token is at, go to that spot and run taht code once
    dispatch_once(&onceToken, ^ {
        // NOTE: - look in this directory
        NSURL *apiKeysURL = [[NSBundle mainBundle] URLForResource:@"ApiKey" withExtension:@"plist"];
        
        // NOTE: - Every thing in Obj C is force unwrapped
        if (!apiKeysURL) {
            NSLog(@"ERROR! APIKEY NOT FOUND");
            return;
        }
        // NOTE: - if it does exists do the following
        NSDictionary *apiKeys = [[NSDictionary alloc] initWithContentsOfURL:apiKeysURL];
        // NOTE: - Turns your plist in to a dictioanry
        apiKey = apiKeys[@"NewsApiKey"];
    });
    return apiKey;
}
@end
