//
//  ConnectionManager.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 5/3/2025.
//

import Foundation

protocol ConnectionManager {
	func getAllPayments() async throws -> [Payment]
	func getPaymentDetails(paymentId: String) async throws -> Payment
	func getAllNotifications() async throws -> [AppNotification]
	func getAllRewards() async throws -> [Reward]
	func getRewardDetails(rewardId: String) async throws -> Reward
}

struct ConnectionManagerMock {
	static let shared = ConnectionManagerMock()
	
	fileprivate var error: Error?
	fileprivate var secondsDelay: UInt64
	
	init(error: Error? = nil, secondsDelay: UInt64 = 3) {
		self.error = error
		self.secondsDelay = secondsDelay
	}
}

extension ConnectionManagerMock: ConnectionManager {
	func getAllPayments() async throws -> [Payment] {
		if let error { throw error }
		try await Task.sleep(nanoseconds: secondsDelay * 1_000_000_000)
		return (0..<Int.random(in: 3...30))
			.map {
				Payment(
					id: UUID().uuidString,
					amount: .random(in: 10..<1_000),
					type: Payment.TypeOfSpending.allCases.randomElement() ?? .personal,
					date: .now.addingTimeInterval(Double(-$0) * 24 * 60 * 60)
				)
			}
	}
	
	func getPaymentDetails(paymentId: String) async throws -> Payment {
		if let error { throw error }
		try await Task.sleep(nanoseconds: secondsDelay * 1_000_000_000)
		return Payment(
			id: paymentId,
			amount:  .random(in: 10..<1_000),
			type: Payment.TypeOfSpending.allCases.randomElement() ?? .personal,
			date: .now
		)
	}
	
	func getAllNotifications() async throws -> [AppNotification] {
		if let error { throw error }
		try await Task.sleep(nanoseconds: secondsDelay * 1_000_000_000)
		return AppNotification.examples
	}
	
	func getAllRewards() async throws -> [Reward] {
		if let error { throw error }
		try await Task.sleep(nanoseconds: secondsDelay * 1_000_000_000)
		return Reward.examples
	}
	
	func getRewardDetails(rewardId: String) async throws -> Reward {
 		if let error { throw error }
		try await Task.sleep(nanoseconds: secondsDelay * 1_000_000_000)
		return Reward.examples.randomElement() ?? .example
	}
	
}
