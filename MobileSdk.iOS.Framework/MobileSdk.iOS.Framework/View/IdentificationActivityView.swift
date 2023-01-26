//
//  IdentificationActivityView.swift
//  MobileSdk.iOS.Framework
//
//  Created by Daniel Grech on 24/01/2023.
//

import SwiftUI

public struct IdentificationActivityView: UIViewControllerRepresentable {
    public typealias UIViewControllerType = IdentificationActivityViewController
    
    public typealias ZignSecIdentificationActivityCompletion = ((_ result:ZignSecIdentificationSessionResult?,_ error: String?) -> Void)
    var environment: ZignSecEnvironment
    var sessionId: String
    var accessToken: String
    var completion: ZignSecIdentificationActivityCompletion
    
    public init(environment: ZignSecEnvironment, sessionId: String, accessToken: String, completion: @escaping ZignSecIdentificationActivityCompletion) {
        self.sessionId = sessionId
        self.accessToken = accessToken
        self.environment = environment
        self.completion = completion
    }
    
    public func makeUIViewController(context: Context) -> IdentificationActivityViewController {
        
        return IdentificationActivityViewController.makeIdentificationActivityViewController(environment: self.environment,sessionId: self.sessionId, accessToken: self.accessToken, completion: self.completion)
    }
    
    public func updateUIViewController(_ uiViewController: IdentificationActivityViewController, context: Context) {
    }
}
