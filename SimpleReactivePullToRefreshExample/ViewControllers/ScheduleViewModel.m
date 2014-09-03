//
// Created by Ian Dundas on 20/08/2014.
// Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa/RACSignal.h>
#import <ReactiveCocoa/ReactiveCocoa/RACSignal+Operations.h>
#import <ReactiveCocoa/ReactiveCocoa/RACSubscriptingAssignmentTrampoline.h>
#import <ReactiveCocoa/ReactiveCocoa/RACCommand.h>
#import "ScheduleViewModel.h"
#import "ScheduleImporter.h"
#import "RACDynamicSignal.h"
#import "RACEvent.h"
#import <libextobjc/EXTScope.h>

@class self;

// private interface:
@interface ScheduleViewModel ()
@property (strong, nonatomic, readwrite) RACCommand *getItemsCommand;
@end

@implementation ScheduleViewModel
-(instancetype)init {
    self = [super init];
    if (!self) return nil;

    @weakify(self);
    self.getItemsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[[ScheduleImporter importProgrammes] logError] catchTo:[RACSignal empty]];
    }];

    RAC(self, model) = [self.getItemsCommand.executionSignals concat];
    return self;
}

@end