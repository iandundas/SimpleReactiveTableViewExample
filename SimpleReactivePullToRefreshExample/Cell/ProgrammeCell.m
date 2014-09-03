//
// Created by Ian Dundas on 23/08/2014.
// Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa/RACSubscriptingAssignmentTrampoline.h>
#import <ReactiveCocoa/ReactiveCocoa/NSObject+RACPropertySubscribing.h>
#import <ReactiveCocoa/ReactiveCocoa/RACSignal+Operations.h>
#import <ReactiveCocoa/ReactiveCocoa/RACSubscriber.h>
#import <ReactiveCocoa/ReactiveCocoa/RACScheduler.h>
#import "ProgrammeCell.h"
#import "Programme.h"
#import "RACStream.h"

// private interface:
@interface ProgrammeCell ()
@end

@implementation ProgrammeCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];

    RAC(self.textLabel, text)= [RACObserve(self, programmeModel.name) ignore:nil];
    RAC(self.detailTextLabel, text)= [RACObserve(self, programmeModel.type) ignore:nil];

    return self;
}

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (!self) return nil;
//
//    // Configure self
//    self.backgroundColor = [UIColor darkGrayColor];
////
////    // Configure subivews
////    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
////    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
////    [self.contentView addSubview:imageView];
////    self.imageView = imageView;
//
//    RAC(self.imageView, image) = [[[RACObserve(self, photoModel.thumbnailData) ignore:nil] map:^id(id value) {
//        return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//            [value af_decompressedImageFromJPEGDataWithCallback:
//                ^(UIImage *decompressedImage) {
//                    [subscriber sendNext:decompressedImage];
//                    [subscriber sendCompleted];
//                }];
//            return nil;
//        }] subscribeOn:[RACScheduler scheduler]];
//    }] switchToLatest];
//
//    return self;
//}

@end