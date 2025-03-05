//
//  RepositoryTest.swift
//  NavigationDEmoTests
//
//  Created by Dmitrii Zverev on 5/3/2025.
//

import Testing
@testable import NavigationDEmo

struct RepositoryTest {
	
	private enum RepositoryTestError: Error {
		case testError
	}
	
	@Test func happyPathTest() async throws {
		let connectionManager: ConnectionManager = ConnectionManagerMock(error: nil, secondsDelay: 0)
		let repo: AppRepository = MainRepo(connectionManager: connectionManager, timeIntervalBetweenRefresing: 600)
		
		let rewards: [Reward] = try await repo.load()
		#expect(!rewards.isEmpty)
		
		let reward: Reward = try await repo.load()
		#expect(!reward.id.isEmpty)
		
		let notifications: [AppNotification] = try await repo.load()
		#expect(!notifications.isEmpty)
		
		let notification: AppNotification = try await repo.load()
		#expect(!notification.id.isEmpty)
		
		let payments: [Payment] = try await repo.load()
		#expect(!payments.isEmpty)
		
		let payment: Payment = try await repo.load()
		#expect(!payment.id.isEmpty)
	}
	
	@Test func connectionErrorTest() async throws {
		let error = RepositoryTestError.testError
		
		let connectionManager: ConnectionManager = ConnectionManagerMock(error: error, secondsDelay: 0)
		let repo: AppRepository = MainRepo(connectionManager: connectionManager, timeIntervalBetweenRefresing: 600)

		do {
			let rewards: [Reward] = try await repo.load()
			#expect(rewards.isEmpty)

			let notifications: [AppNotification] = try await repo.load()
			#expect(notifications.isEmpty)
			
			let payments: [Payment] = try await repo.load()
			#expect(payments.isEmpty)
		} catch {
			Issue.record(error)
		}
		
		await #expect(throws: RepoError.noData) {
			let _: AppNotification = try await repo.load()
		}
		
		await #expect(throws: RepoError.noData) {
			let _: Reward = try await repo.load()
		}
		
		await #expect(throws: RepoError.noData) {
			let _: Payment = try await repo.load()
		}
	}
	
	@Test func incorrectTypeForRepositoryTest() async throws {
		let error = RepositoryTestError.testError
		
		let connectionManager: ConnectionManager = ConnectionManagerMock(error: error, secondsDelay: 0)
		let repo: AppRepository = MainRepo(connectionManager: connectionManager, timeIntervalBetweenRefresing: 600)

		do {
			let rewards: [Reward] = try await repo.load()
			#expect(rewards.isEmpty)

			let notifications: [AppNotification] = try await repo.load()
			#expect(notifications.isEmpty)
			
			let payments: [Payment] = try await repo.load()
			#expect(payments.isEmpty)
		} catch {
			Issue.record(error)
		}
		
		await #expect(throws: RepoError.unknownType) {
			let _: String = try await repo.load()
		}
		
		await #expect(throws: RepoError.unknownType) {
			let _: Int = try await repo.load()
		}
		
		await #expect(throws: RepoError.unknownType) {
			let _: [String] = try await repo.load()
		}
	}
}
