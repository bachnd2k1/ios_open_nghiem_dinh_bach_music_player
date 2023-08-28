//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Bach Nghiem on 24/08/2023.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var songImage: UIImageView!
    @IBOutlet private weak var songLabel: UILabel!
    @IBOutlet private weak var artistLabel: UILabel!
    private var isPlay = true
    var selectedSong : Song?
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedSong = selectedSong{
            songImage.image = UIImage(named: selectedSong.image)
            songLabel.text = selectedSong.name
            artistLabel.text = selectedSong.artist
        }
    }
    
    @IBAction private func handleButtonPlay(_ sender: Any) {
        isPlay.toggle()
        let symbolName = isPlay ? "pause.circle.fill" : "play.circle.fill"
        playButton.setImage(UIImage(systemName: symbolName), for: .normal)        
    }
}

