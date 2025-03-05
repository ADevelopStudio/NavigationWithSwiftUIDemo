//
//  Payment.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import Foundation

struct Payment: Identifiable, Hashable, Decodable {
	enum TypeOfSpending: String, CaseIterable, Decodable {
		case personal
		case business
	}
	
	var id: String
	var amount: Double
	var type: TypeOfSpending
	var date: Date
	var invoiceUrl: String = "https://google.com"
}

extension Payment.TypeOfSpending {
	var imageName: String {
		switch self {
		case .personal: return "person.2"
		case .business: return "laptopcomputer"
		}
	}
}

extension Payment {
	static let example = Payment(id: "123", amount: 1000, type: .business, date: .now)
}
