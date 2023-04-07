//
//  RFSLivenessResponse.h
//  FaceSDK
//
//  Created by Dmitry Smolyakov on 10/21/20.
//  Copyright © 2020 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FaceSDK/RFSMacros.h>

NS_ASSUME_NONNULL_BEGIN

@class UIImage;

/// `RFSLivenessErrorDomain` indicates an error related to the Liveness. For error codes see `RFSLivenessError`.
FOUNDATION_EXPORT NSErrorDomain const RFSLivenessErrorDomain NS_SWIFT_NAME(LivenessErrorDomain);

/// Error codes for the `RFSLivenessResponse` errors.
typedef NS_ERROR_ENUM(RFSLivenessErrorDomain, RFSLivenessErrorCode) {
    /// User cancelled liveness processing.
    RFSLivenessErrorCancelled,
    /// Processing finished by timeout.
    RFSLivenessErrorProcessingTimeout,
    /// Processing failed. Liveness service received the attempt but it failed to pass validation.
    RFSLivenessErrorProcessingFailed,
    /// Liveness API call failed due to networking error or backend internal error.
    RFSLivenessErrorAPICallFailed,
    /// There is no valid license on the service.
    RFSLivenessErrorNoLicense,
} NS_SWIFT_NAME(LivenessError);

/// The status of the Liveness processing.
typedef NS_ENUM(NSUInteger, RFSLivenessStatus) {
    /// The liveness check is passed successfully.
    RFSLivenessStatusPassed,
    /// The liveness check result is unknown.
    RFSLivenessStatusUnknown
} NS_SWIFT_NAME(LivenessStatus);

/// The response from the Liveness module.
NS_SWIFT_NAME(LivenessResponse)
@interface RFSLivenessResponse : NSObject

/// The id of the processing from the liveness service.
/// A string containing a formatted UUID for example E621E1F8-C36C-495A-93FC-0C247A3E6E5F.
/// Allows for matching the responses on the client and the processing on the server if necessary.
@property(readonly, nonatomic, copy, nonnull) NSString *guid;

/// The input image used to determine the liveness.
@property(readonly, nonatomic, strong, nullable) UIImage *image;

/// The status of the Liveness processing.
@property(readonly, nonatomic, assign) RFSLivenessStatus liveness;

/// The error describes a failed liveness check and contains `RFSLivenessError` codes.
/// This error belongs to the `RFSLivenessErrorDomain`.
@property(readonly, nonatomic, strong, nullable) NSError *error;

RFS_EMPTY_INIT_UNAVAILABLE

@end

NS_ASSUME_NONNULL_END
