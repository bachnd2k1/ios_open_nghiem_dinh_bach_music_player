//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Bach Nghiem on 24/08/2023.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var playButton: UIButton!
    private var isPlay = true
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func handleButtonPlay(_ sender: Any) {
        isPlay.toggle()
        let symbolName = isPlay ? "pause.circle.fill" : "play.circle.fill"
        playButton.setImage(UIImage(systemName: symbolName), for: .normal)
    }
}

