//
//  ZignSecEnvironment.swift
//  MobileSdk.iOS.Framework
//
//  Created by Daniel Grech on 24/01/2023.
//

import Foundation

public enum ZignSecIdentificationSessionResultStatus : String, Codable {
    case created = "Created"
    case readyToStart = "ReadyToStart"
    case pending = "Pending"
    case accepted = "Accepted"
    case declined = "Declined"
    case failed = "Failed"
    case timeout = "Timeout"
    case cancelled = "Cancelled"
}
