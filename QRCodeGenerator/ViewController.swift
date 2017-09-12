//
//  ViewController.swift
//  QRCodeGenerator
//
//  Created by MilanPanchal on 12/09/17.
//  Copyright © 2017 JeenalInfotech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var qrcodeImage: CIImage!
    
    @IBOutlet weak var qrCodeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        generateQRCode(inputText: "http://www.jeenalinfotech.com")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    fileprivate func generateQRCode(inputText: String) {
        
        if inputText == "" {
            return
        }

        // Remove any existing image
        qrCodeImageView.image = nil
        
        let data = inputText.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
        
        let filter = CIFilter(name: "CIQRCodeGenerator")!
        filter.setValue(data, forKey: "inputMessage")
        
        /* Input Correction Level - It's represent how much error correction extra data should be added to the generated QRCode
         L - 07% error resilience
         M - 15% error resilience
         Q - 25% error resilience
         H - 30% error resilience
         
         */
        
        filter.setValue("H", forKey: "inputCorrectionLevel")
        
        if let outputCIImage = filter.outputImage {
            
            let scaleX = qrCodeImageView.frame.width / outputCIImage.extent.width
            let scaleY = qrCodeImageView.frame.height / outputCIImage.extent.height
            
            let transformedImage = outputCIImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))

            qrCodeImageView.image = UIImage(ciImage: transformedImage)
        }

    }
}

