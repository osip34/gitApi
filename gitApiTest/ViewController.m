//
//  ViewController.m
//  gitApiTest
//
//  Created by Andrii Osipchuk on 24.11.2020.
//

#define let __auto_type const
#define var __auto_type

#import "ViewController.h"
#import "GitApiManager.h"
#import "RepoTableViewCell.h"

@interface ViewController ()

@property NSMutableArray<RepoDetails*>* records;
@property int pageSize;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.pageSize = 20;
    [self setupTableView];
    [self getRecords];
}

- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UINib* nib = [UINib nibWithNibName:NSStringFromClass([RepoTableViewCell class]) bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cat"];
};

- (void)getRecords {
    let gitManager = [[GitApiManager alloc]init] ;
    gitManager.delegate = self;
    let pageNumber = self.records.count/self.pageSize + 1;
    [gitManager getReposWithPageNumber:pageNumber];
};

- (void)reposFetched:(NSMutableArray<RepoDetails*>*) repos {
    dispatch_async(dispatch_get_main_queue(), ^{
    if (self.records.count == 0) {
        self.records = repos;
    } else {
        [self.records addObjectsFromArray:repos];
    };
        [self.tableView reloadData];
        self.tableView.tableFooterView = nil;
    });
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (self.records.count == 0) { return [[UITableViewCell alloc]init]; }
    RepoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cat" forIndexPath:indexPath];
    [cell setupCellWith:self.records[indexPath.row].name description:self.records[indexPath.row].author];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _records.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RepoTableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.bottomContainer.hidden = !cell.bottomContainer.hidden;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
};

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == (self.records.count - 1)) {
        [self showLoadingFooter];
        [self getRecords];
    };
}

- (void)showLoadingFooter {
    let currentFooter = self.tableView.tableFooterView;
    if (currentFooter == nil) {
        let footer = [self loadingTableViewFooter];
        self.tableView.tableFooterView = footer;
    };
};

- (UIView*)loadingTableViewFooter {
    let spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    spinner.color = UIColor.grayColor;
    [spinner startAnimating];

    spinner.frame = CGRectMake(0.0, 0.0, self.tableView.bounds.size.width, 44.0);
    return spinner;
}

@end
