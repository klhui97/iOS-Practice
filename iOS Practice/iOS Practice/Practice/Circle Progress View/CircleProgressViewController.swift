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
    let trackLayer = CAShapeLayer()
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
        
        setupProgressView()
        view.addSubview(percentageLabel)
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentageLabel.center = view.center
    }
}

// MARK: - Download Progress
extension CircleProgressViewController {
    
    fileprivate func setupProgressView() {
        let center = view.center
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        // track layer
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.lineCap = kCALineCapRound
        trackLayer.position = center

        view.layer.addSublayer(trackLayer)

        // progress
        progressShapeLayer.path = circularPath.cgPath
        progressShapeLayer.strokeColor = UIColor.red.cgColor
        progressShapeLayer.lineWidth = 10
        progressShapeLayer.lineCap = kCALineCapRound
        progressShapeLayer.strokeEnd = 0
        progressShapeLayer.position = center
        
        progressShapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)

        view.layer.addSublayer(progressShapeLayer)
        progressShapeLayer.fillColor = UIColor.white.cgColor

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleProgressTap)))
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let precentage = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        
        OperationQueue.main.addOperation {
            print(precentage)
            self.percentageLabel.text = "\(Int(precentage * 100))%"
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
