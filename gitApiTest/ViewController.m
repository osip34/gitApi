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
#import "RepoDetails.h"

@interface ViewController ()

@property NSMutableArray<RepoDetails*>* records;
@property int pageSize;
@property UIImageView* avatar;
@property GitApiManager* gitManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.gitManager = [[GitApiManager alloc]init] ;
    self.gitManager.delegate = self;

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
    let pageNumber = self.records.count/self.pageSize + 1;
    [self.gitManager getReposWithPageNumber:pageNumber];
};

- (void)reposFetched:(NSMutableArray<RepoDetails*>*) repos {
    if (self.records.count == 0) {
        self.records = repos;
    } else {
        [self.records addObjectsFromArray:repos];
    };
        [self.tableView reloadData];
        self.tableView.tableFooterView = nil;
}

- (void)authorImageFetched:(NSData *)imageData {
    let image = [[UIImage alloc]initWithData:imageData];
    self.avatar.image = image;
};

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (self.records.count == 0) { return [[UITableViewCell alloc]init]; }
    RepoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cat" forIndexPath:indexPath];
    let record = self.records[indexPath.row];
    [cell setupCellWith:record.name description:record.details authorName:record.author];
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

    self.avatar = cell.authorImage;
    [self.gitManager getImageWithImageUrl:self.records[indexPath.row].authorImageURL];
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
