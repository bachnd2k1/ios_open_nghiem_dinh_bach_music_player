//
//  SongCell.swift
//  MusicPlayer
//
//  Created by Bach Nghiem on 28/08/2023.
//

import UIKit

final class SongCell: UITableViewCell {
    
    @IBOutlet private weak var songImage: UIImageView!
    @IBOutlet private weak var songLabel: UILabel!
    @IBOutlet private weak var artistLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(song: Song){
        songImage.image = UIImage(named: song.image)
        songLabel.text = song.name
        artistLabel.text = song.artist
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
