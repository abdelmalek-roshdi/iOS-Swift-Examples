//
//  RxViewController.swift
//  RxSwiftDemo
//
//  Created by Abd-Elmalek on 4/24/20.
//

import UIKit
import RxSwift
import RxCocoa
class RxViewController: UIViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var throttleOutlet: UIButton!
    @IBOutlet weak var debounceOutlet: UIButton!
    @IBAction func debounce(_ sender: Any) {
//        Observable<Int>.of(1,2,3,4,5)
//            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.asyncInstance)
//            .subscribe(onNext: { (value) in
//                print(value)
//            }).disposed(by: disposeBag)
    }
    
    @IBAction func throttle(_ sender: Any) {
        
//        Observable<Int>.of(1,2,3,4,5)
//            .throttle(RxTimeInterval.seconds(1), scheduler: MainScheduler.asyncInstance)
//                   .subscribe(onNext: { (value) in
//                       print(value)
//                   }).disposed(by: disposeBag)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        throttleOutlet.rx.tap.throttle(.seconds(2), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { _ in
                print("throttle fired")
            }).disposed(by: disposeBag)
        
        debounceOutlet.rx.tap.debounce(.seconds(2), scheduler: MainScheduler.asyncInstance)
        .subscribe(onNext: { _ in
            print("debounce fired")
        }).disposed(by: disposeBag)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
