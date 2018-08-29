//
//  CircleProgressViewController.swift
//  iOS Practice
//
//  Created by david.hui on 28/8/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit

fileprivate extension CircleProgressViewController {
    static let DidFinishDownloadingImage = NSNotification.Name(rawValue: "DidFinishDownloadingImage")
}

fileprivate extension UIColor {
    
    static let backgroundColor = UIColor.rgb(r: 21, g: 22, b: 33)
    static let outlineStrokeColor = UIColor.rgb(r: 234, g: 46, b: 111)
    static let trackStrokeColor = UIColor.rgb(r: 56, g: 25, b: 49)
    static let pulsatingFillColor = UIColor.rgb(r: 86, g: 30, b: 63)
    
}

class CircleProgressViewController: KLViewController, URLSessionDownloadDelegate {
    
    let progressShapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    let pulsatingLayer = CAShapeLayer()
    let percentageLabel: UILabel = {
       let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Circle Progress View"
        
        initView()
        setupNotificationObservers()
        
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleDownloadCompleted), name: CircleProgressViewController.DidFinishDownloadingImage, object: nil)
    }
    
    private func initView() {
        setupProgressView()
        view.backgroundColor = .backgroundColor
        view.addSubview(percentageLabel)
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentageLabel.center = view.center
    }
    
    @objc func handleDownloadCompleted() {
        OperationQueue.main.addOperation {
            self.animatePulsatingLayer()
        }
    }
}

// MARK: - Download Progress
extension CircleProgressViewController {
    
    fileprivate func setupProgressView() {
        let center = view.center
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        // pulsating
        pulsatingLayer.path = circularPath.cgPath
        pulsatingLayer.strokeColor = UIColor.clear.cgColor
        pulsatingLayer.lineWidth = 10
        pulsatingLayer.lineCap = kCALineCapRound
        pulsatingLayer.fillColor = UIColor.pulsatingFillColor.cgColor
        pulsatingLayer.position = center
        view.layer.addSublayer(pulsatingLayer)
        
        // track layer
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.trackStrokeColor.cgColor
        trackLayer.fillColor = UIColor.backgroundColor.cgColor
        trackLayer.lineWidth = 10
        trackLayer.lineCap = kCALineCapRound
        trackLayer.position = center
        view.layer.addSublayer(trackLayer)

        // progress
        progressShapeLayer.path = circularPath.cgPath
        progressShapeLayer.strokeColor = UIColor.outlineStrokeColor.cgColor
        progressShapeLayer.fillColor = UIColor.clear.cgColor
        progressShapeLayer.lineWidth = 10
        progressShapeLayer.lineCap = kCALineCapRound
        progressShapeLayer.strokeEnd = 0
        progressShapeLayer.position = center
        progressShapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        view.layer.addSublayer(progressShapeLayer)

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleProgressTap)))
    }
    
    private func animatePulsatingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.5
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        pulsatingLayer.add(animation, forKey: "pulsing")
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
        NotificationCenter.default.post(name: CircleProgressViewController.DidFinishDownloadingImage, object: nil)
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
