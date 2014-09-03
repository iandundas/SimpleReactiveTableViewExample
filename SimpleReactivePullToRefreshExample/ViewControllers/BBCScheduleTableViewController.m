//
// Created by Ian Dundas on 20/08/2014.
// Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa/RACSubscriptingAssignmentTrampoline.h>
#import <ReactiveCocoa/ReactiveCocoa/NSObject+RACPropertySubscribing.h>
#import "BBCScheduleTableViewController.h"
#import "ScheduleViewModel.h"
#import "RACSignal.h"
#import "ProgrammeCell.h"
#import "UIRefreshControl+RACCommandSupport.h"
#import "RACCommand.h"
#import <libextobjc/EXTScope.h>

// private interface:
@interface BBCScheduleTableViewController ()
@property (nonatomic, strong) ScheduleViewModel *viewModel;
@end

static NSString *cellID= @"cellID";
@implementation BBCScheduleTableViewController {
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nil bundle:nil]){
        _viewModel= [ScheduleViewModel new];
    }
    return self;
}
-(void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Radio 4 schedule"];
    
    [self.tableView registerClass:[ProgrammeCell class] forCellReuseIdentifier:cellID];

    self.refreshControl= [[UIRefreshControl alloc] init];
    self.refreshControl.rac_command = self.viewModel.getItemsCommand;

    @weakify(self);
    [RACObserve(self.viewModel, model) subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];

    // trigger initial load:
    // http://stackoverflow.com/questions/23203436/reactivecocoa-mvvm-with-uitableview#comment35810969_23224046
    [self.viewModel.getItemsCommand execute:nil];

    RAC([UIApplication sharedApplication], networkActivityIndicatorVisible) = self.viewModel.getItemsCommand.executing;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.model.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProgrammeCell *cell= [tableView dequeueReusableCellWithIdentifier:cellID];
    [cell setProgrammeModel:self.viewModel.model[(NSUInteger) indexPath.row]];
    return cell;
}



@end