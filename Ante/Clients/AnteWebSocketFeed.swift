//
//  AnteWebSocketFeed.swift
//  Ante
//
//  Created by Zameer Andani on 3/27/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation
import Starscream

enum AnteWebSocketError: Error {
   case NotConnected
   case Connected
   case DelegateNotSet
   case MethodNotImplemented
}

protocol AnteWebSocketFeedDelegate {
   func connectionURL(ws: AnteWebSocketFeed) -> URL
   func onConnect(ws: AnteWebSocketFeed)
   func onDisconnect(ws: AnteWebSocketFeed, error: Error?)
   func onTickerUpdate(_ ws: AnteWebSocketFeed, _ ticker: AnteTicker)
}

class AnteWebSocketFeed {
   var source: AnteDataSource {
      get {
         return .unknown
      }
   }
   
   var queueName: String {
      get {
         return "unknown"
      }
   }
   
   var socket: WebSocket?
   var delegate: AnteWebSocketFeedDelegate?
   
   internal init() {}
   
   private func initSocket() throws {
      if let url = self.delegate?.connectionURL(ws: self) {
         self.socket = WebSocket(url: url)
         self.socket!.callbackQueue = DispatchQueue(label: self.queueName)

         self.socket!.onConnect = {
            self.delegate?.onConnect(ws: self)
         }

         self.socket!.onDisconnect = { (error: Error?) in
            self.delegate?.onDisconnect(ws: self, error: error)
         }

         self.socket!.onText = { (text: String) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)

            if let ticker = try? self.decodeText(decoder, text) {
               self.delegate?.onTickerUpdate(self, ticker)
            }
         }
      } else {
         throw AnteWebSocketError.DelegateNotSet
      }
   }
   
   public func connect() throws {
      if let socket = self.socket {
         if (!socket.isConnected) {
            socket.connect()
         } else {
            throw AnteWebSocketError.Connected
         }
      } else {
         try self.initSocket()
         try self.connect()
      }
   }
   
   public func disconnect() throws {
      if let socket = self.socket {
         if (socket.isConnected) {
            socket.disconnect()
         } else {
            throw AnteWebSocketError.NotConnected
         }
      } else {
         throw AnteWebSocketError.NotConnected
      }
   }
   
   public func decodeText(_ decoder: JSONDecoder, _ text: String) throws -> AnteTicker { throw AnteWebSocketError.MethodNotImplemented }
   
   public func subscribeTo(productIds: [String], channels: [String]) throws { throw AnteWebSocketError.MethodNotImplemented }
   
   public func unsubscribeTo(productIds: [String], channels: [String]) throws { throw AnteWebSocketError.MethodNotImplemented }
}
