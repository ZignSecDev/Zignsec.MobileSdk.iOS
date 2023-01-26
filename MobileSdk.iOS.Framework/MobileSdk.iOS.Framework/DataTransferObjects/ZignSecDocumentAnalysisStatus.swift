//
//  ZignSecEnvironment.swift
//  MobileSdk.iOS.Framework
//
//  Created by Daniel Grech on 24/01/2023.
//

import Foundation

public enum ZignSecDocumentAnalysisStatus : String, Codable {
    case notRequested = "NotRequested"
    case requested = "Requested"
    case pending = "Pending"
    case accepted = "Accepted"
    case declined = "Declined"
    case failed = "Failed"
    case cancelled = "Cancelled"
}
