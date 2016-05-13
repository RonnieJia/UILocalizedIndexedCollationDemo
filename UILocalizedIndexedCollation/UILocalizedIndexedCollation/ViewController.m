//
//  ViewController.m
//  UILocalizedIndexedCollation
//
//  Created by jia on 16/5/5.
//  Copyright © 2016年 RJ. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

#define RJColor(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]
#define kBar_tintColor          RJColor(0, 190, 12, 1)
#define kMainBackgroundColor    RJColor(248, 248, 248, 1)

@interface ViewController ()<UISearchBarDelegate>

@property (nonatomic,strong) NSMutableArray *sectionArray;
@property (nonatomic, strong) NSMutableArray *sectionTitlesArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
    [self setupData];
    
}

- (void)setupSubviews {
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:[[UITableViewController alloc] init]];
    searchController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95];
    
    UISearchBar *searchBar = searchController.searchBar;
    searchBar.barStyle = UIBarStyleDefault;
    searchBar.translucent = YES;
    searchBar.barTintColor = kMainBackgroundColor;
    searchBar.tintColor = kBar_tintColor;
    
    searchBar.layer.borderColor = [UIColor redColor].CGColor;
    searchBar.showsBookmarkButton = YES;
    [searchBar setImage:[UIImage imageNamed:@"VoiceSearchStartBtn"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
    searchBar.delegate = self;
    CGRect rect = searchBar.frame;
    rect.size.height = 44;
    searchBar.frame = rect;
    self.tableView.tableHeaderView = searchBar;
    
    self.tableView.rowHeight = 45.f;
    self.tableView.sectionIndexColor = [UIColor lightGrayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionHeaderHeight = 25.f;
}

- (void)setupData {
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    
    // create a temp sectionArray
    NSInteger numberOfSection = [[collation sectionTitles] count];
    NSMutableArray *newSectionArray = [NSMutableArray array];
    for (int i = 0; i<numberOfSection; i++) {
        [newSectionArray addObject:[NSMutableArray array]];
    }
    
    // insert Person info into newSectionArray
    for (Person *p in [Person createPersonsWithCount:30]) {
        NSInteger sectionIndex = [collation sectionForObject:p collationStringSelector:@selector(name)];
        [newSectionArray[sectionIndex] addObject:p];
    }
    
    for (int i = 0; i<numberOfSection; i++) {
        NSMutableArray *personsForSection = newSectionArray[i];
        NSArray *sortedPersonsForSection = [collation sortedArrayFromArray:personsForSection collationStringSelector:@selector(name)];
        newSectionArray[i] = sortedPersonsForSection;
    }
    
    NSMutableArray *temp = [NSMutableArray array];
    
    [newSectionArray enumerateObjectsUsingBlock:^(NSArray *arr, NSUInteger idx, BOOL * _Nonnull stop) {
        if (arr.count <= 0) {
            [temp addObject:arr];
        } else {
            [self.sectionTitlesArray addObject:[collation sectionTitles][idx]];
        }
    }];
    
    [newSectionArray removeObjectsInArray:temp];
    
    self.sectionArray = newSectionArray;
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionTitlesArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sectionArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentidier = @"ViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentidier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentidier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Person *p = self.sectionArray[indexPath.section][indexPath.row];
    cell.textLabel.text = p.name;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionTitlesArray[section];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionTitlesArray;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - 懒加载
- (NSMutableArray *)sectionArray {
    if (!_sectionArray) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}
- (NSMutableArray *)sectionTitlesArray {
    if (!_sectionTitlesArray) {
        _sectionTitlesArray = [NSMutableArray array];
    }
    return _sectionTitlesArray;
}
@end
