//
//  AccountModel.swift
//  BabiesList
//
//  Created by Trainee on 4/8/25.
//

import Foundation

public struct AccountModel: Codable {
  let partitionKey: String?
  let rangeKey: String?
  let title: String?
  let description: String?
  let metadata: String?
  let type: String?
  let created: String?
  let modified: String?
  let status: String?
}
