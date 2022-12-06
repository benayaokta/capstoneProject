//
//  DetailViewController.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 06/12/22.
//

import UIKit
import Stevia
import Charts

final class DetailViewController: UIViewController {
    
    private var viewModel: DetailViewModelProtocol?
    let chartView: LineChartView = LineChartView()
    var months: [String]!
    
    let data: AllPairs
    
    init(data: AllPairs) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
 
    required init?(coder: NSCoder) {
        fatalError("init coder must be initialize")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        injection()
        setupHierarchy()
        setupComponent()
        getInitialAPI()
        setupCombine()
//        chartEntry()
        
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 12.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
                
        setChart(dataPoints: months, values: unitsSold)
    }
    
    private func injection() {
        viewModel = DetailViewModel(repo: DetailRepo())
    }
    
    private func setupHierarchy() {
        self.view.subviews {
            chartView
        }
        
        chartView.fillContainer(padding: 16).heightEqualsWidth().centerVertically().centerHorizontally()
    }
    
    private func setupComponent() {
        self.title = data.coinDescription
        self.view.backgroundColor = .white
    }
    
    private func getInitialAPI() {
//        viewModel?.getOrderBook(id: data.coinID)
        viewModel?.getDepth(id: data.coinID)
    }
    
    private func setupCombine() {
        
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        chartView.noDataText = "You need to provide data for the chart."
        var dataEntries: [ChartDataEntry] = [
            ChartDataEntry(x: 1.0, y: 3.0),
            ChartDataEntry(x: 2.0, y: 4.0),
            ChartDataEntry(x: 4.0, y: 5.0),
            ChartDataEntry(x: 6.0, y: 6.0),
            ChartDataEntry(x: 8.0, y: 7.0),
            ChartDataEntry(x: 9.0, y: 8.0),
            ChartDataEntry(x: 10.0, y: 3.0),
            ChartDataEntry(x: 11.0, y: 2.0),
            ChartDataEntry(x: 12.0, y: 4.0)
        ]
                
//        for i in 0..<dataPoints.count {
////            let dataEntry = BarChartDataEntry(x: values[i], y: i)
//            let dataEntry = BarChartDataEntry(x: values[i], y: values[i]-1.0)
//
//            dataEntries.append(dataEntry)
//        }
//
//        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Units Sold")
//        let chartData = BarChartData(dataSet: chartDataSet)
//        chartView.data = chartData
        
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Unit Sold")
        
        let chartData = LineChartData(dataSet: chartDataSet)
        
        chartView.data = chartData
        
        
        chartView.animate(xAxisDuration: 2.0)
    }
}
