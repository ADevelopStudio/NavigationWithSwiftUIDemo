//
//  Reward.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import Foundation

struct Reward: Identifiable, Hashable, Decodable {
	var id: String
	var message: String
}

extension Reward {
	static let example = Reward(id: "123", message: "Get 25% off your next purchase!")
	
	static var examples: [Reward] {
		[
			"Get 10% off your next purchase!",
			"Earn double loyalty points on your next order!",
			"Free shipping on your next order!",
			"Buy one, get one 50% off on your next visit!",
			"Enjoy a $5 discount on your next purchase!",
			"Receive an exclusive gift with your next order!",
			"Save 15% when you refer a friend!",
			"Claim a free coffee with your next order!",
			"Unlock early access to our next sale!",
			"Get a free upgrade on your next purchase!"
		]
			.map {
				Reward(id: $0, message: $0)
			}
	}
}
