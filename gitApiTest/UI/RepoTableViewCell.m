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

-(void)setupCellWith:(NSString*)name description:(NSString*)description {

    self.name.text = name;
    self.desc.text = description;

    self.mainContainer.layer.cornerRadius = 20;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
