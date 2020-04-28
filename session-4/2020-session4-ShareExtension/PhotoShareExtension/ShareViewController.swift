//
//  ShareViewController.swift
//  PhotoShareExtension
//
//  Created by T. Andrew Binkowski on 4/22/18.
//  Copyright © 2018 The University of Chicago. All rights reserved.
//
//


import UIKit
import Social
import ExtensionKit
import MobileCoreServices

/// View Controller that is presented via the share extension.  This uses the
/// default share sheet from the `Social.framework`.
class ShareViewController: SLComposeServiceViewController {
  
  override func didSelectPost() {
    printLog("📷")
    
    // This is called after the user selects Post. Do the upload of
    // contentText and/or NSExtensionContext attachments.
    
    // While it is possible to save an UIImage to a dictionary as NSData as
    // we are doing here, it is generally not a good idea.  You could store
    // image on server or in App Group folder and keep the URL of the location
    // to store
    
    // Also, note that you get the app store URL, so you could use it to get
    // the image that way.
    
    if let item = self.extensionContext?.inputItems[0] as? NSExtensionItem {
      for ele in item.attachments!{
        let itemProvider = ele as! NSItemProvider
        
        if itemProvider.hasItemConformingToTypeIdentifier("public.jpeg"){
          NSLog("itemprovider: %@", itemProvider)
          itemProvider.loadItem(forTypeIdentifier: "public.jpeg", options: nil,
                                completionHandler: { (item, error) in
            
            var imgData: Data!
            if let url = item as? URL {
              imgData = try! Data(contentsOf: url)
            }
            
            if let img = item as? UIImage {
              imgData = UIImagePNGRepresentation(img)
            }
            
            let sharedItem: NSDictionary = [ "date": Date(),
                                             "contentText": self.contentText,
                                             "imageData": imgData]
            
            LocalDefaultsManager.sharedInstance.add(object: sharedItem)
            
            
          })
        }
      }
    }
    
    // Inform the host that we're done, so it un-blocks its UI.
    // Note: Alternatively you could call super's -didSelectPost, which will similarly
    // complete the extension context.
    self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
  }
  
  override func isContentValid() -> Bool {
    // Do validation of contentText and/or NSExtensionContext attachments here
    return true
  }

  override func configurationItems() -> [Any]! {
    // To add configuration options via table cells at the bottom of the sheet,
    // return an array of SLComposeSheetConfigurationItem here.
    return []
  }
}
