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
@property NSString *details;
@property int identifier;

- (instancetype)initWithName:(NSString *)name
                      author:(NSString *)author
                     details:(NSString *) details
                  identifier:(int) identifier;

@end

NS_ASSUME_NONNULL_END
