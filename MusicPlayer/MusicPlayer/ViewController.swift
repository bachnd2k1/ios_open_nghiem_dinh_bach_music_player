//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Bach Nghiem on 24/08/2023.
//

import AVFoundation
import MediaPlayer
import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var songImage: UIImageView!
    @IBOutlet private weak var songLabel: UILabel!
    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var prevButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var slider: UISlider!
    
    var songs: [Song] = []
    var position = 0
    private var player = AVAudioPlayer()
    private var timer = Timer()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSong()
        setupRemoteCommandCenter()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        player.stop()
    }
    
    
    @IBAction private func handleButtonPlay(_ sender: Any) {
        let _ = player.isPlaying ? { player.pause() }() : { player.play() }()
    }
    
    @IBAction private func handleButtonPrev(_ sender: Any) {
        position = position > 0 ? position - 1 : songs.count - 1
        updateSong()
    }
    
    @IBAction private func handleButtonNext(_ sender: Any) {
        position = position < songs.count - 1 ? position + 1 : 0
        updateSong()
    }
    
    private func updateSong(){
        timer.invalidate()
        let currentSong = songs[position]
        songLabel.text = currentSong.name
        artistLabel.text = currentSong.artist
        songImage.image = UIImage(named: currentSong.image)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            let currentPlayTime = Float(self.player.currentTime)
            let songDuration = Float(self.player.duration)
            
            self.slider.value = currentPlayTime/songDuration
            
            let imageName = self.player.isPlaying ? "pause.circle.fill" : "play.circle.fill"
            self.playButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
        
        playSong(name: currentSong.name)
        updateRemoteCommandCenter()
    }
    
    private func updateRemoteCommandCenter() {
        let currentSong = songs[position]
        
        guard let artWorkImage = UIImage(named: currentSong.image) else { return }
        let MPArtWork = MPMediaItemArtwork(boundsSize: artWorkImage.size) { [unowned artWorkImage] size in
            return artWorkImage
        }
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPMediaItemPropertyArtist: currentSong.artist,
            MPMediaItemPropertyTitle: currentSong.name,
            MPMediaItemPropertyArtwork: MPArtWork,
            MPNowPlayingInfoPropertyElapsedPlaybackTime: player.currentTime,
            MPMediaItemPropertyPlaybackDuration: player.duration,
            MPNowPlayingInfoPropertyPlaybackRate: player.rate
        ]
        MPNowPlayingInfoCenter.default().playbackState = .playing
    }
    
    private func playSong(name: String) {
        if let url = Bundle.main.url(forResource: name, withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player.play()
            } catch {
                print("Not find \(name)")
            }
        }
    }
    
    private func handleRemoteCommand(_ commandType: RemoteCommand) -> MPRemoteCommandHandlerStatus {
        switch commandType {
        case .play:
            player.play()
        case .pause:
            player.pause()
        case .nextTrack:
            position = position < songs.count - 1 ? position + 1 : 0
            updateSong()
        case .previousTrack:
            position = position > 0 ? position - 1 : songs.count - 1
            updateSong()
        }
        return .success
    }
    
    private func setupRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [unowned self] event in
            return self.handleRemoteCommand(RemoteCommand.play)
        }
        
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            return self.handleRemoteCommand(RemoteCommand.pause)
        }
        
        commandCenter.nextTrackCommand.isEnabled = true
        commandCenter.nextTrackCommand.addTarget { [unowned self] event in
            return self.handleRemoteCommand(RemoteCommand.nextTrack)
        }
        
        commandCenter.previousTrackCommand.isEnabled = true
        commandCenter.previousTrackCommand.addTarget { [unowned self] event in
            return self.handleRemoteCommand(RemoteCommand.previousTrack)
        }
    }
}

