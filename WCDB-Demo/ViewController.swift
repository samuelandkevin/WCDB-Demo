//
//  ViewController.swift
//  WCDB-Demo
//
//  Created by 黄坤鹏 on 2020/4/19.
//  Copyright © 2020 黄坤鹏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let machPath = CommandLine.arguments.first!
       
//        let baseDirectory = URL(fileURLWithPath: machPath).deletingLastPathComponent().appendingPathComponent("SampleDB").path
     
        let baseDirectory = FileManager.default.urls(for: .documentDirectory,
            in: .userDomainMask).last!.appendingPathComponent("EasyAtHome").path
        print("Base Directory: \(baseDirectory)")
//        sample_orm_main(baseDirectory: baseDirectory)
//        sample_chailcall_main(baseDirectory: baseDirectory)
//        sample_convenient_main(baseDirectory: baseDirectory)
//        sample_transaction_main(baseDirectory: baseDirectory)
//        sample_advance_main(baseDirectory: baseDirectory)
//        sample_core_main(baseDirectory: baseDirectory)
//        sample_file_main(baseDirectory: baseDirectory)
//        sample_repair_main(baseDirectory: baseDirectory)
//        sample_statistics_main(baseDirectory: baseDirectory)
//        sample_fts_main(baseDirectory: baseDirectory)
        
        sample_table_main(baseDirectory: baseDirectory)
    }


}

