//
//  RepoTableViewCell.m
//  gitApiTest
//
//  Created by Andrii Osipchuk on 26.11.2020.
//

#import "RepoTableViewCell.h"

@implementation RepoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setupCellWith:(NSString*)name description:(NSString*)description authorName:(NSString*)author {

    if (![description isKindOfClass:[NSNull class]]) {
        self.desc.text = description;
    };

    self.name.text = name;
    self.authorName.text = author;

    self.mainContainer.layer.cornerRadius = 20;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.bottomContainer.hidden = true;
}


@end
