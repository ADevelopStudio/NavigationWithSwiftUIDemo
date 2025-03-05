//
//  ConnectionManagerTest.swift
//  NavigationDEmoTests
//
//  Created by Dmitrii Zverev on 5/3/2025.
//

import Testing
@testable import NavigationDEmo

struct ConnectionManagerTest {
	
	private enum ConnectionManagerTestError: Error {
		case testError
	}
	
	@Test func happyPathTest() async throws {
		let connectionManager: ConnectionManager = ConnectionManagerMock(error: nil, secondsDelay: 0)
		let notifications = try await connectionManager.getAllNotifications()
		#expect(notifications.count == 3)
		
		let payments = try await connectionManager.getAllPayments()
		#expect(!payments.isEmpty)
		
		let paymentId = "123"
		let payment = try await connectionManager.getPaymentDetails(paymentId: paymentId)
		#expect(payment.id == paymentId)
		
		
		let rewards = try await connectionManager.getAllRewards()
		#expect(rewards == Reward.examples)
		
		let randomReward = try await connectionManager.getRewardDetails(rewardId: "123")
		#expect(!randomReward.id.isEmpty)
		#expect(!randomReward.message.isEmpty)
	}
	
	@Test func connectionErrorTest() async throws {
		let error = ConnectionManagerTestError.testError
		
		let connectionManager: ConnectionManager = ConnectionManagerMock(error: error, secondsDelay: 0)
		
		await #expect(throws: error) {
			let _ = try await connectionManager.getAllNotifications()
		}
		await #expect(throws: error) {
			let _ = try await connectionManager.getAllPayments()
		}
		await #expect(throws: error) {
			let _ = try await connectionManager.getPaymentDetails(paymentId: "paymentId")
		}
		await #expect(throws: error) {
			let _ = try await connectionManager.getAllRewards()
		}
		await #expect(throws: error) {
			let _ = try await connectionManager.getRewardDetails(rewardId: "123")
		}
	}

}
