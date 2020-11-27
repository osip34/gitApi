//
//  GitApiManager.m
//  gitApiTest
//
//  Created by Andrii Osipchuk on 24.11.2020.
//

#import "GitApiManager.h"

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
            RepoDetails* repo = [[RepoDetails alloc] initWithName:item[@"name"] author:item[@"full_name"] details:item[@"description"] identifier:item[@"id"]];
            [repos addObject:repo];
        }

        [self->_delegate reposFetched:repos];
        NSLog(@"some");
    }];
    [task resume];
};

@end
