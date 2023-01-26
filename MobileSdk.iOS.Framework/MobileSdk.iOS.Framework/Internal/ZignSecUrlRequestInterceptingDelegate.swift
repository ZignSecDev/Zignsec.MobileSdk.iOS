//
//  ZignSecUrlRequestInterceptingDelegate.swift
//  MobileSdk.iOS.Framework
//
//  Created by Daniel Grech on 24/01/2023.
//


import DocumentReader
import FaceSDK

public class ZignSecUrlRequestInterceptingDelegate: NSObject, DocReader.URLRequestInterceptingDelegate, URLRequestInterceptingDelegate {
    
    var accessToken: String
    var sessionId: String
    
    init(accessToken: String, sessionId: String){
        self.accessToken = accessToken
        self.sessionId = sessionId
    }
    
    public func interceptorPrepare(_ request: URLRequest) -> URLRequest? {
        var request = request
        request.addValue("Bearer " + self.accessToken,
            forHTTPHeaderField: "Authorization")
        request.addValue(self.sessionId,
            forHTTPHeaderField: "x-zignsec-session-id")
        return request
    }
}
