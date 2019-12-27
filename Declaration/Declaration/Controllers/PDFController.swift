//
//  PDFController.swift
//  Declaration
//
//  Created by Vladyslav Kolomiets on 12/27/19.
//  Copyright © 2019 Vladyslav Kolomiets. All rights reserved.
//

import UIKit
import PDFKit

class PDFController: UIViewController {
    
    // MARK: - properties
    
    lazy var link: String? = nil
    private var pdfView: PDFView!
    
    // MARK: - override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPDFView()
        setLinkToPDFView()
    }
    
    // MARK: - private
    
    private func setPDFView() {
        self.pdfView = PDFView(frame: self.view.bounds)
        self.view.addSubview(pdfView)
        pdfView.autoScales = true
    }
    
    private func setLinkToPDFView() {
        guard let url = link else { return }
        guard let fileURL = URL(string: url) else { return }
        pdfView.document = PDFDocument(url: fileURL)
    }
}
