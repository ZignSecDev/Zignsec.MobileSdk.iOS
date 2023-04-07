//
//  FaceSDK.h
//  FaceSDK
//
//  Created by Pavel Kondrashkov on 5/19/19.
//  Copyright © 2019 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>

// :MARK: Common
#import <FaceSDK/RFSFaceSDK.h>
#import <FaceSDK/RFSURLRequestInterceptingDelegate.h>
#import <FaceSDK/RFSImage.h>
#import <FaceSDK/RFSImageType.h>
#import <FaceSDK/RFSPoint.h>
#import <FaceSDK/RFSOverriding.h>
#import <FaceSDK/RFSDeprecated.h>

// :MARK: Liveness
#import <FaceSDK/RFSLivenessConfiguration.h>
#import <FaceSDK/RFSLivenessResponse.h>

// :MARK: FaceCapture
#import <FaceSDK/RFSFaceCaptureConfiguration.h>
#import <FaceSDK/RFSFaceCaptureResponse.h>

// :MARK: MatchFaces
#import <FaceSDK/RFSMatchFacesRequest.h>
#import <FaceSDK/RFSMatchFacesResponse.h>
#import <FaceSDK/RFSMatchFacesImage.h>
#import <FaceSDK/RFSMatchFacesDetection.h>
#import <FaceSDK/RFSMatchFacesDetectionFace.h>
#import <FaceSDK/RFSMatchFacesComparedFace.h>
#import <FaceSDK/RFSMatchFacesComparedFacesPair.h>
#import <FaceSDK/RFSMatchFacesSimilarityThresholdSplit.h>

// :MARK: UI
#import <FaceSDK/RFSPassthroughView.h>
#import <FaceSDK/RFSLivenessContentView.h>
#import <FaceSDK/RFSLivenessRetryContentView.h>
#import <FaceSDK/RFSLivenessProcessingContentView.h>
#import <FaceSDK/RFSFaceCaptureContentView.h>
#import <FaceSDK/RFSCameraToolbarView.h>
#import <FaceSDK/RFSHintView.h>
