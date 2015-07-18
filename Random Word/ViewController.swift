//
//  ViewController.swift
//  Random Word
//


import Cocoa
import CoreServices

extension Array {
    func randomItem() -> T {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

class ViewController: NSViewController {
    
    let path = NSBundle.mainBundle().pathForResource("EnglishNouns", ofType: "txt")

    var words = [String]()
    var currentWord = "word"
    
    @IBOutlet var wordLabel: NSTextField!
    
// MARK: - Lifecycle methods
    
    override func viewDidAppear() {
        super.viewDidAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWords()
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
// MARK: - Word operations
    
    func loadWords() {
        if let string = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil) {
            let separator = NSCharacterSet.newlineCharacterSet()
            words = string.componentsSeparatedByCharactersInSet(separator) as [String]
        }
    }
    
    func displayRandomWord() {
        currentWord = pickRandomWord()
        wordLabel.stringValue = currentWord
        println(defineWithSystemDictionary(currentWord))
    }
    
    func pickRandomWord() -> String! {
        var randomWord = words.randomItem()
        return randomWord
    }
    
    func defineWithSystemDictionary(word: String) -> String! {
        var range = CFRangeMake(0, count(word))
        var definitionCfString:Unmanaged<CFString>! = DCSCopyTextDefinition(nil, word, range)
        var definition = definitionCfString.takeRetainedValue() as String
        return definition
    }

// MARK: - UI Actions
    
    @IBAction func didClickMoreButton(sender: AnyObject) {
        displayRandomWord()
    }
}


