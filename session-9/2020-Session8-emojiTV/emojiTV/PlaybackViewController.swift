//
//  PlaybackViewController.swift
//  emojiTV
//
//  Created by T. Andrew Binkowski on 5/22/17.
//  Copyright © 2017 T. Andrew Binkowski. All rights reserved.
//

import UIKit
import AVKit

class PlaybackViewController: AVPlayerViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Use the built in overlay view
    let catOverlay = UIImageView(frame:CGRect(x: 50,
                                              y: 50,
                                              width: 100,
                                              height: 100))
    catOverlay.image = UIImage(named: "kitten")
    catOverlay.contentMode = .scaleToFill
    contentOverlayView?.addSubview(catOverlay)

    
    // Local file
    guard let path = Bundle.main.path(forResource: "dog", ofType:"m4v") else {
      return
    }

    // Set up the player
    self.player = AVPlayer(url: URL(fileURLWithPath: path))
    self.player?.play()
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(PlaybackViewController.itemDidFinishPlaying(notification:)),
                                                   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                   object: player?.currentItem)

  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  /// Automatically dismiss the player when done
  @objc func itemDidFinishPlaying(notification: NSNotification) {
    print ("Notification sent with done playing")
    self.dismiss(animated: true) {
      print("Dismissed player view controller")
    }
  }
  
}
