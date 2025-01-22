//
//  ProtocolsData.swift
//  UIKit section
//
//  Created by murad on 22.01.2025.
//

import UIKit

// 1. Single Responsibility Principle (SRP)
// Каждый класс/протокол отвечает за одну задачу

protocol DataSaver {
    associatedtype DataType
    func save(_ data: DataType, forKey key: String)
    func load(forKey key: String) -> DataType?
}
