//
//  SocketManager.swift
//  swiftSocketGyro
//
//  Created by Daniel Bernal on 5/7/18.
//  Copyright © 2018 Daniel Bernal. All rights reserved.
//

import Foundation
import Starscream

protocol SocketDelegate {
    func onSocketConnected()
    func onSocketDisconnected(error: Error?)
    func onSocketMessageReceived(message: String)
}

class SocketManager: WebSocketDelegate {
    
    var socket: WebSocket
    var delegate: SocketDelegate?
    var url: URL
    
    init(withUrl url: String, andDelegate delegate: SocketDelegate) {
        self.url = URL(string: url)!
        self.socket = WebSocket(url: self.url)
        self.delegate = delegate
    }
    
    func isConnected() -> Bool {
        return socket.isConnected
    }
    
    func connect() {
        print("Connecting to socket server...")
        socket.delegate = self;  // Starscream Delegate
        socket.connect()
    }
    
    func disconnect() {
        print("Disconnected")
        socket.disconnect()
    }
    
    func writeMessage(message: String) {
        socket.write(string: message)
    }
    
    func writeData(data: Data) {
        socket.write(data: data)
    }
    
    // MARK: StarScream Delegate Methods
    func websocketDidConnect(socket: WebSocketClient) {
        delegate?.onSocketConnected()
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        delegate?.onSocketDisconnected(error: error)
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        delegate?.onSocketMessageReceived(message: text)
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
       
    }

}
