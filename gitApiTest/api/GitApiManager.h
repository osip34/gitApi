//
//  GitApiManager.h
//  gitApiTest
//
//  Created by Andrii Osipchuk on 24.11.2020.
//

#import <Foundation/Foundation.h>
#import "RepoDetails.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ReposResultsDelegate
    - (void)reposFetched:(NSMutableArray<RepoDetails*>*) repos;
@end

@interface GitApiManager : NSObject

@property (weak) id <ReposResultsDelegate> delegate;

- (void)getReposWithPageNumber:(int) page;

@end

NS_ASSUME_NONNULL_END
