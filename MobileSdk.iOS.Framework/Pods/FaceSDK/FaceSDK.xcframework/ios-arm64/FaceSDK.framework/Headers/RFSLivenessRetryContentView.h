//
//  RFSLivenessRetryContentView.h
//  FaceSDK
//
//  Created by Dmitry Evglevsky on 13.04.22.
//  Copyright © 2022 Regula. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <FaceSDK/RFSPassthroughView.h>
#import <FaceSDK/RFSOverriding.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(LivenessRetryContentView)
@interface RFSLivenessRetryContentView : RFSPassthroughView <RFSOverriding>

@property (readonly, nonatomic, nullable) UIButton *closeButton;
@property (readonly, nonatomic, nullable) UIButton *retryButton;
@property (readonly, nonatomic, nullable) UILabel *tryAgainStatus;
@property (readonly, nonatomic, nullable) UILabel *checkConditionsLabel;
@property (readonly, nonatomic, nullable) UILabel *conditionsLabel;

#pragma mark - Overridable

/// Setups default constraints. Can be overriden to provide custom layout constraints.
- (void)setupConstraints;

@end

NS_ASSUME_NONNULL_END
