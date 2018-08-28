//
//  CircleProgressViewController.swift
//  iOS Practice
//
//  Created by david.hui on 28/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

class CircleProgressViewController: KLViewController, URLSessionDownloadDelegate {
    
    let progressShapeLayer = CAShapeLayer()
    let percentageLabel: UILabel = {
       let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Circle Progress View"
        
        safeAreaContentView.addSubview(percentageLabel)
        percentageLabel.center = safeAreaContentView.center
        percentageLabel.al_centerToView()
        
        setupProgressView()
        
    }
}

// MARK: - Download Progress
extension CircleProgressViewController {
    
    fileprivate func setupProgressView() {
        let center = safeAreaContentView.center
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 150, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        // track layer
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.lineCap = kCALineCapRound
        trackLayer.position = center
        trackLayer.fillColor = UIColor.yellow.cgColor

        safeAreaContentView.layer.addSublayer(trackLayer)

        // progress
        progressShapeLayer.path = circularPath.cgPath
        progressShapeLayer.strokeColor = UIColor.red.cgColor
        progressShapeLayer.lineWidth = 10
        progressShapeLayer.lineCap = kCALineCapRound
        progressShapeLayer.strokeEnd = 0
        progressShapeLayer.position = center
        progressShapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        progressShapeLayer.fillColor = UIColor.yellow.cgColor

        safeAreaContentView.layer.addSublayer(progressShapeLayer)

        safeAreaContentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleProgressTap)))
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let precentage = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        
        OperationQueue.main.addOperation {
            print(precentage)
            
            self.progressShapeLayer.strokeEnd = precentage
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("downloaded")
    }
    
    @objc private func handleProgressTap() {
        beginDownloadingFile()
    }
    
    private func beginDownloadingFile() {
        let configuration = URLSessionConfiguration.default
        let operationQueue = OperationQueue()
        let urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
        
        guard let url = URL(string: "https://images3.alphacoders.com/823/thumb-1920-82317.jpg") else { return }
        let downloadTask = urlSession.downloadTask(with: url)
        
        progressShapeLayer.strokeEnd = 0
        downloadTask.resume()
    }
}
