//
//  ActionViewController.swift
//  Extension1
//
//  Created by J on 2021/04/27.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var pageTitle = ""
    var pageURL = ""
    @IBOutlet var script: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let inputItems = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItems.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as  String) {[weak self] (dict, error) in
                    guard let itemDictionary = dict as? NSDictionary else { return}
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else {return}

                    self?.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageURL = javaScriptValues["URL"] as? String ?? ""
                    
                    DispatchQueue.main.async { 
                        self?.title = self?.pageTitle
                    }
                    
                }
            }
        }
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }

}
