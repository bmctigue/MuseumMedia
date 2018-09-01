//
//  ViewController+PlayerDelegate.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 9/1/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import Foundation
import Player

extension ViewController: PlayerDelegate, PlayerPlaybackDelegate {
    
    public func playerPlaybackDidEnd(_ player: Player) {
        mediaManager?.nextItem()
    }
    
    func playerReady(_ player: Player) {}
    func playerPlaybackStateDidChange(_ player: Player) {}
    func playerBufferingStateDidChange(_ player: Player) {}
    func playerBufferTimeDidChange(_ bufferTime: Double) {}
    func playerPlaybackWillStartFromBeginning(_ player: Player) {}
    func playerCurrentTimeDidChange(_ player: Player) {}
    func playerPlaybackWillLoop(_ player: Player) {}
}
