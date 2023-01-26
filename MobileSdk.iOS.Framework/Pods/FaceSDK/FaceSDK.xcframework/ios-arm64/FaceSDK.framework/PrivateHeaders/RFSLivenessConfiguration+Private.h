//
//  RFSLivenessConfiguration+Private.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 24/12/2021.
//  Copyright © 2021 Regula. All rights reserved.
//

#import <FaceSDK/RFSLivenessConfiguration.h>

NS_ASSUME_NONNULL_BEGIN

@interface RFSLivenessConfiguration ()

/// Defines whether the camera captures the depth data during liveness processing and sends it to the service. Defaults to `false`.
@property(readonly, nonatomic, assign, getter=isDepthDataCollectionEnabled) BOOL depthDataCollectionEnabled;

@end

@interface RFSLivenessConfigurationBuilder ()

/// @see RFSLivenessConfiguration.depthDataCollectionEnabled.
@property(readwrite, nonatomic, assign, getter=isDepthDataCollectionEnabled) BOOL depthDataCollectionEnabled;

@end

NS_ASSUME_NONNULL_END
