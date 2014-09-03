//
// Created by Ian Dundas on 20/08/2014.
// Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

// http://www.bbc.co.uk/radio4/programmes/schedules/fm/today.json
@interface ScheduleImporter : NSObject
+ (RACSignal *)importProgrammes;
@end