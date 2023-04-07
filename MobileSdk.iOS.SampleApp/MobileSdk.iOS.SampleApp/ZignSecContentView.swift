//
//  ZignSecIdentificationView.swift
//  MobileSdk.iOS.SampleApp
//
//  Created by Daniel Grech on 07/04/2023.
//

import SwiftUI
import MobileSdk_iOS_Framework

struct ZignSecContentView: View {

    @State private var selection: String? = nil
    @State private var resultsView: ZignSecIdentificationResultsView = ZignSecIdentificationResultsView()
    
    var environment: ZignSecEnvironment
    var sessionId: String
    var accessToken: String
    var completion: ZignSecIdentificationActivityCompletion
    public typealias ZignSecIdentificationActivityCompletion = ((_ result:ZignSecIdentificationSessionResult?,_ error: String?) -> Void)
    
    public init(environment: ZignSecEnvironment, sessionId: String, accessToken: String, completion: @escaping ZignSecIdentificationActivityCompletion) {
        self.sessionId = sessionId
        self.accessToken = accessToken
        self.environment = environment
        self.completion = completion
    }
    
    private func create_new_session() {
        // Only for demo purposes, session id and access token should be fetched from your backend, without exposing your subscription key
        
    }

    var body: some View {
        NavigationView {
            VStack {
                
                NavigationLink(destination: IdentificationActivityView(environment: self.environment, sessionId: self.sessionId, accessToken: self.accessToken, completion: {result, error in
                    self.resultsView.result = result
                    self.resultsView.error = error
                    self.selection = "results"
                    self.completion(result, error)
                }), tag: "identification", selection: $selection) { EmptyView() }
                
                NavigationLink(destination: self.resultsView, tag: "results", selection: $selection) { EmptyView() }

                Button("Tap to start Identification") {
                    create_new_session()
                    self.selection = "identification"
                }
            }
            .navigationTitle("ZignSec Sample App")
        }
    }
}
