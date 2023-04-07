//
//  MobileSdk_iOS_SampleAppApp.swift
//  MobileSdk.iOS.SampleApp
//
//  Created by Daniel Grech on 24/01/2023.
//

import SwiftUI
import MobileSdk_iOS_Framework


@main
struct MobileSdk_iOS_SampleAppApp: App {
    var body: some Scene {
        WindowGroup {
            ZignSecContentView(environment: ZignSecEnvironment.test, sessionId: "", accessToken: "", completion: {result, error in
              print(result)
            })
        }
    }
}
