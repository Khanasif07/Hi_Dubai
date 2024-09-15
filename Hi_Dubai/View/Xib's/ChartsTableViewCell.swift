//
//  ChartsTableViewCell.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 30/10/2023.
//

import UIKit
import DGCharts

public struct ShareGlucoseData: Codable {
    var sgv: Int
    var date: TimeInterval
    var direction: String?
    var insulin: String?

    init(_ dict: [String:Any]){
        self.sgv = dict["sgv"] as? Int ?? 0
        date = dict["date"] as? TimeInterval ?? 0.0
        direction = dict["direction"] as? String ?? ""
        insulin = dict["insulin"] as? String ?? "0"
    }

    public init(sgv:Int,date: TimeInterval,direction: String,insulin: String = "0"){
        self.sgv = sgv
        self.date = date
        self.direction = direction
        self.insulin = insulin
    }
}
class ChartsTableViewCell: UITableViewCell,ChartViewDelegate {

    @IBOutlet weak var cgmChartView: LineChartView!
    
    // MARK: - Variables
    //===========================
    let ScaleXMax:Float = 100.0
    var xAxisLabelCount: Int = 7
    var insulinData : [ShareGlucoseData] = []
    var cgmData : [ShareGlucoseData] = []{
        didSet{
            setDataCount(cgmData.endIndex, range: UInt32(cgmData.endIndex))
            let customXAxisRender = XAxisCustomRenderer(viewPortHandler: self.cgmChartView.viewPortHandler,
                                                        xAxis: cgmChartView.xAxis,
                                                        transformer: self.cgmChartView.getTransformer(forAxis: .left),
                                                        cgmData: self.cgmData,insulinData: self.insulinData)
            self.cgmChartView.xAxisRenderer = customXAxisRender
        }
    }
    
    // MARK: - Lifecycle
    //===========================
    override func awakeFromNib() {
        super.awakeFromNib()
        newChartSetUp()
    }
    
    func formatPillText(line1: String, time: TimeInterval) -> String {
        let dateFormatter = DateFormatter()
        //let timezoneOffset = TimeZone.current.secondsFromGMT()
        //let epochTimezoneOffset = value + Double(timezoneOffset)
        if dateTimeUtils.is24Hour() {
            dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
        } else {
            dateFormatter.setLocalizedDateFormatFromTemplate("hh:mm")
        }
        
        //let date = Date(timeIntervalSince1970: epochTimezoneOffset)
        let date = Date(timeIntervalSince1970: time)
        let formattedDate = dateFormatter.string(from: date)
        
        return line1 + "\r\n" + formattedDate.lowercased()
    }
    
    private func newChartSetUp(){
        cgmChartView.clear()
        //
        let customXAxisRender = XAxisCustomRenderer(viewPortHandler: self.cgmChartView.viewPortHandler,
                                                    xAxis: cgmChartView.xAxis,
                                                    transformer: self.cgmChartView.getTransformer(forAxis: .left),
                                                    cgmData: self.cgmData,insulinData: self.insulinData)
        self.cgmChartView.xAxisRenderer = customXAxisRender
        //
        cgmChartView.delegate = self
        cgmChartView.drawMarkers = true
        
        cgmChartView.chartDescription.enabled = true
        cgmChartView.dragEnabled = true
        cgmChartView.setScaleEnabled(false)
        cgmChartView.pinchZoomEnabled = false
        
        let xAxis = cgmChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = AppFonts.Regular.withSize(11.0)
        xAxis.granularity = 1.0
        xAxis.labelTextColor = #colorLiteral(red: 0.4509803922, green: 0.462745098, blue: 0.4862745098, alpha: 1)
//        xAxis.drawAxisLineEnabled = true
        xAxis.labelPosition = XAxis.LabelPosition.bottom
//        xAxis.valueFormatter = AxisValueFormatter()
//        ChartXValueFormatterSessionInfo()
        
        let leftAxis = cgmChartView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.labelTextColor = #colorLiteral(red: 0.4509803922, green: 0.462745098, blue: 0.4862745098, alpha: 1)
        leftAxis.labelFont = AppFonts.Regular.withSize(11.0)
        leftAxis.axisMaximum = Double(500.0)
        //MARK: - Important
        leftAxis.drawGridLinesEnabled = false
        leftAxis.granularityEnabled = false
        leftAxis.granularity = 100.0
        leftAxis.drawAxisLineEnabled = false
        leftAxis.axisMinimum = 0
        leftAxis.drawLimitLinesBehindDataEnabled = false
        leftAxis.axisLineDashLengths = [5,5]
        let marker = BalloonMarker(color: #colorLiteral(red: 0.2705882353, green: 0.7843137255, blue: 0.5803921569, alpha: 1),
                                   font: AppFonts.Bold.withSize(13.0),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 3.5, left: 5.5, bottom: 16, right: 5.5))
        marker.chartView = cgmChartView
        marker.minimumSize = CGSize(width: 50.0, height: 30.0)
        cgmChartView.marker = marker
        
        cgmChartView.xAxis.centerAxisLabelsEnabled = false
        cgmChartView.xAxis.setLabelCount(xAxisLabelCount, force: false) //enter the number of labels here
        cgmChartView.leftAxis.setLabelCount(5, force: false) //enter the number of labels here
//        cgmChartView.xAxis. = true
        cgmChartView.legend.form = .none
        
        cgmChartView.zoom(scaleX: (0.013888888888889) * CGFloat(cgmData.endIndex), scaleY: 0, x: 0, y: 0)
        cgmChartView.animate(yAxisDuration: 2.5)
        cgmChartView.noDataText = "No glucose data available."
        cgmChartView.noDataTextColor = #colorLiteral(red: 0.2705882353, green: 0.7843137255, blue: 0.5803921569, alpha: 1)
        cgmChartView.noDataFont = AppFonts.Bold.withSize(15.0)
        cgmChartView.setExtraOffsets(left: 10, top: 0, right: 25, bottom: 0)
        
        cgmChartView.rightAxis.enabled = false
        cgmChartView.rightAxis.labelTextColor = NSUIColor.label
        cgmChartView.rightAxis.labelPosition = YAxis.LabelPosition.outsideChart
        cgmChartView.rightAxis.axisMinimum = 0.0
        cgmChartView.rightAxis.gridLineDashLengths = [5,5]
        cgmChartView.rightAxis.drawGridLinesEnabled = true
//                cgmChartView.rightAxis.valueFormatter = ChartYMMOLValueFormatter()
        cgmChartView.rightAxis.granularityEnabled = true
        cgmChartView.rightAxis.granularity = 50
        cgmChartView.rightAxis.axisLineDashLengths = [5,5]
//        cgmChartView.xAxis.axisLineDashLengths = [5,5]
        cgmChartView.leftAxis.axisLineDashLengths = [5,5]
        
        //Add lower red line based on low alert value
        let ll = ChartLimitLine()
        ll.limit = Double(70.0)
        ll.lineColor = NSUIColor.systemRed.withAlphaComponent(0.5)
        cgmChartView.rightAxis.addLimitLine(ll)
        
        //Add upper yellow line based on low alert value
        let ul = ChartLimitLine()
        ul.limit = Double(180.0)
        ul.lineColor = NSUIColor.systemYellow.withAlphaComponent(0.5)
        cgmChartView.rightAxis.addLimitLine(ul)
        
        cgmChartView.maxHighlightDistance = 15.0
        cgmChartView.legend.enabled = false
        cgmChartView.scaleYEnabled = false
        cgmChartView.drawGridBackgroundEnabled = true
//        cgmChartView.gridBackgroundColor = NSUIColor.clear
//        cgmChartView.data?.highlightEnabled = true
        cgmChartView.highlightValue(nil, callDelegate: false)
        cgmChartView.moveViewToAnimated(xValue: dateTimeUtils.getNowTimeIntervalUTC() - (cgmChartView.visibleXRange * 0.7), yValue: 0.0, axis: .right, duration: 1, easingOption: .easeInBack)
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        cgmChartView.zoom(scaleX: (0.013888888888889) * CGFloat(cgmData.endIndex), scaleY: 0, x: 0, y: 0)
        var colors = [NSUIColor]()
        var mainChart = [ChartDataEntry]()
        for i in 0..<cgmData.count{
            let value = ChartDataEntry(x: Double(cgmData[i].sgv), y: Double(cgmData[i].sgv), data: formatPillText(line1: "asif khan", time: cgmData[i].date))
            mainChart.append(value)
            if Double(cgmData[i].sgv) >= Double(180.0) {
                colors.append(NSUIColor.systemYellow)
            } else if Double(cgmData[i].sgv) <= Double(70) {
                colors.append(NSUIColor.systemRed)
            } else {
                colors.append(NSUIColor.systemGreen)
            }
        }
        
        let set1 = LineChartDataSet(entries: mainChart, label: "")
        set1.highlightColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1) // color of the line
        set1.highlightLineWidth = 1.0
        set1.drawHorizontalHighlightIndicatorEnabled = true // hide horizontal line
        set1.drawVerticalHighlightIndicatorEnabled = true
//        set1.lineDashLengths = [5,5]
        //
        set1.colors.removeAll()
        set1.circleColors.removeAll()
        
        if colors.count > 0 {
            for i in 0..<colors.count{
                set1.addColor(colors[i])
                set1.circleColors.append(colors[i])
            }
        }
        set1.notifyDataSetChanged()
        cgmChartView.data?.notifyDataChanged()
        cgmChartView.notifyDataSetChanged()
        //
        set1.drawIconsEnabled = false
        setup(set1)
        
        let gradientColors = [#colorLiteral(red: 0.2705882353, green: 0.7843137255, blue: 0.5803921569, alpha: 0).cgColor,#colorLiteral(red: 0.2705882353, green: 0.7843137255, blue: 0.5803921569, alpha: 1).cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)
        set1.fillAlpha = 1.0
        set1.circleRadius = 5.0
        set1.drawCirclesEnabled = true
        set1.fill = LinearGradientFill(gradient: gradient!)
        set1.drawFilledEnabled = true
        set1.drawValuesEnabled = false
        
        let data = LineChartData(dataSet: set1)
        cgmChartView.data = data
        // Move to current reading everytime new readings load
    }
    
    private func setup(_ dataSet: LineChartDataSet) {
        //            dataSet.setColor(#colorLiteral(red: 0.2705882353, green: 0.7843137255, blue: 0.5803921569, alpha: 1))
        //            dataSet.setCircleColor(.clear)
        dataSet.lineWidth = 2.5
        dataSet.circleRadius = 5.0
        dataSet.drawCircleHoleEnabled = true
        dataSet.valueFont = AppFonts.Regular.withSize(12.0)
        dataSet.formLineWidth = 2.5
        dataSet.formSize = 15
    }
}

//MARK:- ChartViewDelegate
//===============================
extension ChartsTableViewCell{
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        if chartView != cgmChartView {
            cgmChartView.moveViewToX(entry.x)
        }
        if entry.data as? String == "hide"{
            chartView.highlightValue(nil, callDelegate: false)
        }
    }
    
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        print("Chart Scaled: \(cgmChartView.scaleX), \(cgmChartView.scaleY)")
        
        // dont store huge values
        var scale: Float = Float(cgmChartView.scaleX)
        if(scale > ScaleXMax ) {
            scale = ScaleXMax
        }
        //MARK:- IMPORTANT
        //        UserDefaultsRepository.chartScaleX.value = Float(scale)
    }
}
