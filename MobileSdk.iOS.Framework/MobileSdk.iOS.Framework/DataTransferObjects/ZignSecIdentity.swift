//
//  ZignSecSessionResults.swift
//  MobileSdk.iOS.Framework
//
//  Created by Daniel Grech on 24/01/2023.
//

import Foundation

public class ZignSecIdentity : Codable {
    public var countryCode: String?
    public var firstName: String?
    public var lastName: String?
    public var fullName: String?
    public var personalNumber: String?
    public var dateOfBirth: String?
    public var gender: String?
    public var identificationDate: String?
}
