//
//  GitApiManager.h
//  gitApiTest
//
//  Created by Andrii Osipchuk on 24.11.2020.
//

#import <Foundation/Foundation.h>
#import "RepoDetails.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ReposResultsDelegate
    - (void)reposFetched:(NSMutableArray<RepoDetails*>*) repos;
    - (void)authorImageFetched:(NSData*) imageData;
@end

@interface GitApiManager : NSObject

@property (weak) id <ReposResultsDelegate> delegate;

- (void)getReposWithPageNumber:(int) page;
- (void)getImageWithImageUrl:(NSString*)imageUrlString;

@end

NS_ASSUME_NONNULL_END
