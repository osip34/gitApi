//
//  RepoTableViewCell.h
//  gitApiTest
//
//  Created by Andrii Osipchuk on 26.11.2020.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RepoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *mainContainer;
@property (weak, nonatomic) IBOutlet UIView *topContainer;
@property (weak, nonatomic) IBOutlet UIView *bottomContainer;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UIImageView *authorImage;

-(void)setupCellWith:(NSString*)name description:(NSString*)description;

@end

NS_ASSUME_NONNULL_END
