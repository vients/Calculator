//
//  ViewController.swift
//  Calculator
//
//  Created by Yurii Vients on 10/9/17.
//  Copyright © 2017 Yurii Vients. All rights reserved.
//

import UIKit
import AVFoundation
import Speech

class InputViewController: UIViewController, InputInterface, SFSpeechRecognizerDelegate {
    
    var delegate: InputDelegate?
    
    @IBOutlet weak var microphoneButton: UIButton!
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "uk"))  //en-US
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    var microphoneisActive : Bool = false {
        didSet{
            if microphoneisActive {
                AudioServicesPlaySystemSound(1110)
                microphoneButton.flashMicrophone()
            }
            else{
                microphoneButton.layer.removeAllAnimations()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        microphoneButton.isEnabled = false
        
        speechRecognizer?.delegate = self
        
        recognition()
        
    }
    
    func recognition() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            var isButtonEnabled = false
            
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
                self.microphoneButton.isEnabled = isButtonEnabled
            }
        }
        
    }
    
    func symbolPressed(_ symbol: String){
        
        var fullNameArr = symbol.split{$0 == " "}.map(String.init)
        
        var i = 0;
        while(i < fullNameArr.count){
            checkForOperationSaid(resultString: fullNameArr[i])
//            delegate?.enterDigit(fullNameArr[i])
            i = i + 1
        }
        
    }
    
    @IBAction func tapOnButton(_ sender: UIButton) {
        
        symbolPressed(sender.currentTitle!)
//        playClick()
        delegate?.soundTap()
       
        if sender.currentTitle == "AC"{
            sender.shake()
        }
        else if sender.currentTitle == "="
        {
            sender.pulsate()
        }
        else {
            sender.flash()
        }
        
    }
    
    @IBAction func microphoneTapped(_ sender: UIButton) {
        
        microphoneisActive = !microphoneisActive
        
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            microphoneButton.isEnabled = false
        }
        else {
            startRecording()
        }
        
    }
    
    func playClick() {
//        AudioServicesPlaySystemSound(1104)
    }
    
    func soundTap(switchOn: Bool) {
        if switchOn == true {
            AudioServicesPlaySystemSound(1104)
        } else {}
    }
    
    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = false
        
        //  recognitionRequest.
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                
                
                let resultSpeech = result?.bestTranscription.formattedString
                print("Result speaking text = \(resultSpeech!)")
                
                //output result
                self.symbolPressed(resultSpeech!)
//                self.checkForOperationSaid(resultString: resultSpeech!)
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.microphoneButton.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
    }
    
    func checkForOperationSaid(resultString: String) {
        print("\(resultString)")

        switch resultString {
        case "синус", "Синус" :
            symbolPressed(Function.sin.rawValue)
        case "косинус", "Косинус":
            symbolPressed(Function.cos.rawValue)
        case "тангенс", "Тангенс":
            symbolPressed(Function.tan.rawValue)
        case "пі", "Пі":
            symbolPressed(Constants.pi.rawValue)
        case "логарифм", "Логарифм":
            symbolPressed(Function.ln.rawValue)
        case "степінь", "Степінь":
            symbolPressed(Operation.pow.rawValue)
        case "корінь", "Корінь":
            symbolPressed(Function.sqrt.rawValue)
        case "факторіал", "Факторіал":
            symbolPressed(Function.fact.rawValue)
        case "відсоток","Відсоток":
            symbolPressed(Function.percent.rawValue)
        case "поділити","Поділити":
            symbolPressed(Operation.div.rawValue)
        case "помножити","Помножити":
            symbolPressed(Operation.mult.rawValue)

        default:
            delegate?.enterDigit(resultString)
        }
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            microphoneButton.isEnabled = true
        } else {
            microphoneButton.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InputViewSegue"{
            let destinationVC = segue.destination as! AdditionViewController
            destinationVC.delegate = delegate
            
        }
        else if segue.identifier == "ScrollViewControllerSegue" {
            let destinationVC = segue.destination as! ScrollViewController
            destinationVC.delegate = delegate
        }
    }
    
    
}
