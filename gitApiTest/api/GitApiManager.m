//
//  GitApiManager.m
//  gitApiTest
//
//  Created by Andrii Osipchuk on 24.11.2020.
//

#import "GitApiManager.h"
#import <UIKit/UIKit.h>

@implementation GitApiManager

- (void)getReposWithPageNumber:(int)page {
    NSString* urlString = [NSString stringWithFormat:@"https://api.github.com/search/repositories?q=language:swift&sort=stars&per_page=20&page=%d",page];
    NSURL* url = [[NSURL alloc]initWithString:urlString];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDataTask* task = [NSURLSession.sharedSession
                                  dataTaskWithRequest:request
                                  completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError* err = nil;

        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        NSArray* items = dict[@"items"];
        NSMutableArray<RepoDetails *>* repos = [NSMutableArray arrayWithCapacity:10];

        for (NSDictionary* item in items) {
            NSDictionary* owner = item[@"owner"];
            RepoDetails* repo = [[RepoDetails alloc] initWithName:item[@"name"] author:owner[@"login"] authorImageURL:owner[@"avatar_url"] details:item[@"description"] identifier:item[@"id"]];
            [repos addObject:repo];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate reposFetched:repos];
        });
    }];
    [task resume];
};

- (void)getImageWithImageUrl:(NSString*)imageUrlString{

    [self simpleRequestWithString:imageUrlString completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate authorImageFetched:data];
        });
    }];

//    NSString* urlString = @"https://avatars2.githubusercontent.com/u/484656?v=4";
//    NSURL* url = [[NSURL alloc]initWithString:urlString];
//    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url];
//    NSURLSessionDataTask* task = [NSURLSession.sharedSession
//                                  dataTaskWithRequest:request
//                                  completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.delegate authorImageFetched:data];
//        });
//
//    }];
//    [task resume];
};

- (void)simpleRequestWithString:(NSString*)urlString completion:(void(^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)) completion {
    NSURL* url = [[NSURL alloc]initWithString:urlString];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDataTask* task = [NSURLSession.sharedSession
                                  dataTaskWithRequest:request
                                  completionHandler:completion];
    [task resume];
};

@end
