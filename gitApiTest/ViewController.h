//
//  ViewController.h
//  gitApiTest
//
//  Created by Andrii Osipchuk on 24.11.2020.
//

#import <UIKit/UIKit.h>
#import "GitApiManager.h"

@interface ViewController : UIViewController<ReposResultsDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

