//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by Abd-Elmalek on 4/23/20.
//

import UIKit
import RxCocoa
import RxSwift
class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var countriesCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet private weak var slider: UISlider!
    @IBOutlet private weak var segmentedLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet private weak var sliderLabel: UILabel!
    @IBOutlet private weak var segmentedC: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.rx.value.subscribe( onNext: {[weak self] (value) in
            self?.sliderLabel.text = value.description
        }, onError: { (error) in
            print("error")
        }, onCompleted: {
            print("completed")
        }) {
            print("slider diposed")
        }.disposed(by: disposeBag)
    
    
        segmentedC.rx.selectedSegmentIndex.subscribe(onNext: {[weak self] (index) in
            
            self?.segmentedLabel.text = self?.segmentedC.titleForSegment(at: index)
            
        }, onError: { (error) in
            print("error")
        }, onCompleted: {
            print("completed")
        }) {
            print("slider diposed")
        }.disposed(by: disposeBag)
        
        
        
        
        searchBar.rx.text
        .distinctUntilChanged()
        .throttle(.milliseconds(400), scheduler: MainScheduler.asyncInstance)
        .subscribe({[weak self] (text) in
            Observable.from((self?.getPlistData())!)
             .map{ $0.name
            }.filter { $0.hasPrefix((text.element ?? "") ?? "") && (text.element!!.count > 0)}
            
            .subscribe(  onNext: {(value) in
                print(value)
                
            }).disposed(by: self?.disposeBag ?? DisposeBag())
            
            })
            
            .disposed(by: disposeBag)
        

    }

    private func setUpCollectionView(){
        Observable<[Country]>.create{observer in
                   observer.onNext(self.getPlistData())
                   
                   return Disposables.create()
        }
        .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
                   .observeOn(MainScheduler.asyncInstance)
               .bind(to: self.countriesCollectionView.rx.items(cellIdentifier: "cell", cellType: CustomCollectionViewCell.self)){index, country, cell in
                   cell.country = country
               }.disposed(by: disposeBag)
    }
        
    func getPlistData()-> [Country]{
        
               var array = [Country]()
               if let path = Bundle.main.path(forResource: "Countries", ofType: "plist") {
                 do {
                     let data = try Data(contentsOf: URL(fileURLWithPath: path))
                     let decoder = PropertyListDecoder()
                     array = try decoder.decode([Country].self, from: data)
                      
                  } catch {
                                   
                         print(error)
                 }
              }
               return array
           }
}

