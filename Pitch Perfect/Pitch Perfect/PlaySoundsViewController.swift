//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Che-Chuen Ho on 3/12/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer?
    var recordedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        audioPlayer = AVAudioPlayer(contentsOfURL: recordedAudio.filePathUrl, error: nil)
        audioPlayer?.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: recordedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slowSound(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer?.rate = 0.5
        audioPlayer?.play()
    }

    @IBAction func fastSound(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer?.rate = 2.0
        audioPlayer?.play()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        audioPlayer?.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func stopPlayback(sender: AnyObject) {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
        audioEngine.stop()
        audioEngine.reset()
    }

}
