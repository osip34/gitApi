//
//  RepoDetails.m
//  gitApiTest
//
//  Created by Andrii Osipchuk on 24.11.2020.
//

#import "RepoDetails.h"

@implementation RepoDetails

- (instancetype) initWithName:(NSString *)name author:(NSString *)author authorImageURL:(nonnull NSString *)authorImageURL details:(NSString *)details identifier:(int)identifier {
    self = [super init];
    self.name = name;
    self.author = author;
    self.authorImageURL = authorImageURL;
    self.details = details;
    self.identifier = identifier;
    return self;
}

@end
