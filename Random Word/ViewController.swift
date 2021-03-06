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
    var currentWord = ""
    
    @IBOutlet var wordLabel: NSTextField!
    
// MARK: - Lifecycle methods
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            self.loadWords()
            dispatch_async(dispatch_get_main_queue()) {
                self.displayRandomWord()
            }
        }
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
    }
    
    func pickRandomWord() -> String! {
        var randomWord = words.randomItem()
        return randomWord
    }
    
    func defineWithSystemDictionary(word: String) -> String! {
        // Returns the definition of a word
        // as a Swift String
        //
        // Not currently called in any way
        
        var range = CFRangeMake(0, count(word))
        var definitionCfString:Unmanaged<CFString>! = DCSCopyTextDefinition(nil, word, range)
        var definition = definitionCfString.takeRetainedValue() as String
        return definition
    }

// MARK: - UI Actions
    
    @IBAction func didClickNextButton(sender: AnyObject) {
        displayRandomWord()
    }
}


