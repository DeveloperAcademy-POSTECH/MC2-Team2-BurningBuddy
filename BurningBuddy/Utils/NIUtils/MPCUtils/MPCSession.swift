/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A class that manages peer discovery-token exchange over the local network by using MultipeerConnectivity.
*/

import Foundation
import MultipeerConnectivity

// MultipeerConnectivity 프레임워크를 사용하여 로컬 네트워크에서 피어 디스커버리 및 데이터 교환을 관리하는 MPCSession 클래스를 정의하는 코드

// 상수를 정의하는 구조체
struct MPCSessionConstants {
    static let kKeyIdentity: String = "identity"
}

protocol MultipeerConnectivityManagerDelegate: AnyObject {
    func connectedDevicesChanged(devices: [String])
}

// MCSessionDelegate, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate 프로토콜을 채택하여 MultipeerConnectivity 프레임워크의 세 가지 주요 구성요소에 대한 이벤트를 처리
class MPCSession: NSObject, MCSessionDelegate, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate {
    // Handler: 이벤트 핸들러, 외부에서 설정 가능, MPCSession인스턴스에서 이벤트가 발생할 때 실행
    var peerDataHandler: ((Data, MCPeerID) -> Void)? // 연결된 피어에서 데이터를 수신하면 호출
    var peerConnectedHandler: ((MCPeerID) -> Void)? // 피어가 연결되면 호출
    var peerDisconnectedHandler: ((MCPeerID) -> Void)? // 피어가 연결 해체되면 호출
    
    private let serviceString: String
    private let mcSession: MCSession
    private let localPeerID = MCPeerID(displayName: UIDevice.current.name) // 로컬 피어 아이디 생성
    private let mcAdvertiser: MCNearbyServiceAdvertiser // 초대에 대해 알림
    private let mcBrowser: MCNearbyServiceBrowser
    private let identityString: String
    private let maxNumPeers: Int // 최대 연결 가능한 피어 수
    weak var delegate: MultipeerConnectivityManagerDelegate?

    init(service: String, identity: String, maxPeers: Int) {
        serviceString = service
        identityString = identity
        mcSession = MCSession(peer: localPeerID, securityIdentity: nil, encryptionPreference: .required)
        mcAdvertiser = MCNearbyServiceAdvertiser(peer: localPeerID,
                                                 discoveryInfo: [MPCSessionConstants.kKeyIdentity: identityString],
                                                 serviceType: serviceString)
        mcBrowser = MCNearbyServiceBrowser(peer: localPeerID, serviceType: serviceString)
        maxNumPeers = maxPeers

        super.init()
        mcSession.delegate = self
        mcAdvertiser.delegate = self
        mcBrowser.delegate = self
    }

    
    
    // MARK: - `MPCSession` public methods.
    // Begins advertising the service provided by a local peer and starts the assistant. - 서비스를 advertising하기 시작하고, assistant시작
    func start() {
        mcAdvertiser.startAdvertisingPeer()
        mcBrowser.startBrowsingForPeers()
    }

    func suspend() {
        mcAdvertiser.stopAdvertisingPeer()
        mcBrowser.stopBrowsingForPeers()
    }

    func invalidate() {
        suspend()
        mcSession.disconnect()
    }

    func sendDataToAllPeers(data: Data) {
        sendData(data: data, peers: mcSession.connectedPeers, mode: .reliable)
    }

    func sendData(data: Data, peers: [MCPeerID], mode: MCSessionSendDataMode) {
        do {
            try mcSession.send(data, toPeers: peers, with: mode)
        } catch let error {
            NSLog("Error sending data: \(error)")
        }
    }

    
    
    // MARK: - `MPCSession` private methods.
    private func peerConnected(peerID: MCPeerID) {
        if let handler = peerConnectedHandler {
            DispatchQueue.main.async {
                handler(peerID)
            }
        }
        
        // 연결 가능한 최대 피어 수를 초과하면 연결 요청 거부
        if mcSession.connectedPeers.count == maxNumPeers {
            self.suspend()
        }
    }

    private func peerDisconnected(peerID: MCPeerID) {
        if let handler = peerDisconnectedHandler {
            DispatchQueue.main.async {
                handler(peerID)
            }
        }
        
        // 연결 가능한 최대 피어수보다 작으면 start
        if mcSession.connectedPeers.count < maxNumPeers {
            self.start()
        }
    }

    
    // MARK: - Protocol: `MCSessionDelegate`. - 6개, 세션 관련 이벤트를 처리
    // The MCSessionDelegate protocol defines methods that a delegate of the MCSession class can implement to handle session-related events. For more information, see MCSession. - 세션 관련 이벤트를 처리하기 위해 구현할 수 있는 방법을 정의
    // Delegate calls occur on a private serial queue. If your app needs to perform an action on a particular run loop or operation queue, its delegate method should explicitly dispatch or schedule that work.
    
    // Called when the state of a nearby peer changes. - nearby peer의 상태가 바꼈을때 호출
    internal func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            peerConnected(peerID: peerID)
        case .notConnected:
            peerDisconnected(peerID: peerID)
        case .connecting:
            break
        @unknown default:
            fatalError("Unhandled MCSessionState")
        }
    }

    // Indicates that an NSData object has been received from a nearby peer. - nearby peer로 부터 NSData object를 받았을때
    internal func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let handler = peerDataHandler {
            DispatchQueue.main.async {
                handler(data, peerID)
            }
        }
    }

    // Called when a nearby peer opens a byte stream connection to the local peer. - nearby peer가 local peer에 대한 바이트 스트림 연결을 열 때 호출됩니다.
    internal func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        // The sample app intentional omits this implementation. - 샘플 앱은 implement를 의도적으로 생략했음
    }

    // Indicates that the local peer began receiving a resource from a nearby peer. - local peer가 nearby peer에게 리소스를 받기 시작했을때
    internal func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID,
                          with progress: Progress) {
        // progress: An NSProgress object that can be used to cancel the transfer or queried to determine how far the transfer has progressed. - 전송을 취소하는 데 사용하거나 전송이 얼마나 진행되었는지 확인하기 위해 쿼리할 수 있는 NSProgress 개체
        
        // The sample app intentional omits this implementation. - 샘플 앱은 implement를 의도적으로 생략했음
    }

    // Indicates that the local peer finished receiving a resource from a nearby peer. - local peer가 nearby peer로 부터 리소스를 받는 것을 끝냈다는 것을 가르킴
    internal func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String,
                          fromPeer peerID: MCPeerID,
                          at localURL: URL?,
                          withError error: Error?) {
        // localURL: An NSURL object that provides the location of a temporary file containing the received data. - 수신된 데이터가 포함된 임시 파일의 위치를 제공하는 NSURL 개체
        // withError: An error object indicating what went wrong if the file was not received successfully, or nil. - 파일을 성공적으로 수신하지 못한 경우 무엇이 잘못되었는지 나타내는 오류 개체 또는 0
        
        // The sample app intentional omits this implementation. - 샘플 앱은 implement를 의도적으로 생략했음
    }

    
    
    // MARK: - Protocol: `MCNearbyServiceBrowserDelegate`. - Error Handling Delegate Methods, Peer Discovery Delegate Methods
    // The MCNearbyServiceBrowserDelegate protocol defines methods that a MCNearbyServiceBrowser object’s delegate can implement to handle browser-related events. - MCNearbyServiceBrowser 개체의 대리자가 브라우저 관련 이벤트를 처리하기 위해 구현할 수 있는 메서드를 정의
    
    // Called when a nearby peer is found. - nearby peer를 찾았을때
    internal func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String: String]?) {
        guard let identityValue = info?[MPCSessionConstants.kKeyIdentity] else {
            return
        }
        if identityValue == identityString && mcSession.connectedPeers.count < maxNumPeers {
            browser.invitePeer(peerID, to: mcSession, withContext: nil, timeout: 10)
        }
    }

    // Called when a nearby peer is found. - nearby peer를 잃었을때
    internal func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        // The sample app intentional omits this implementation. - 샘플 앱은 implement를 의도적으로 생략했음
    }

    
    
    // MARK: - Protocol: `MCNearbyServiceAdvertiserDelegate`. - Error Handling Methods, Invitation Handling Delegate Methods
    // The MCNearbyServiceAdvertiserDelegate protocol describes the methods that the delegate object for an MCNearbyServiceAdvertiser instance can implement for handling events from the MCNearbyServiceAdvertiser class. - MCNearbyServiceAdvertiser 인스턴스에 대한 위임 개체가 MCNearbyServiceAdvertiser 클래스의 이벤트를 처리하기 위해 구현할 수 있는 방법을 설명합니다.
    
    // Called when an invitation to join a session is received from a nearby peer. - nearby peer로부터 session 초대를 받으면 호출됨
    internal func advertiser(_ advertiser: MCNearbyServiceAdvertiser,
                             didReceiveInvitationFromPeer peerID: MCPeerID,
                             withContext context: Data?,
                             invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        // Accept the invitation only if the number of peers is less than the maximum.
        if self.mcSession.connectedPeers.count < maxNumPeers {
            invitationHandler(true, mcSession)
        }
    }
    
}
