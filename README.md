# Zignsec.MobileSdk.iOS

Mobile SDK for Online Document Scanning and Liveness through Zignsec. 

## Usage

1. Through your Backend, obtain an Access Token and Session ID By calling the ZignSec API Endpoint  https://test-gateway.zignsec.com/core/api/sessions/scanning/mobile (for Test Sessions) or https://gateway.zignsec.com/core/api/sessions/scanning/mobile for production Sessions. 
1. Transport the Access Token and Session ID from your backend to the Mobile App. 
1. Start an Identification Activity View as below. This will render the camera to the user and ask him/her to perform the desired actions (as triggered by the backend in the initial call). On completion your callback will be called with the results of the session.
```swift
IdentificationActivityView(environment: ZignSecEnvironment.test, sessionId: "", accessToken: "", completion: { result, error in
                /* Handle Results */ 
                return
            } )
```

