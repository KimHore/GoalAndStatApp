//
//  GraphState.swift
//  GoalAndStatApp
//
//  Created by DE DPU on 5/10/2559 BE.
//  Copyright © 2559 kimhore. All rights reserved.
//

import Foundation
import UIKit
import SwiftCharts

class GraphState : UIViewController{
    var toPass:String!
    var key:String!
    
   
    private var chart: Chart? // arc
    
    private let dirSelectorHeight: CGFloat = 50
    

    
    private func barsChart(horizontal horizontal: Bool) -> Chart {
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        let defaults = NSUserDefaults.standardUserDefaults()
                let counteventstat = defaults.stringForKey("counteventSt")!
        
        
                var goall = [Int](count: 7, repeatedValue: 0)
                var ac = [String](count: 7, repeatedValue: "")
                var datee = [String](count: 7, repeatedValue: "")
                var ntCS = Int(counteventstat)!
                var countt = 0
        
                while ntCS >= 1 {
        
        
        
                    defaults.synchronize()
                    var acname = defaults.stringForKey("AcNameSt\(ntCS)")!
        
        
                    if acname == toPass {
        
                        if countt < 7{
        
                        var goal = defaults.stringForKey("GDidSt\(ntCS)")!
        
        
                        var date = defaults.stringForKey("dateSt\(ntCS)")!
        
                        datee.insert(String(UTF8String: date)!, atIndex: countt)
                        goall.insert(Int(goal)!, atIndex: countt)
        
        
                            
                        countt = countt+1
                        }
                        
                        
              
                    }
                    
                      ntCS = ntCS-1
                }
        
    
            
        
                countt = 0
                ntCS = 0
            
        let groupsData: [(title: String, [(min: Double, max: Double)])] = [
            (datee[6], [
                (0, Double(goall[6]))
                
                ]),
            (datee[5], [
                (0, Double(goall[5]))
                
                ]),
            (datee[4], [
                
                (0, Double(goall[4]))
                ]),
            (datee[3], [
                
                (0, Double(goall[3]))
                ]),
            (datee[2], [
                
                (0, Double(goall[2]))
                ]),
            (datee[1], [
                
                (0, Double(goall[1]))
                ]),
            (datee[0], [
                
                (0, Double(goall[0]))
                ])
        ]
        
        let groupColors = [UIColor.blueColor().colorWithAlphaComponent(0.6)]
        
        let groups: [ChartPointsBarGroup] = groupsData.enumerate().map {index, entry in
            let constant = ChartAxisValueDouble(index)
            let bars = entry.1.enumerate().map {index, tuple in
                ChartBarModel(constant: constant, axisValue1: ChartAxisValueDouble(tuple.min), axisValue2: ChartAxisValueDouble(tuple.max), bgColor: groupColors[index])
            }
            return ChartPointsBarGroup(constant: constant, bars: bars)
        }
        
        var maxxx = goall[0]
        var size = goall.count-1
        
        while size > 0 {
            if maxxx < goall[size]{
                maxxx = goall[size]
            }
          
            size = size-1
        }
        let (axisValues1, axisValues2): ([ChartAxisValue], [ChartAxisValue]) = (
            0.stride(through: maxxx, by: 1).map {ChartAxisValueDouble(Double($0), labelSettings: labelSettings)},
            [ChartAxisValueString(order: -1)] +
                groupsData.enumerate().map {index, tuple in ChartAxisValueString(tuple.0, order: index, labelSettings: labelSettings)} +
                [ChartAxisValueString(order: groupsData.count)]
        )
        let (xValues, yValues) = horizontal ? (axisValues1, axisValues2) : (axisValues2, axisValues1)
        
        let defaultss = NSUserDefaults.standardUserDefaults()
       // print(key)
        let gd = defaultss.stringForKey("Goal\(key!)")!
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "วัน (กิจกรรม \(toPass) เป้าหมายคือ \(gd) ครั้ง)", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "จำนวน", settings: labelSettings.defaultVertical()))
        let frame = ExamplesDefaults.chartFrame(self.view.bounds)
        let chartFrame = self.chart?.frame ?? CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height - self.dirSelectorHeight)
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: ExamplesDefaults.chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
        
        let groupsLayer = ChartGroupedPlainBarsLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, groups: groups, horizontal: horizontal, barSpacing: 2, groupSpacing: 25, animDuration: 0.5)
        
        let settings = ChartGuideLinesLayerSettings(linesColor: UIColor.blackColor(), linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, axis: horizontal ? .X : .Y, settings: settings)
        
        return Chart(
            frame: chartFrame,
            layers: [
                xAxis,
                yAxis,
                guidelinesLayer,
                groupsLayer
            ]
        )
        }
    



   
    
    private func showChart(horizontal horizontal: Bool) {
        self.chart?.clearView()
        
        let chart = self.barsChart(horizontal: horizontal)
        self.view.addSubview(chart.view)
        self.chart = chart
    }
    
    override func viewDidLoad() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let counteventstat = defaults.stringForKey("counteventSt")!
        var checkStat = Int(counteventstat)!
        var coun = 0
        while checkStat >= 1 {
            var acname = defaults.stringForKey("AcNameSt\(checkStat)")!
             if acname == toPass {
              coun = coun+1
            }
            checkStat = checkStat-1
        }//while
        if coun == 7 {
        self.showChart(horizontal: false)
        
        if let chart = self.chart {
            let dirSelector = DirSelector(frame: CGRectMake(0, chart.frame.origin.y + chart.frame.size.height, self.view.frame.size.width, self.dirSelectorHeight), controller: self)
            self.view.addSubview(dirSelector)
        }
        }
        else {
           coun = 0
            let objAlertController = UIAlertController(title: "Warnning !! ", message: "สถิติของคุณต้องมีมากกว่า 7 ครั้ง!! ", preferredStyle: UIAlertControllerStyle.ActionSheet)
            let objAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            objAlertController.addAction(objAction)
            presentViewController(objAlertController, animated: true, completion: nil)
        }
}
    class DirSelector: UIView {
        
        let horizontal: UIButton
        let vertical: UIButton
        
        weak var controller: GraphState?
        
        private let buttonDirs: [UIButton : Bool]
        
        init(frame: CGRect, controller: GraphState) {
            
            self.controller = controller
            
            self.horizontal = UIButton()
            self.horizontal.setTitle("Horizontal", forState: .Normal)
            self.vertical = UIButton()
            self.vertical.setTitle("Vertical", forState: .Normal)
            
            self.buttonDirs = [self.horizontal : true, self.vertical : false]
            
            super.init(frame: frame)
            
            self.addSubview(self.horizontal)
            self.addSubview(self.vertical)
            
            for button in [self.horizontal, self.vertical] {
                button.titleLabel?.font = ExamplesDefaults.fontWithSize(14)
                button.setTitleColor(UIColor.blueColor(), forState: .Normal)
                button.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchUpInside)
            }
        }
        
        func buttonTapped(sender: UIButton) {
            let horizontal = sender == self.horizontal ? true : false
            controller?.showChart(horizontal: horizontal)
        }
        
        override func didMoveToSuperview() {
            let views = [self.horizontal, self.vertical]
            for v in views {
                v.translatesAutoresizingMaskIntoConstraints = false
            }
            
            let namedViews = views.enumerate().map{index, view in
                ("v\(index)", view)
            }
            
            let viewsDict = namedViews.reduce(Dictionary<String, UIView>()) {(var u, tuple) in
                u[tuple.0] = tuple.1
                return u
            }
            
            let buttonsSpace: CGFloat = Env.iPad ? 20 : 10
            
            let hConstraintStr = namedViews.reduce("H:|") {str, tuple in
                "\(str)-(\(buttonsSpace))-[\(tuple.0)]"
            }
            
            let vConstraits = namedViews.flatMap {NSLayoutConstraint.constraintsWithVisualFormat("V:|[\($0.0)]", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict)}
            
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(hConstraintStr, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict)
                + vConstraits)
        }
        
        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let defaults = NSUserDefaults.standardUserDefaults()
//        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
//        let counteventstat = defaults.stringForKey("counteventSt")!
//        
//        
//        var goall = [Int](count: 7, repeatedValue: 0)
//        var ac = [String](count: 7, repeatedValue: "")
//        var datee = [String](count: 7, repeatedValue: "")
//        var ntCS = Int(counteventstat)!
//        var countt = 7
//
//        while ntCS >= 1 {
//            
//         
//           
//            defaults.synchronize()
//            var acname = defaults.stringForKey("AcNameSt\(ntCS)")!
// 
//           
//            if acname == toPass {
//
//                if countt >= 0{
//                
//                var goal = defaults.stringForKey("GDidSt\(ntCS)")!
//             
//                    
//                var date = defaults.stringForKey("dateSt\(ntCS)")!
//
//                datee.insert(String(UTF8String: date)!, atIndex: countt)
//                goall.insert(Int(goal)!, atIndex: countt)
//              
//              
//                    if countt == 0{
//                        break;
//                    }
//                    
//                countt = countt-1
//                }
//                
//                
//      
//            }
//            
//              ntCS = ntCS-1
//        }
//        
//        countt = 0
//        ntCS = 0
//       
//
