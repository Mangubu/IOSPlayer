//
//  ViewController.swift
//  mp3player
//
//  Created by lpcm on 04/04/2016.
//  Copyright © 2016 lpcm. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    var audioPlayer = AVAudioPlayer()
    var meterTimer:NSTimer?
    
    @IBOutlet weak var playButton: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var musicSlide: UIProgressView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            //let url = "http://www.w3schools.com/html/horse.mp3"
            let url = "http://www.trackmusik.fr/songs/la-vie-est-belle-pnl.mp3"
            let fileURL = NSURL(string:url)
            let soundData = NSData(contentsOfURL:fileURL!)
            self.audioPlayer = try AVAudioPlayer(data: soundData!)
            audioPlayer.prepareToPlay()
            audioPlayer.delegate = self
            audioPlayer.meteringEnabled = true
        } catch {
            print("Error getting the audio file")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func onclickPlay(sender: AnyObject) {
        meterTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(ViewController.getAveragePowerForChannel), userInfo: nil, repeats: true)
        audioPlayer.prepareToPlay()
        audioPlayer.delegate = self
        audioPlayer.meteringEnabled = true
        audioPlayer.play()
    }
    

    @IBAction func onclickPause(sender: AnyObject) {
        audioPlayer.stop()
        meterTimer?.invalidate()
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        musicSlide.setProgress(1.0 , animated: false)
        meterTimer?.invalidate()
    }
   
    func getAveragePowerForChannel() {
        
        musicSlide.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: true)
        audioPlayer.updateMeters()
        //print(audioPlayer.averagePowerForChannel(0));
        print(audioPlayer.currentTime/audioPlayer.duration)
    }
}
