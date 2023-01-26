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
            /* You must obtain a session id and access token through a backend integration with the ZignSec API. */
            IdentificationActivityView(environment: ZignSecEnvironment.test, sessionId: "362fd76a-359c-425f-bdf1-ec5f794fe72e", accessToken: "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICI5RVpPQlY1VmpaZEZ0MzhucVFTM252V3dYNTVOQk1jd0F6SmZyYUl6VUcwIn0.eyJleHAiOjE2NzQ3NjAxMDQsImlhdCI6MTY3NDc1NjUwNCwianRpIjoiNDMzNmQ1OGYtZjk5NS00MjZjLTg4NGMtZjRlM2U3NDE3NDdhIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmUudGVzdC56aWduc2VjLXY1LnppZ25zZWMubmV0L2F1dGgvcmVhbG1zL3ppZ25zZWMiLCJzdWIiOiIzZDdlZDk5OC02OWVmLTQ1Y2QtYThiZC1iNzI2ZGM4Y2I5ZDciLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJ1aSIsImFsbG93ZWQtb3JpZ2lucyI6WyIiXSwic2NvcGUiOiJwcm9maWxlIGVtYWlsIiwiY2xpZW50SWQiOiJ1aSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiY2xpZW50SG9zdCI6IjE3Mi4yNy44LjQzIiwicHJlZmVycmVkX3VzZXJuYW1lIjoic2VydmljZS1hY2NvdW50LXVpIiwiY2xpZW50QWRkcmVzcyI6IjE3Mi4yNy44LjQzIn0.mhwTuWuiRNfxvdkJ_TZdQTEt6g955KHfVIF5ZKJUclXv3nN5SDwTqq00zqPdM4W4_fQnsUatn38z-xL8gJcVaUOJ5-qgCkLCtO0g9bruutfapKZLu4RqCM_jBk6cYP1eREHwR34c_f768ReOVxAdY4h8vY9lqDlLLJHcWwa_LhUE9AmGpa0QR_fkNEBYggIRqKFDHbSDoJ54N5BT7HiyQ7_58T3sy7UnA0oTpYSapEMkzANvFs83U03ZmQNM4ySomtdFaNObvMUBwxHDaAUfGPG0d-iUcax1OsOi-CR39KIqOxFzDK_jkNDHL9aizVQlFJyPjH-0V91l8LhK7s4O7w", completion: { result, error in
                print(result?.status ?? error ?? "Something Went Wrong.")
                return
            } )
        }
    }
}
