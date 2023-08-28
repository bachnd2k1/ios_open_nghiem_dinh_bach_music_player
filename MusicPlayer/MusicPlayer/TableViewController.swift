//
//  TableViewController.swift
//  MusicPlayer
//
//  Created by Bach Nghiem on 28/08/2023.
//

import UIKit

final class TableViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        getSongs()
    }
    
    private func config() {
        title = "Music Player"
        view.backgroundColor = UIColor.black
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getSongs() {
        let songArr = [
            Song(image: "ngot", name: "Album 1", artist: "Ngọt"),
            Song(image: "queen", name: "Album 2", artist: "Queen"),
            Song(image: "engelber", name: "Album 3", artist: "Engelber")
        ]
        _ = songArr.map { songs.append($0) }
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = songs[indexPath.row]
        guard let viewController  = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
        viewController.selectedSong = selectedItem
        navigationController?.pushViewController(viewController, animated: true)
    }
}


extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
    -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "songCell") as? SongCell else
        { return UITableViewCell() }
        let thisSong = songs[indexPath.row]
        cell.configCell(song: thisSong)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)
    -> CGFloat {
        return UIScreen.main.bounds.height / CGFloat(LayoutOptions.numberOfCells)
    }
}
