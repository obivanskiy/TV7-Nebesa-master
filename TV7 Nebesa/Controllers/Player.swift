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
    
    private var playPauseButton: UIButton!
    private var spinner: UIActivityIndicatorView!
    
    //MARK: - bottom controls
    private var buttonStackView: UIStackView!
    private var currentTimeLabel: UILabel!
    private var totalTimeLabel: UILabel!
    private var slider: UISlider!
    
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
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        
        player.removeObserver(self, forKeyPath: timeObserver)
    }
    
    
    
    func initPlayerLayer() {
        guard let url = URL(string: mediaItem.videoUrl) else { return }
        
        player = AVPlayer(url: url)
        player.addObserver(self, forKeyPath: timeObserver, options: .new, context: nil)
        playerViewController.player = player
        playerViewController.view.frame = bounds
        addSubview(playerViewController.view)
    }
    
    func stopPlayback() {
        playerViewController.player?.pause()
    }
    
    private func createSpinner() {
        spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.hidesWhenStopped = true
        spinner.stopAnimating()
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: 40).isActive = true
        spinner.widthAnchor.constraint(equalToConstant: 40).isActive = true
        spinner.startAnimating()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object is AVPlayer && keyPath == timeObserver {
            let loadedTimeRanges = player.currentItem?.loadedTimeRanges
            guard let timeRanges = loadedTimeRanges, timeRanges.count > 0, let timeRange = timeRanges[0] as? CMTimeRange else { return }
            let currentBufferDuration = CMTimeGetSeconds(CMTimeAdd(timeRange.start, timeRange.duration))
//            if player.status == AVPlayer.Status.readyToPlay && currentBufferDuration > 2 {
//                if playPauseButton == nil {
////                    createPlayPauseButton()
//                }
//                if buttonStackView == nil {
//                    createButtonStackView()
//                }
//                spinner.stopAnimating()
//            }
        }
    }
    
    // MARK: - Add Cast Connection Listener
    
    private func listenForCastConnection() {
        let sessionStatusListener: (CastSessionStatus) -> Void = { status in
            switch status {
            case .started:
                self.startCastPlay()
            case .resumed:
                self.continueCastPlay()
            case .ended, .failedToStart:
                if self.playbackState == .playCast {
                    self.playbackState = .pause
//                    self.startPlayer(nil)
                } else if self.playbackState == .pauseCast {
                    self.playbackState = .play
//                    self.pausePlayer(nil)
                }
            default: break
            }
        }
        
        CastManager.shared.addSessionStatusListener(listener: sessionStatusListener)
        
    }
    
    private func startCastPlay() {
        guard let currentItem = player.currentItem else { return }
        let currentTime = player.currentTime().seconds
        let duration = currentItem.asset.duration.seconds
        playbackState = .playCast
        player.pause()
        let castMediaInfo = CastManager.shared.buildMediaInformation(with: mediaItem.name, with: mediaItem.about, with: "TV7-Nebesa", with: duration, with: mediaItem.videoUrl, with: GCKMediaStreamType.buffered, with: mediaItem.thumbnailUrl)
        CastManager.shared.startSelectedItemRemotely(castMediaInfo, at: currentTime, completion: { done in
            if !done {
                self.playbackState = .pause
                self.startPlayer(nil)
            } else {
                self.scheduleCastTimer()
            }
        })
    }
    
    private func continueCastPlay() {
        playbackState = .playCast
        CastManager.shared.playSelectedItemRemotely(to: nil) { (done) in
            if !done {
                self.playbackState = .pause
//                self.startPlayer(nil)
            }
        }
    }
    
    private func pauseCastPlay() {
        playbackState = .pauseCast
        CastManager.shared.pauseSelectedItemRemotely(to: nil) { (done) in
            if !done {
                self.playbackState = .pause
//                self.startPlayer(nil)
            }
        }
    }
    
    // MARK: - Play/Pause/Replay Button
    
//    private func createPlayPauseButton() {
//        playPauseButton = UIButton()
//        playPauseButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//        playPauseButton.setTitle("", for: .normal)
//        playPauseButton.layer.cornerRadius = 40/2
//        playPauseButton.clipsToBounds = true
//        playPauseButton.backgroundColor = UIColor.black.withAlphaComponent(0.64)
//        addSubview(playPauseButton)
//        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
//        playPauseButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        playPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        playPauseButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        playPauseButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
//
//        changeToPlayButton()
//    }
    
    // MARK: Play Button Change
    
//    private func changeToPlayButton() {
//        guard let playPauseButton = playPauseButton else { return }
//        playPauseButton.removeTarget(self, action: nil, for: .allEvents)
//        playPauseButton.setImage(#imageLiteral(resourceName: "icon_play"), for: .normal)
//        playPauseButton.addTarget(self, action: #selector(startPlayer(_:)), for: .touchUpInside)
//    }
    
    // MARK: Pause Button Change
//
//    private func changeToPauseButton() {
//        guard let playPauseButton = playPauseButton else { return }
//        playPauseButton.removeTarget(self, action: nil, for: .allEvents)
//        playPauseButton.setImage(#imageLiteral(resourceName: "icon_pause"), for: .normal)
//        playPauseButton.addTarget(self, action: #selector(pausePlayer(_:)), for: .touchUpInside)
//    }
    
    // MARK: Start Player
    
    @objc private func startPlayer(_ sender: Any?) {
        if playbackState == .pause || playbackState == .created {
            scheduleLocalTimer()
            player?.play()
            playbackState = .play
        } else if playbackState == .createdCast {
            scheduleCastTimer()
            startCastPlay()
        } else {
            scheduleCastTimer()
            player?.pause()
            playbackState = .playCast
            continueCastPlay()
        }
//        changeToPauseButton()
    }
    
    // MARK: Pause Player
    
    @objc private func pausePlayer(_ sender: Any?) {
        if playbackState == .play {
            player?.pause()
            playbackState = .pause
        } else {
            player?.pause()
            playbackState = .pauseCast
            pauseCastPlay()
        }

//        changeToPlayButton()
    }
    
    // MARK: - Bottom Controls
    
    // MARK: Button StackView
    
//    private func createButtonStackView() {
//        buttonStackView = UIStackView()
//        buttonStackView.axis = .horizontal
//        buttonStackView.alignment = .fill
//        buttonStackView.spacing = 5
//        addSubview(buttonStackView)
//        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
//        buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        buttonStackView.heightAnchor.constraint(equalToConstant: 20).isActive = true
//
//        createcurrentTimeLabel()
//        createSlider()
//        createTotalTimeLabel()
//    }
    
    // MARK: - Current Time Gradient Label
//
//    private func createcurrentTimeLabel() {
//        currentTimeLabel = UILabel()
//        currentTimeLabel.textAlignment = .right
//        currentTimeLabel.textColor = .white
//        buttonStackView.addArrangedSubview(currentTimeLabel)
//        currentTimeLabel.translatesAutoresizingMaskIntoConstraints = false
//        currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
//    }
    
    // MARK: - Total Time Gradient Label
    
//    private func createTotalTimeLabel() {
//        totalTimeLabel = UILabel()
//        totalTimeLabel.textAlignment = .left
//        totalTimeLabel.textColor = .white
//        buttonStackView.addArrangedSubview(totalTimeLabel)
//        totalTimeLabel.translatesAutoresizingMaskIntoConstraints = false
//        totalTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
//    }
    
    // MARK: - Player Slider
    
//    private func createSlider() {
//        slider = UISlider()
//        slider.isContinuous = true
//        slider.isUserInteractionEnabled = true
//        slider.minimumValue = 0
//        slider.maximumValue = 1
//        slider.tintColor = UIColor.nodesColor()
//        slider.value = 0
//        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
//        addSliderRecognizers()
//        buttonStackView.addArrangedSubview(slider)
//    }
    // MARK: - Update slider on Local
    
    private func scheduleLocalTimer() {
        DispatchQueue.main.async {
            switch self.playbackState {
            case .play, .pause, .created:
                self.castTimer?.invalidate()
                self.castTimer = nil
                self.localTimer?.invalidate()
                self.localTimer = Timer.scheduledTimer(timeInterval: 1,
                                                       target: self,
                                                       selector: #selector(self.updateInfoContent),
                                                       userInfo: nil,
                                                       repeats: true)
            default:
                self.localTimer?.invalidate()
                self.localTimer = nil
            }
        }
    }
    
    @objc private func updateInfoContent() {
        guard let currentItem = player.currentItem else { return }
        var currentTime = player.currentTime().seconds
        var duration = currentItem.asset.duration.seconds
//        slider.value = Float(currentTime / duration)
        guard (currentTime.isNaN || currentTime.isInfinite && duration.isInfinite || duration.isNaN) else {
            return
        }
        
        currentTime = 0
        duration = 0
        
        totalTimeLabel.text = duration.toTimeString() as String
        currentTimeLabel.text = currentTime.toTimeString() as String
        
    }
    
    // MARK: - Update slider on Cast
    
    private func scheduleCastTimer() {
        DispatchQueue.main.async {
            switch self.playbackState {
            case .playCast, .pauseCast, .createdCast:
                self.localTimer?.invalidate()
                self.localTimer = nil
                self.castTimer?.invalidate()
                self.castTimer = Timer.scheduledTimer(timeInterval: 0.5,
                                                      target: self,
                                                      selector: #selector(self.sendCurrentTimeCastSessionRequest),
                                                      userInfo: nil,
                                                      repeats: true)
            default:
                self.castTimer?.invalidate()
                self.castTimer = nil
            }
        }
    }
    
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
            self.totalTimeLabel.text = duration.toTimeString() as String
            self.currentTimeLabel.text = time.toTimeString() as String

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
    
    private func addSliderRecognizers() {
        let tapSlider = UITapGestureRecognizer(target: self, action: #selector(tapSlider(_:)))
        slider.addGestureRecognizer(tapSlider)
    }
    
    @objc private func tapSlider(_ recognizer: UIGestureRecognizer) {
        let pointTapped: CGPoint = recognizer.location(in: self)
        
        let positionOfSlider: CGPoint = slider.frame.origin
        let widthOfSlider: CGFloat = slider.frame.size.width
        let newValue = ((pointTapped.x - positionOfSlider.x) * CGFloat(slider.maximumValue) / widthOfSlider)
        
        slider.setValue(Float(newValue), animated: true)
        
        guard let currentItem = player.currentItem else { return }
        let duration = currentItem.asset.duration.seconds
        let timeToSeek = duration * Double(slider.value)
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
//                    self.startPlayer(nil)
                }
            })
        }
    }
}