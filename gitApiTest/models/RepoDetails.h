//
//  RepoDetails.h
//  gitApiTest
//
//  Created by Andrii Osipchuk on 24.11.2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RepoDetails : NSObject

@property NSString *name;
@property NSString *author;
@property NSString *authorImageURL;
@property NSData *authorImage;
@property NSString *details;
@property int identifier;

- (instancetype)initWithName:(NSString *)name
                      author:(NSString *)author
              authorImageURL:(NSString *)authorImageURL
                     details:(NSString *) details
                  identifier:(int) identifier;

@end

NS_ASSUME_NONNULL_END
