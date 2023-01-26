//
//  ZignSecSessionResults.swift
//  MobileSdk.iOS.Framework
//
//  Created by Daniel Grech on 24/01/2023.
//

import Foundation

public class ZignSecIdentificationSessionResult : Codable {
    public var id: String
    public var result: ZignSecIdentificationResult?
    public var status: ZignSecIdentificationSessionResultStatus?
    
}
