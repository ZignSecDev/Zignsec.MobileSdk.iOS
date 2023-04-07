//
//  ZignsecIdentificationResultsView.swift
//  MobileSdk.iOS.SampleApp
//
//  Created by Daniel Grech on 07/04/2023.
//

import SwiftUI
import MobileSdk_iOS_Framework

struct ZignSecIdentificationResultsView: View {
    
    public var result: ZignSecIdentificationSessionResult? = nil
    public var error: String? = nil
    
    var body: some View {
        List {
            HStack {
              Text("Overall Status: ")
                if (result?.status != nil){
                    Text(result!.status!.rawValue)
                } else if error != nil{
                    Text("Error. \(error!)")
                } else {
                    Text("N/A")
                }
            }
            
            HStack {
                Text("Document Analysis Status:")
                if (result?.result?.documentAnalysis?.status != nil) {
                    Text(result!.result!.documentAnalysis!.status!.rawValue)
                } else {
                    Text("N/A")
                }
            }
            
            HStack {
                Text("Liveness Analysis Status:")
                if (result?.result?.livenessAnalysis?.status != nil) {
                    Text(result!.result!.livenessAnalysis!.status!.rawValue)
                } else {
                    Text("N/A")
                }
            }
            
            HStack {
                Text("Face Match Analysis Status:")
                if (result?.result?.faceMatchAnalysis?.status != nil) {
                    Text(result!.result!.faceMatchAnalysis!.status!.rawValue)
                } else {
                    Text("N/A")
                }
            }
            
            HStack {
                Text("Full Name:")
                if (result?.result?.identity?.fullName != nil) {
                    Text(result!.result!.identity!.fullName!)
                } else {
                    Text("N/A")
                }
            }
            
            HStack {
                Text("Personal Number:")
                if (result?.result?.identity?.personalNumber != nil) {
                    Text(result!.result!.identity!.personalNumber!)
                } else {
                    Text("N/A")
                }
            }
            
            HStack {
                Text("Date of Birth:")
                if (result?.result?.identity?.dateOfBirth != nil) {
                    Text(result!.result!.identity!.dateOfBirth!)
                } else {
                    Text("N/A")
                }
            }
            
            HStack {
                Text("Country Code:")
                if (result?.result?.identity?.countryCode != nil) {
                    Text(result!.result!.identity!.countryCode!)
                } else {
                    Text("N/A")
                }
            }
            
            HStack {
                Text("Gender:")
                if (result?.result?.identity?.gender != nil) {
                    Text(result!.result!.identity!.gender!)
                } else {
                    Text("N/A")
                }
            }
        }
    }
}
