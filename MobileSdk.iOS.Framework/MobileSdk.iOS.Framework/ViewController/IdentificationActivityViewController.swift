import UIKit
import DocumentReader
import FaceSDK
import Photos

public class IdentificationActivityViewController: UIViewController {

    typealias ZignSecIdentificationActivityCompletion = ((_ result:ZignSecIdentificationSessionResult?,_ error: String?) -> Void)
    var sessionId: String? = nil
    var accessToken: String? = nil
    var environment: ZignSecEnvironment = ZignSecEnvironment.prod
    var urlInterceptingDelegate: ZignSecUrlRequestInterceptingDelegate? = nil
    var completion: ZignSecIdentificationActivityCompletion = { result, error in
        return
    }
    var spinnerViewController: SpinnerViewController? = nil
    
    
    static func makeIdentificationActivityViewController(environment: ZignSecEnvironment, sessionId: String, accessToken: String, completion: @escaping ZignSecIdentificationActivityCompletion) -> IdentificationActivityViewController {
        let newViewController = IdentificationActivityViewController()
        newViewController.sessionId = sessionId
        newViewController.accessToken = accessToken
        newViewController.environment = environment
        newViewController.urlInterceptingDelegate = ZignSecUrlRequestInterceptingDelegate(accessToken: accessToken, sessionId: sessionId)
        newViewController.completion = completion
        newViewController.spinnerViewController = SpinnerViewController()
        return newViewController
    }
    
    private func startSpinner(){
        DispatchQueue.main.async {
            let child = self.spinnerViewController!
            self.addChild(child)
            child.view.frame = self.view.frame
            self.view.addSubview(child.view)
            child.didMove(toParent: self)
        }
    }

    private func stopSpinner(){
        DispatchQueue.main.async {
            let child = self.spinnerViewController!
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    
    private func setup(){
        let config = DocReader.OnlineProcessingConfig(mode: .manual)
        
        config.serviceURL = self.environment.rawValue + "/proxy/docs"
        
        config.requestInterceptingDelegate = urlInterceptingDelegate
        
        let processParams = ProcessParams()
        processParams.dateFormat = "yyyy-MM-dd"
        processParams.scenario = RGL_SCENARIO_FULL_PROCESS
        config.processParams = processParams
        
        DocReader.shared.functionality.manualMultipageMode = true
        DocReader.shared.processParams.multipageProcessing = false

        DocReader.shared.functionality.onlineProcessingConfig = config
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        startCapture()
    }
    
    public func startCapture() {
        if let window = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?.windows.first {
            let topMostViewController = window.rootViewController
            
            DocReader.shared.showScanner(topMostViewController!) { action, result, error in
                DocReader.shared.customization.showStatusMessages = false

                if action == .processOnServer || action == .process {
                    return
                }
                
                if action == .complete && result != nil{
                    if result!.morePagesAvailable != 0 {
                        DocReader.shared.startNewPage()
                        DocReader.shared.customization.status = "A Two-Sided document has been detected. Please take a photo of the other side."
                        self.startCapture()
                        return
                    } 
                    
                    self.handleDocumentReaderResult(result: result!)
                    return
                }
                
                else {
                    self.completion(nil, error?.localizedDescription ?? "Something went wrong during the document scan.")
                    return
                }
            }
        }
    }
    
    func parseSessionResponse(rawResult: String?) -> ZignSecIdentificationSessionResult? {
        let decoder = JSONDecoder()
        let json = rawResult?.data(using: .utf8)!
        
        if let zignsecSessionResponse = try? decoder.decode(ZignSecIdentificationSessionResponse.self, from: json!) {
            return zignsecSessionResponse.session
            }
        
        return nil
    }
    
    func parseSessionResult(rawResult: String?) -> ZignSecIdentificationSessionResult? {
        let decoder = JSONDecoder()
        let json = rawResult?.data(using: .utf8)!
        
        if let zignsecSessionResponse = try? decoder.decode(ZignSecIdentificationSessionResult.self, from: json!) {
            return zignsecSessionResponse
            }
        
        return nil
    }
    
    func handleDocumentReaderResult(result: DocumentReaderResults) {
        self.startSpinner()

        let zignsecDocumentReaderResult = parseSessionResponse(rawResult: result.rawResult)
        
        if zignsecDocumentReaderResult?.result?.documentAnalysis?.status == ZignSecDocumentAnalysisStatus.accepted && zignsecDocumentReaderResult?.result?.livenessAnalysis?.status == ZignSecLivenessAnalysisStatus.requested {
            self.stopSpinner()
            self.startLiveness(documentReaderResult: result)
        } else {
            self.stopSpinner()
            self.completion(zignsecDocumentReaderResult, nil)
            
        }
    }
    
    func failLiveness(livenessResponse: LivenessResponse) -> Void {
        self.startSpinner()

        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        
        let session = URLSession(configuration: configuration)
        
        let url = URL(string: self.environment.rawValue + "/proxy/faceapi/api/liveness/complete")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(self.accessToken!, forHTTPHeaderField: "Authorization")
        request.addValue(self.sessionId!, forHTTPHeaderField: "x-zignsec-session-id")
        
        let parameters = ["result": livenessResponse.liveness.rawValue] as [String:Any]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            self.stopSpinner()
            self.completion(nil, error.localizedDescription)
            return
        }
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            if error != nil || data == nil {
                self.stopSpinner()
                self.completion(nil, error?.localizedDescription ?? "Something went wrong during Liveness.")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                self.stopSpinner()
                self.completion(nil, error?.localizedDescription ?? "A Network Error occured during Liveness.")
                return
            }
            
            do {
                let decoder = JSONDecoder()

                if let zignsecSessionResponse = try? decoder.decode(ZignSecIdentificationSessionResult.self, from: data!) {
                    self.stopSpinner()
                    self.completion(zignsecSessionResponse, nil)
                    return
                }
            }
        })
        
        task.resume()
    }
    
    func finaliseLiveness(livenessResponse: LivenessResponse) -> Void {
        
        self.startSpinner()

        let base64Image = livenessResponse.image!.jpegData(compressionQuality: 1)?.base64EncodedString()
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        
        let session = URLSession(configuration: configuration)
    
        let url = URL(string: self.environment.rawValue + "/proxy/faceapi/api/liveness/complete")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer " + self.accessToken!, forHTTPHeaderField: "Authorization")
        request.addValue(self.sessionId!, forHTTPHeaderField: "x-zignsec-session-id")
        
        let parameters = ["image": base64Image!, "imageMimeType": "image/jpeg", "result": livenessResponse.liveness.rawValue] as [String:Any]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            self.stopSpinner()
            self.completion(nil, error.localizedDescription)
        }
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            if error != nil || data == nil {
                self.stopSpinner()
                self.completion(nil, "Network Error.")
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                self.stopSpinner()
                self.completion(nil, "Network Error.")
                return
            }
            
            do {
                let decoder = JSONDecoder()

                if let zignsecSessionResponse = try? decoder.decode(ZignSecIdentificationSessionResult.self, from: data!) {
                    self.stopSpinner()
                    self.completion(zignsecSessionResponse, nil)
                }
            }
        })
        
        task.resume()
    }
    
    func startLiveness(documentReaderResult: DocumentReaderResults?) {
        let configuration = LivenessConfiguration {
            $0.cameraPosition = .front
            $0.isCameraSwitchButtonEnabled = true
        }
        
        FaceSDK.service.serviceURL = self.environment.rawValue + "/proxy/faceapi"
        
        FaceSDK.service.requestInterceptingDelegate = self.urlInterceptingDelegate
        
        FaceSDK.service.startLiveness(
            from: self,
            animated: true,
            configuration: configuration,
            onLiveness: { livenessResponse in
                if (livenessResponse.liveness == LivenessStatus.passed){
                    self.finaliseLiveness(livenessResponse: livenessResponse)
                } else {
                    self.failLiveness(livenessResponse: livenessResponse)
                }
            },
            completion: nil
        )
    }
}
