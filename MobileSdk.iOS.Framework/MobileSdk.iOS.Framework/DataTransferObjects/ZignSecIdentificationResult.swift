//
//  ZignSecSessionResults.swift
//  MobileSdk.iOS.Framework
//
//  Created by Daniel Grech on 24/01/2023.
//

import Foundation

public class ZignSecIdentificationResult : Codable {
    public var identity: ZignSecIdentity?
    public var documentAnalysis: ZignSecDocumentAnalysis?
    public var livenessAnalysis: ZignSecLivenessAnalysis?
    public var faceMatchAnalysis: ZignSecFaceMatchAnalysis?
}
