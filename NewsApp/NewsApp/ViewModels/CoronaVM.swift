//
//  CoronaVM.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 15.12.2021.
//

import Foundation


class CoronaVM: ObservableObject {
    private var coronaRepo: CoronaRepositoryProtocol
    @Published var coronaInfoBar1: [ChartData] = [ChartData]()
    @Published var coronaInfoBar2: [ChartData] = [ChartData]()
    @Published var coronaInfoBar3: [ChartData] = [ChartData]()
    @Published var coronaInfoBar4: [ChartData] = [ChartData]()
    
    @Published var label1: String = ""
    @Published var label2:  String = ""
    @Published var label3:  String = ""
    @Published var label4:  String = ""
    
    @Published var confirmed: String = ""
    @Published var newConf:  String = ""
    @Published var death:  String = ""
    @Published var recovered:  String = ""
    
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded
    }
    @Published private(set) var state = State.idle
    @Published private(set) var infoState = State.idle
    
    init(coronaRepo: CoronaRepositoryProtocol = CoronaRepository()) {
        self.coronaRepo = coronaRepo
    }
    
    func normalizedValue(data: [ChartData], index: Int) -> Double {
        var allValues: [Double]    {
            var values = [Double]()
            for data in data {
                if data.value == 0.0 {values.append(2000.0)}
                else{
                    values.append(data.value)
                }
            }
            return values
        }
        guard let max = allValues.max() else {
            return 1
        }
        
        if max != 0 {
            return Double(data[index].value)/Double(max)
        } else {
            return 1
        }
    }
    
    func getTotal(){
        infoState = .loading
        DispatchQueue.global(qos: .background).async { [self] in
            coronaRepo.getTotal(){ [weak self] result in
                switch result {
                case .success(let dataCorona):
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute:  {
                        self?.infoState = .loaded
                        self?.confirmed = String(dataCorona.Global.TotalConfirmed!)
                        self?.newConf = String(dataCorona.Global.NewConfirmed!)
                        self?.death = String(dataCorona.Global.TotalDeaths!)
                        self?.recovered = String(dataCorona.Global.TotalRecovered!)
                    })
                case .failure(let error):
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute:  { self?.state = .failed(error)
                    })
                }
            }
        }
    }
    
    func getDate(isoDate: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day, .year], from: date)
        let finalDate = calendar.date(from:components)
        dateFormatter.dateFormat = "dd.MMM, yyyy"
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: finalDate!)
    }
    
    func getKz(){
        state = .loading
        DispatchQueue.global(qos: .background).async { [self] in
            coronaRepo.getKz(){ [weak self] result in
                switch result {
                case .success(let dataCorona):
                    DispatchQueue.main.asyncAfter(deadline: .now() + 6.0, execute:  {
                        
                        let size = dataCorona.count
                        let subList = dataCorona[size-4..<size]
                        var data1 = [ChartData]()
                        var data2 = [ChartData]()
                        var data3 = [ChartData]()
                        var data4 = [ChartData]()
                        
                        let label1 = getDate(isoDate: String(subList[size-4].Date))
                        data1.append(ChartData(id:1, label: label1, value: Double(subList[size-4].Confirmed)))
                        data1.append(ChartData(id:2, label: label1, value: Double(subList[size-4].Active)))
                        data1.append(ChartData(id:3, label: label1, value: Double(subList[size-4].Deaths)))
                        data1.append(ChartData(id:4, label: label1, value: Double(subList[size-4].Recovered)))
                        
                        let label2 = getDate(isoDate: String(subList[size-3].Date))
                        data2.append(ChartData(id:1, label: label2, value: Double(subList[size-3].Confirmed)))
                        data2.append(ChartData(id:2, label: label2, value: Double(subList[size-3].Active)))
                        data2.append(ChartData(id:3, label: label2, value: Double(subList[size-3].Deaths)))
                        data2.append(ChartData(id:4, label: label2, value: Double(subList[size-3].Recovered)))
                        
                        let label3 = getDate(isoDate: String(subList[size-2].Date))
                        data3.append(ChartData(id:1, label: label3, value: Double(subList[size-2].Confirmed)))
                        data3.append(ChartData(id:2, label: label3, value: Double(subList[size-2].Active)))
                        data3.append(ChartData(id:3, label: label3, value: Double(subList[size-2].Deaths)))
                        data3.append(ChartData(id:4, label: label3, value: Double(subList[size-2].Recovered)))
                        
                        let label4 = getDate(isoDate: String(subList[size-1].Date))
                        data4.append(ChartData(id:1, label: label4, value: Double(subList[size-1].Confirmed)))
                        data4.append(ChartData(id:2, label: label4, value: Double(subList[size-1].Active)))
                        data4.append(ChartData(id:3, label: label4, value: Double(subList[size-1].Deaths)))
                        data4.append(ChartData(id:4, label: label4, value: Double(subList[size-1].Recovered)))
                        
                        self?.state = .loaded
                        self?.coronaInfoBar1 = data1
                        print("HEHE \(data1)")
                        print("HEHE \(data2)")
                        
                        print("HEHE \(data3)")
                        print("HEHE \(data4)")
                        self?.coronaInfoBar2 = data2
                        self?.coronaInfoBar3 = data3
                        self?.coronaInfoBar4 = data4
                        
                        self?.label1 = label1
                        self?.label2 = label2
                        self?.label3 = label3
                        self?.label4 =  label4
                    })
                case .failure(let error):
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute:  { self?.state = .failed(error)
                    })
                }
            }
        }
    }
    
}
