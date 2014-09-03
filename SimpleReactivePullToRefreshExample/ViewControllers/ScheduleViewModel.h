//
// Created by Ian Dundas on 20/08/2014.
// Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACCommand;
@interface ScheduleViewModel : NSObject
@property (nonatomic, readonly, strong) NSArray *model;

@property (strong, nonatomic, readonly) RACCommand *getItemsCommand;
@end