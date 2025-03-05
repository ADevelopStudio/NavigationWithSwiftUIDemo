//
//  AppNotification.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import Foundation


struct AppNotification: Identifiable, Hashable, Decodable {
	var id: String
	var text: String
	private var url: String
}


extension AppNotification {
	var deepLink: DeepLink? {
		let components = url.split(separator: "/")
		guard components.count == 2, let id = components.last.map(String.init) else { return nil }
		switch components.first {
		case "payment":
			return .paymentId(id: id)
		case "reward":
			return .rewardId(id: id)
		default:
			return nil
		}
	}
	
	static var examples: [AppNotification] {
		[
			.init(id: "123", text: "New reward unlocked", url: "/reward/5678"),
			.init(id: "124", text: "$456 payment to JB HiFi", url: "/payment/1234"),
			.init(id: "126", text: "$10.000 salary received", url: "/payment/12345"),
		]
	}
}


