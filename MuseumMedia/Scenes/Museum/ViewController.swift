//
//  ViewController.swift
//  MuseumMedia
//
//  Created by Bruce McTigue on 9/1/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

protocol Playable: class {
    var builder: Builder? { get set }
    var interactor: BusinessLogic? { get set }
    var mediaManager: MediaManager? { get set }
    var playerController: AVPlayerViewController? { get set }
    func updateMediaIds(mediaIds: [MediaId])
    func fetch(mediaId: MediaId)
    func displayFetchedItem(viewModel: MuseumMedia.FetchItem.ViewModel)
}

class ViewController: UIViewController, Playable {
    
    var builder: Builder?
    var interactor: BusinessLogic?
    var mediaManager: MediaManager?
    var displayedItem: MuseumMedia.FetchItem.ViewModel.DisplayedItem?
    var playerController: AVPlayerViewController?
    var isFirstVideo = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.builder = Builder(viewController: self)
        addVideoPlayer()
        fetchMediaIds()
    }
    
    func addVideoPlayer() {
        self.playerController = AVPlayerViewController()
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerController?.player?.currentItem)
        playerController!.view.frame = self.view.bounds
        view.addSubview(playerController!.view)
    }
    
    func fetchMediaIds() {
        let request = MuseumMedia.FetchMediaIds.Request()
        interactor?.fetchMediaIds(request: request)
    }
    
    func updateMediaIds(mediaIds: [MediaId]) {
        mediaManager?.mediaIds = LoopIterator<[MediaId]>(collection: mediaIds)
        mediaManager?.nextItem()
    }
    
    func fetch(mediaId: MediaId) {
        let request = MuseumMedia.FetchItem.Request(mediaId: mediaId)
        interactor?.fetchItem(request: request)
    }
    
    func displayFetchedItem(viewModel: MuseumMedia.FetchItem.ViewModel) {
        let displayedItem = viewModel.displayedItem
        mediaManager?.itemQueue.insert(displayedItem, at: 0)
        mediaManager?.itemsHash[displayedItem.id] = displayedItem
        if isFirstVideo {
            play()
            self.isFirstVideo = false
        }
    }
    
    func play() {
        if let nextItem = mediaManager?.itemQueue.popLast() {
            if let url = URL(string: nextItem.url) {
                print(url)
                playVideo(url: url)
                mediaManager?.nextItem()
            }
        }
    }
    
    private func playVideo(url: URL) {
        let player = AVPlayer(url: url)
        playerController?.player = player
        player.play()
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        play()
    }
}
