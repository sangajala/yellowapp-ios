//
//  ReportProtocol.swift
//  MCA
//
//  Created by Goutham Devaraju on 30/08/19.
//  Copyright © 2019 Bananaapps. All rights reserved.
//

import Foundation

protocol ReportPresenterProtocol: class {
    func sendReportDetails(comments: String, user_id: Int, categoryType : CategoryType)
    
}

protocol ReportViewProtocol: class {
     func responseReportData(reportModel: ReportModel)
}
