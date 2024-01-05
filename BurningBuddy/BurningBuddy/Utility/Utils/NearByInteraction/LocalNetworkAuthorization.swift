//
//  LocalNetworkAuthorization.swift
//  BurningBuddy
//
//  Created by 박의서 on 2023/05/08.
//

import Foundation
import Network

@available(iOS 14.0, *)
class LocalNetworkAuthorization: NSObject { // mpc를 위한 클래스: 네트워크를 통해 데이터 통신
    private var browser: NWBrowser?
    private var netService: NetService?
    private var completion: ((Bool) -> Void)?
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        self.completion = completion
        
        // Create parameters, and allow browsing over peer-to-peer link.
        let parameters = NWParameters()
        parameters.includePeerToPeer = true
        
        // TODO: - nearcatch tcp 수정
        // Browse for a custom service type.
        let browser = NWBrowser(for: .bonjour(type: "_nearcatch._tcp", domain: nil), using: parameters)
        self.browser = browser
        browser.stateUpdateHandler = { newState in
            switch newState {
            case .failed(let error):
                print(error.localizedDescription)
            case .ready, .cancelled:
                break
            case let .waiting(error):
                print("Local network permission has been denied: \(error)")
                self.reset()
                self.completion?(false)
            default:
                break
            }
        }
        // TODO: - nearcatch tcp 수정
        self.netService = NetService(domain: "local.", type:"_nearcatch._tcp.", name: "LocalNetworkPrivacy", port: 1100)
        self.netService?.delegate = self
        
        self.browser?.start(queue: .main)
        self.netService?.publish()
    }
    
    private func reset() {
        self.browser?.cancel()
        self.browser = nil
        self.netService?.stop()
        self.netService = nil
    }
}

@available(iOS 14.0, *)
extension LocalNetworkAuthorization : NetServiceDelegate {
    public func netServiceDidPublish(_ sender: NetService) {
        self.reset()
        print("Local network permission has been granted")
        completion?(true)
    }
}
