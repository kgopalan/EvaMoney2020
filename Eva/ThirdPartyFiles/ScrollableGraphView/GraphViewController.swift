//
//  GraphViewController.swift
//  Eva
//
//  Created by Poomalai on 10/21/17.
//  Copyright © 2017 Clover. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
    
    var graphView = ScrollableGraphView()
    var currentGraphType = GraphType.dark
    var graphConstraints = [NSLayoutConstraint]()
    
    var label = UILabel()
    var labelConstraints = [NSLayoutConstraint]()
    
    // Data
    let numberOfDataItems = 29
    var graphContainerView = UIView()
    //changes
    lazy var data: [Double] = {
        var _graphData = [Double]()
        let graphData = EvaDataController.sharedInstance.transactionResponse?.graphData ?? []
        for _data in graphData {
            _graphData.append(Double(_data.value))
        }
        return _graphData
    }()
    lazy var labels: [String] = {
        var _graphData = [String]()
        let graphData = EvaDataController.sharedInstance.transactionResponse?.graphData ?? []
        for _data in graphData {
            let category = _data.category.replacingOccurrences(of: "and", with: "&")
            _graphData.append(category)
        }
        return _graphData
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let displayType = EvaDataController.sharedInstance.currentDisplayType
        var width = self.getChartWidth()
        let x = (self.view.frame.size.width - CGFloat(width))/2
        var height = 200
        if displayType == .messageWithChart {
            width -= 15 //space
            height = 260
        }
        graphContainerView.frame = CGRect.init(x: Int(x), y: 0, width: Int(width), height: Int(height))
        
        graphView = ScrollableGraphView(frame: CGRect.init(x: 0, y: 0, width: graphContainerView.frame.size.width, height: graphContainerView.frame.size.height))
        
        currentGraphType = GraphType.bar
        graphView = createBarGraph(CGRect.init(x: 0, y: 0, width: graphContainerView.frame.size.width, height: graphContainerView.frame.size.height))
        graphView.set(data: data, withLabels: labels)
    }
    
    fileprivate func getChartWidth() -> CGFloat {
        switch UIDevice().screenType {
        case .iPhone4, .iPhone5:
            return 305.0
        case .iPhone6:
            return 360.0
        case .iPhone6Plus:
            return 399.0
        default:
            break
        }
        return 305.0
    }
    fileprivate func createDarkGraph(_ frame: CGRect) -> ScrollableGraphView {
        let graphView = ScrollableGraphView(frame: frame)
        
        graphView.backgroundFillColor = UIColor.colorFromHex(hexString: "#333333")
        
        graphView.lineWidth = 1
        graphView.lineColor = UIColor.colorFromHex(hexString: "#777777")
        graphView.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        graphView.shouldFill = true
        graphView.fillType = ScrollableGraphViewFillType.gradient
        graphView.fillColor = UIColor.colorFromHex(hexString: "#555555")
        graphView.fillGradientType = ScrollableGraphViewGradientType.linear
        graphView.fillGradientStartColor = UIColor.clear//colorFromHex(hexString: "#555555")
        graphView.fillGradientEndColor = UIColor.clear//colorFromHex(hexString: "#444444")
        graphView.backgroundFillColor = UIColor.clear//colorFromHex(hexString: "#333333")
        
        graphView.dataPointSpacing = (self.view.frame.size.width > 320) ? 60 : 40
        graphView.dataPointSize = 2
        graphView.dataPointFillColor = UIColor.white
        
        graphView.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        graphView.referenceLineColor = UIColor.white.withAlphaComponent(0.2)
        graphView.referenceLineLabelColor = UIColor.white
        graphView.numberOfIntermediateReferenceLines = 5
        graphView.dataPointLabelColor = UIColor.white.withAlphaComponent(0.5)
        
        graphView.shouldAnimateOnStartup = true
        graphView.shouldAdaptRange = true
        graphView.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        graphView.animationDuration = 1.5
        graphView.rangeMax = 50
        graphView.shouldRangeAlwaysStartAtZero = true
        
        return graphView
    }
    
    private func createBarGraph(_ frame: CGRect) -> ScrollableGraphView {
        let graphView = ScrollableGraphView(frame:frame)
        
        graphView.dataPointType = ScrollableGraphViewDataPointType.circle
        graphView.shouldDrawBarLayer = true
        graphView.shouldDrawDataPoint = false
        
        graphView.lineColor = UIColor.clear
        graphView.barWidth = 25
        graphView.barLineWidth = 1
        graphView.barLineColor = UIColor.colorFromHex(hexString: "#777777")
        graphView.barColor = UIColor.white//colorFromHex(hexString: "#555555")
        graphView.backgroundFillColor = UIColor.clear//colorFromHex(hexString: "#333333")
        
        graphView.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        graphView.referenceLineColor = UIColor.white.withAlphaComponent(0.2)
        graphView.referenceLineLabelColor = UIColor.white
        graphView.numberOfIntermediateReferenceLines = 5
        graphView.dataPointLabelColor = UIColor.white.withAlphaComponent(0.5)
        
        graphView.shouldAnimateOnStartup = true
        graphView.shouldAdaptRange = true
        graphView.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        graphView.animationDuration = 1.5
        graphView.rangeMax = 50
        graphView.dataPointSpacing = (self.view.frame.size.width > 320) ? 60 : 50
        graphView.shouldRangeAlwaysStartAtZero = true
        
        return graphView
    }
    
    
    func setupConstraints() {
        
        self.graphView.translatesAutoresizingMaskIntoConstraints = false
        graphConstraints.removeAll()
        
        let topConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.graphContainerView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.graphContainerView, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 10)
        let bottomConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.graphContainerView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.graphContainerView, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0)
        
        graphConstraints.append(topConstraint)
        graphConstraints.append(bottomConstraint)
        graphConstraints.append(leftConstraint)
        graphConstraints.append(rightConstraint)
        
        graphContainerView.addConstraints(graphConstraints)
    }
    
    
    // The type of the current graph we are showing.
    enum GraphType {
        case dark
        case bar
        case dot
        case pink
        
        mutating func next() {
            switch(self) {
            case .dark:
                self = GraphType.bar
            case .bar:
                self = GraphType.dot
            case .dot:
                self = GraphType.pink
            case .pink:
                self = GraphType.dark
            }
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}
