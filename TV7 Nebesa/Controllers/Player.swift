//
//  NebesaPlayer.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 4/11/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import AVKit
import GoogleCast


enum PlaybackState {
    case created
    case createdCast
    case playCast
    case play
    case pauseCast
    case pause
    case finishedCast
    case finished
}

class Player: UIView {
    

    private let timeObserver = "currentItem.loadedTimeRanges"
    var mediaItem: MediaItem!
    private var player: AVPlayer!
    private var playbackState: PlaybackState = .created
    let playerViewController = AVPlayerViewController()
    
    //MARK: - TIMERS
    private var localTimer: Timer?
    private var castTimer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        listenForCastConnection()
        
        if CastManager.shared.hasConnectionEstablished {
            playbackState = .createdCast
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initPlayerLayer() {
        
        DispatchQueue.main.async { [weak self] in

            guard let self = `self`, let url = URL(string: self.mediaItem.videoUrl ?? "") else { return }
            
            self.player = AVPlayer(url: url)
            self.player.addObserver(self, forKeyPath: self.timeObserver, options: [.initial, .new], context: nil)
            self.playerViewController.player = self.player
            self.playerViewController.view.frame = self.bounds
            self.playerViewController.entersFullScreenWhenPlaybackBegins = true
            self.addSubview(self.playerViewController.view)
        }
    }
    
    // Subscribe to orientation notifications
    
    func stopPlayback() {
        playerViewController.player?.pause()
 
    }

    func play() {
        playerViewController.player?.play()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object is AVPlayer && keyPath == timeObserver {
            let loadedTimeRanges = player.currentItem?.loadedTimeRanges
            guard let timeRanges = loadedTimeRanges, timeRanges.count > 0, let timeRange = timeRanges[0] as? CMTimeRange else { return }
            let currentBufferDuration = CMTimeGetSeconds(CMTimeAdd(timeRange.start, timeRange.duration))
//            if player.status == AVPlayer.Status.readyToPlay && currentBufferDuration > 2 {
//                if playPauseButton == nil  {
//                    createPlayPauseButton()
//                }
//                if buttonStackView == nil {
//                    createButtonStackView()

            
            }
        }

    
    // MARK: - Add Cast Connection Listener
    
    private func listenForCastConnection() {
        let sessionStatusListener: (CastSessionStatus) -> Void = { [weak self] status in
            switch status {
            case .started:
                self?.castSessionStarted()
            case .resumed:
                self?.castSessionResumed()
            case .ended:
                self?.castSessionEnded()
            case .failedToStart:
                self?.castSessionFailedToStart()
            case .alreadyConnected:
                self?.castSessionAlreadyConnected()
            case .suspended:
                self?.castSessionSuspended()
            }
        }
        CastManager.shared.addSessionStatusListener(listener: sessionStatusListener)
    }
    
    private func castSessionSuspended() {

    }
    
    private func castSessionAlreadyConnected() {
//        hideNativeControls()
        pauseNativePlayer()
        
    }
    
    // MARK: - add an alert here
    private func castSessionFailedToStart() {
    }
    
    private func castSessionStarted() {
//        hideNativeControls()
        startCastPlay()
    }
    
    private func castSessionResumed() {
        continueCastPlay()
    }
    

    private func castSessionEnded() {
        switch playbackState {
        case .createdCast:
//            hideNativeControls()
            playVideo()
        case .playCast:
            playbackState = .pause
            pauseVideo()
        case .pauseCast:
            playbackState = .play
            playVideo()
            
        default: break
        }
}
    
    //MARK: - Native controls functions

    private func startCastPlay() {
        guard let currentItem = player.currentItem else { return }
        let currentTime = player.currentTime().seconds
        let duration = currentItem.asset.duration.seconds
        
        

        let castMediaInfo = CastManager.shared.buildMediaInformation(with: mediaItem.name ?? "", with: mediaItem.about ?? "" , with: "TV7-Nebesa", with: duration, with: mediaItem.videoUrl ?? "", with: GCKMediaStreamType.buffered, with: mediaItem.thumbnailUrl ?? "")
        CastManager.shared.startSelectedItemRemotely(castMediaInfo, at: currentTime, completion: { [weak self] done in
            if !done {
                self?.playbackState = .playCast
                self?.startCastTimer()
            } else {
                self?.playbackState = .finishedCast
            }
        })
    }
    
    private func continueCastPlay() {
        CastManager.shared.playSelectedItemRemotely(to: nil) { [weak self] done in
            if !done {
                self?.playbackState = .playCast
                self?.startCastTimer()
            } else {
                self?.playbackState = .finishedCast
            }
        }
    }
    
    private func playNativePlayer() {
        playbackState = .play
        player?.play()
    }
    
    private func pauseNativePlayer() {
        playbackState = .pause
        player?.pause()
    }
    
    private func pauseCastPlay() {
        playbackState = .pauseCast
        CastManager.shared.pauseSelectedItemRemotely(to: nil) { (done) in
            if !done {
                self.playbackState = .pause
                self.playVideo()
            }
        }
    }
    // CREATE CUSTOM BUTTONS CLASS
    // MARK: - Play/Pause/Replay Button
    

    
    // MARK: Play Button Change
    


    
    // MARK: Start Player
    
    @objc private func playVideo() {
        switch playbackState {
        case .pause:
            playNativePlayer()
            stopLocalTimer()
        case .pauseCast:
            pauseVideo()
            startCastPlay()
        default: break
        }
    }
    
    // MARK: Pause Player
    
    @objc private func pauseVideo() {
        switch playbackState {
        case .playCast:
            pauseCastPlay()
        case .play:
            pauseNativePlayer()
        case .finishedCast, .finished:
            stopLocalTimer()
            stopCastTimer()
        default: break
        }
    }
    
    // MARK: - Bottom Controls
    

    
    //     MARK: - Current Time Gradient Label
    

    


    //     MARK: - Player Slider
    

    // MARK: - Update slider on Local
    
    private func startLocalTimer() {
        stopCastTimer()
        stopLocalTimer()
        localTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateInfoContent), userInfo: nil, repeats: true)
    }
    
    private func stopLocalTimer() {
        localTimer?.invalidate()
        localTimer = nil
    }
    
    private func startCastTimer() {
        stopLocalTimer()
        stopCastTimer()
        castTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.sendCurrentTimeCastSessionRequest), userInfo: nil, repeats: true)
    }
    
    private func stopCastTimer() {
        castTimer?.invalidate()
        castTimer = nil
    }
    
    @objc private func updateInfoContent() {
        guard let currentItem = player.currentItem else { return }
        var currentTime = player.currentTime().seconds
        var duration = currentItem.asset.duration.seconds
        guard (currentTime.isNaN || currentTime.isInfinite && duration.isInfinite || duration.isNaN) else {
            return
        }
        
        currentTime = 0
        duration = 0
    }
    
    // MARK: - Update slider on Cast
    
    @objc private func sendCurrentTimeCastSessionRequest() {
        CastManager.shared.getSessionCurrentTime { (time) in
            guard var time = time,
                let currentItem = player.currentItem else { return }
            var duration = currentItem.asset.duration.seconds
            //            self.slider.value = Float(time / duration)
            
            guard (time.isNaN || time.isInfinite && duration.isNaN || duration.isInfinite) else {
                return
            }
            duration = 0
            time = 0
        }
    }
    
    // MARK: - Player Slider Actions
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        guard let currentItem = player.currentItem else { return }
        let duration = currentItem.asset.duration.seconds
        
        let timeToSeek = duration * Double(sender.value)
        
        player.seek(to: CMTime.init(seconds: timeToSeek, preferredTimescale: CMTimeScale.max))
        sendChangeToCast(time: timeToSeek)
    }
    
    private func sendChangeToCast(time: TimeInterval) {
        //if we are in Cast Mode then restart the cast at the position slided at
        if playbackState == .pauseCast || playbackState == .playCast {
            let currentTime = player.currentTime().seconds
            CastManager.shared.playSelectedItemRemotely(to: currentTime, completion: { (done) in
                if !done {
                    self.playbackState = .pause
                    self.playVideo()
                }
            })
        }
    }
}

