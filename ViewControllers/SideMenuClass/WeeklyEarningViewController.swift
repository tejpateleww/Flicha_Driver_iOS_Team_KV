//
//  WeeklyEarningViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excelent iMac on 09/12/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
//import Charts

class WeeklyEarningViewController: ParentViewController, UIScrollViewDelegate, ChartViewDelegate {

    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    var dataOfWeeklyEarnings = [String : AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollViewObj.delegate = self
       
        webserviceCallForWeeklyEarnings()
        
       

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
    

    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    @IBOutlet weak var scrollViewObj: UIScrollView!
    
    @IBOutlet weak var lblCurrentBalanceInfo: UILabel!
    @IBOutlet weak var lblWeeklyTotal: UILabel!
    @IBOutlet weak var btnTotal: UIButton!
    @IBOutlet weak var btnRides: UIButton!
    @IBOutlet weak var btnTickPay: UIButton!
    @IBOutlet weak var btnDispatch: UIButton!
    
    @IBOutlet var lblEarnings: [UILabel]!
    @IBOutlet var weeklyEarningConstraint: NSLayoutConstraint!
    
    @IBOutlet var lblDurations: [UILabel]!
    
    @IBOutlet var lblCurrentBalance: [UILabel]!
    
    
    @IBOutlet var TotalViewbarChart: [BarChartView]!
    
    
    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------
    
    @IBAction func btnTotal(_ sender: UIButton) {
        scrollViewObj.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        setButtonTotal()
    }
    @IBAction func btnRides(_ sender: UIButton) {
        scrollViewObj.setContentOffset(CGPoint(x: self.view.frame.size.width, y: 0), animated: true)
        setButtonRides()
    }
    @IBAction func btnTickPay(_ sender: UIButton) {
        scrollViewObj.setContentOffset(CGPoint(x: self.view.frame.size.width * 2, y: 0), animated: true)
        setButtonTickPay()
    }
    @IBAction func btnDispatch(_ sender: UIButton) {
        scrollViewObj.setContentOffset(CGPoint(x: self.view.frame.size.width * 3, y: 0), animated: true)
        setButtonDispatch()
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Custom Methods
    //-------------------------------------------------------------
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        
        
        print("pageNumber : \(pageNumber)")
        
        if pageNumber == 0.0 {
            setButtonTotal()
        }
        else if pageNumber == 1.0 {
            setButtonRides()
        }
        else if pageNumber == 2.0 {
            setButtonTickPay()
        }
        else if pageNumber == 3.0  {
            setButtonDispatch()
        }
        
    }
    
    func setButtonTotal()
    {
        
        btnTotal.setTitleColor(ThemeYellowColor, for: .normal)
        btnRides.setTitleColor(ThemeGrayColor, for: .normal)
        btnTickPay.setTitleColor(ThemeGrayColor, for: .normal)
        btnDispatch.setTitleColor(ThemeGrayColor, for: .normal)
        
        self.setDataCount(dataString: "total", indexOfPosition: 0)

    }
    
    func setButtonRides() {
        btnTotal.setTitleColor(ThemeGrayColor, for: .normal)
        btnRides.setTitleColor(ThemeYellowColor, for: .normal)
        btnTickPay.setTitleColor(ThemeGrayColor, for: .normal)
        btnDispatch.setTitleColor(ThemeGrayColor, for: .normal)
        self.setDataCount(dataString: "rides", indexOfPosition: 1)

        
        
    }
    
    func setButtonTickPay() {
        btnTotal.setTitleColor(ThemeGrayColor, for: .normal)
        btnRides.setTitleColor(ThemeGrayColor, for: .normal)
        btnTickPay.setTitleColor(ThemeYellowColor, for: .normal)
        btnDispatch.setTitleColor(ThemeGrayColor, for: .normal)
        self.setDataCount(dataString: "tickpay", indexOfPosition: 2)

    }
    
    func setButtonDispatch() {
        btnTotal.setTitleColor(ThemeGrayColor, for: .normal)
        btnRides.setTitleColor(ThemeGrayColor, for: .normal)
        btnTickPay.setTitleColor(ThemeGrayColor, for: .normal)
        btnDispatch.setTitleColor(ThemeYellowColor, for: .normal)
        self.setDataCount(dataString: "dispatch", indexOfPosition: 3)

    }
    
    //-------------------------------------------------------------
    // MARK: - Charts Methods
    //-------------------------------------------------------------

    func DrawTotalBarChart() {
        
        for customViews: BarChartView in TotalViewbarChart {
            
            self.setup(barLineChartView: customViews)
            
            customViews.delegate = self
            
            customViews.animate(yAxisDuration: 4)
            
            customViews.drawBarShadowEnabled = false
            customViews.drawValueAboveBarEnabled = false
            
            customViews.maxVisibleCount = 60
            
            let xAxis = customViews.xAxis
            xAxis.labelPosition = .bottom
            xAxis.labelFont = .systemFont(ofSize: 10)
            xAxis.granularity = 1
            xAxis.labelCount = 5
            xAxis.valueFormatter = DayAxisValueFormatter(chart: customViews)
            
    
            let leftAxisFormatter = NumberFormatter()
            leftAxisFormatter.minimumFractionDigits = 0
            leftAxisFormatter.maximumFractionDigits = 1
            leftAxisFormatter.negativeSuffix = "\(currency)"   // " $"
            leftAxisFormatter.positiveSuffix = "\(currency)"   // " $"
            
            let leftAxis = customViews.leftAxis
            leftAxis.labelFont = .systemFont(ofSize: 10)
            leftAxis.labelTextColor = UIColor.white
            leftAxis.labelCount = 8
            leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
            leftAxis.labelPosition = .outsideChart
            leftAxis.spaceTop = 0.15
            leftAxis.axisMinimum = 0 // FIXME: HUH?? this replaces startAtZero = YES
/*
            let rightAxis = customViews.rightAxis
            rightAxis.enabled = true
            rightAxis.labelFont = .systemFont(ofSize: 10)
            rightAxis.labelTextColor = UIColor.white
            rightAxis.labelCount = 8
            rightAxis.valueFormatter = leftAxis.valueFormatter
            rightAxis.spaceTop = 0.15
            rightAxis.axisMinimum = 0
*/
            let l = customViews.legend
            l.horizontalAlignment = .left
            l.verticalAlignment = .bottom
            l.orientation = .horizontal
            l.drawInside = false
            l.form = .circle
            l.formSize = 5
            l.textColor = UIColor.white
            l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
            l.xEntrySpace = 4
//            customViews.legend = l
            
            let marker = XYMarkerView(color: UIColor(white: 180/250, alpha: 1),
                                      font: .systemFont(ofSize: 12) ,
                                      textColor: .white,
                                      insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8),
                                      xAxisValueFormatter: customViews.xAxis.valueFormatter!)
            marker.chartView = customViews
            marker.minimumSize = CGSize(width: 80, height: 40)
            
            customViews.marker = marker
            self.setDataCount(dataString: "total", indexOfPosition: 0)
//            break
        }
     
    }
    
    func setup(barLineChartView chartView: BarLineChartViewBase) {
        chartView.chartDescription?.enabled = false
        
        chartView.dragEnabled = false
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = false
    
        // ChartYAxis *leftAxis = chartView.leftAxis;
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        
        xAxis.labelTextColor = UIColor.white
        chartView.rightAxis.enabled = false
    }
    
    func setDataCount(dataString: String, indexOfPosition: Int) {
        let start = 0
        let data = self.dataOfWeeklyEarnings["earning"] as! [String : AnyObject]
        
//        var totalHeight: Double = Double()
        var total = Double()
        for i in 0..<(data[dataString] as! [[String : String]]).count
       {
            let dict = ((data[dataString] as! NSArray).object(at: i)) as! NSDictionary
            total = total + Double(dict.allValues[0] as! String)!
            print("The total is \(total)")
        }
     

        lblEarnings[indexOfPosition].text = String("\(currency)\(total)")
        var days = [String]()
        let yVals = (start..<(data[dataString]! as AnyObject).count).map { (i) -> BarChartDataEntry in
            let dict = data[dataString] as! [[String:AnyObject]]
            let values = ((dict as NSArray).object(at: i) as! NSDictionary).allValues
            let keys = ((dict as NSArray).object(at: i) as! NSDictionary).allKeys

            var arrValues = [String]()
            var arrKeys = [String]()
            arrKeys.append(keys[0] as! String)
            arrValues.append(values[0] as! String)
            days.append(arrKeys[0] )
            return BarChartDataEntry(x: Double(i), y: Double((arrValues[0] as NSString).doubleValue))
        }
        
        for customViews: BarChartView in TotalViewbarChart {
            customViews.animate(yAxisDuration: 0.5)
            var set1: BarChartDataSet! = nil
            if let set = customViews.data?.dataSets.first as? BarChartDataSet {
                set1 = set
                set1.values = yVals
                set1.colors = ChartColorTemplates.material()
                set1.valueTextColor = UIColor.white
                set1.drawValuesEnabled = true
                
                customViews.chartDescription?.enabled = false
                customViews.data?.notifyDataChanged()
                customViews.notifyDataSetChanged()
                customViews.legend.textColor = UIColor.white
                customViews.xAxis.valueFormatter = IndexAxisValueFormatter(values: days)
                customViews.drawValueAboveBarEnabled = true
                let data = BarChartData(dataSet: set1)
                data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
                data.barWidth = 0.9
                
                let format = NumberFormatter()
                format.negativePrefix = "\(currency)"
                format.positivePrefix = "\(currency)"
                
                let formatter = DefaultValueFormatter(formatter: format)
                data.setValueFormatter(formatter)
                customViews.data = data
            } else {
                set1 = BarChartDataSet(values: yVals, label: "Weekly Pay")
                set1.valueTextColor = UIColor.white
                set1.colors = ChartColorTemplates.material()
                set1.drawValuesEnabled = true
                
                customViews.chartDescription?.enabled = false
                customViews.data?.notifyDataChanged()
                customViews.notifyDataSetChanged()
                customViews.drawValueAboveBarEnabled = true
                
                let data = BarChartData(dataSet: set1)
                customViews.xAxis.valueFormatter = IndexAxisValueFormatter(values: days)
                data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
                data.barWidth = 0.9
                let format = NumberFormatter()
                format.negativePrefix = "\(currency)"
                format.positivePrefix = "\(currency)"
                
                let formatter = DefaultValueFormatter(formatter: format)
                
                data.setValueFormatter(formatter)
                customViews.data = data
            }
            
        }
        
        //        chartView.setNeedsDisplay()
    }
    
  
/*
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        print(highlight)
        print(highlight.axis)
        print(highlight.y)
        print(entry)
        print(entry.x)
        
    }
*/
    
    func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    
    //-------------------------------------------------------------
    // MARK: - Webservice call For Weekly Earnings
    //-------------------------------------------------------------
    
    @IBOutlet var lblCurrentBalance1: UILabel!
    func webserviceCallForWeeklyEarnings()
    {
        webserviceForWeeklyEarnings(Singletons.sharedInstance.strDriverID as AnyObject) { (result, status) in
            if (status) {
                print(result)
                
                self.dataOfWeeklyEarnings = (result as! [String:AnyObject])
                let currentBalance = (Singletons.sharedInstance.dictDriverProfile["profile"] as! [String : AnyObject])["Balance"]!
                
                for label in self.lblCurrentBalance
                {
                    label.text = String("\(currency) \(String(format: "%.2f",Double(currentBalance as! String)!))")
                }
//                self.lblCurrentBalance1.text = String("\(currency) \(String(describing: (Singletons.sharedInstance.dictDriverProfile["profile"] as! [String : AnyObject])["Balance"]!))")
                let startDate = self.dataOfWeeklyEarnings["start_date"]
                let endDate = self.dataOfWeeklyEarnings["end_date"]
                let anotherStartDate = self.getDateAndMonth(date: startDate as! String)
                let anotherEndDate = self.getDateAndMonth(date: endDate as! String)
                self.lblDurations[0].text = "\(anotherStartDate.dayNumber)\(anotherStartDate.monthString)" + "-" + "\(anotherEndDate.dayNumber)\(anotherEndDate.monthString)"
                 self.DrawTotalBarChart()
            }
            else {
                print(result)
                
            }
            
        }
    }

    func getDateAndMonth(date: String) -> (dayNumber : String, monthString : String ) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.init(abbreviation: "GMT")
        
        let dateFromString = dateFormatter.date(from: date)
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "MMMM"
        let strMonth = (dateFormatter1.string(from: dateFromString!) as String).prefix(3)
        
        
        var day  = "\(dateFromString!.day)"
        switch (day) {
        case "1" , "21" , "31":
            day.append("st")
        case "2" , "22":
            day.append("nd")
        case "3" ,"23":
            day.append("rd")
        default:
            day.append("th")
        }
        
        return(day,String(strMonth) )
    }

}

