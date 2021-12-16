//
//  CoronaVM.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 15.12.2021.
//

import Foundation


class CoronaVM: ObservableObject {
    private var coronaRepo: CoronaRepositoryProtocol
    @Published var coronaInfoBar: [ChartData] = [ChartData]()
    @Published var coronaInfoBarActive: [ChartData] = [ChartData]()
    @Published var coronaInfoBarDeath: [ChartData] = [ChartData]()
    @Published var coronaInfoBarRecovered: [ChartData] = [ChartData]()
    
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded
    }
    @Published private(set) var state = State.idle
    
    init(coronaRepo: CoronaRepositoryProtocol = CoronaRepository()) {
        self.coronaRepo = coronaRepo
    }
    
    func getKz(){
        state = .loading
        DispatchQueue.global(qos: .background).async { [self] in
            coronaRepo.getKz(){ [weak self] result in
                switch result {
                case .success(let dataCorona):
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute:  {
                        self?.state = .loaded
                        let size = dataCorona.count
                        let subList = dataCorona[size-4..<size]
                        var data1 = [ChartData]()
                        var data2 = [ChartData]()
                        var data3 = [ChartData]()
                        var data4 = [ChartData]()
                        
                        for info in subList{
                            data1.append(ChartData(label: String(info.Date.prefix(10)), value: Double(info.Confirmed)))
                            data2.append(ChartData(label: String(info.Date.prefix(10)), value: Double(info.Active)))
                            data3.append(ChartData(label: String(info.Date.prefix(10)), value: Double(info.Deaths)))
                            data4.append(ChartData(label: String(info.Date.prefix(10)), value: Double(info.Recovered)))
                        }
                        
                        self?.coronaInfoBar = data1
                        self?.coronaInfoBarActive = data2
                        self?.coronaInfoBarDeath = data3
                        self?.coronaInfoBarRecovered = data4
                    })
                case .failure(let error):
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute:  { self?.state = .failed(error)
                    })
                }
            }
        }
    }
    
}
