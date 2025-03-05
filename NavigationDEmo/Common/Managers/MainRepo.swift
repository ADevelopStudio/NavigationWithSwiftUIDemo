//
//  PaymentsRepo.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 5/3/2025.
//

import Foundation

enum RepoError: Error {
	case unknownType
	case decodingIssue
	case noData
}

protocol AppRepository {
	func load<T: Decodable>() async throws -> T
}

actor MainRepo {
	static let shared = MainRepo()
	
	enum SupportedType {
		case payments
		case rewards
		case notifications
	}
	
	fileprivate var payments: [Payment] = []
	fileprivate var lastUpdatedPaymentsTime: Date?
	fileprivate var isLoadingPayments: Bool = false
	
	fileprivate var rewards: [Reward] = []
	fileprivate var lastUpdatedRewardsTime: Date?
	fileprivate var isLoadingRewards: Bool = false
	
	fileprivate var notifications: [AppNotification] = []
	fileprivate var lastUpdatedNotificatinsTime: Date?
	fileprivate var isLoadingNotifications: Bool = false

	fileprivate var connectionManager: ConnectionManager
	fileprivate var timeIntervalBetweenRefresing: Int
	
	init(connectionManager: ConnectionManager = ConnectionManagerMock.shared, timeIntervalBetweenRefresing: Int = 30) {
		self.connectionManager = connectionManager
		self.timeIntervalBetweenRefresing = timeIntervalBetweenRefresing
	}
	
	fileprivate func updateRepoIfNeeded(type: SupportedType) async {
		var lastUpdatedTime: Date? {
			switch type {
			case .payments: return lastUpdatedPaymentsTime
			case .rewards: return lastUpdatedRewardsTime
			case .notifications: return lastUpdatedNotificatinsTime
			}
		}
		// chack updates no often than 30 mins
		if let lastUpdatedTime,
		   let minutesAgo = Calendar.current.dateComponents([.minute], from: lastUpdatedTime, to: .now).minute  {
			if minutesAgo > timeIntervalBetweenRefresing { await self.update(type) }
		} else {
			await self.update(type)
		}
	}
	
	
	private func update(_ type: SupportedType) async {
		switch type {
		case .payments:
			if !isLoadingPayments {
				isLoadingPayments = true
				if let result = try? await connectionManager.getAllPayments() {
					self.payments = result
				}
				isLoadingPayments = false
				lastUpdatedPaymentsTime = .now
			}
		case .rewards:
			if !isLoadingRewards {
				isLoadingRewards = true
				if let result = try? await connectionManager.getAllRewards() {
					self.rewards = result
				}
				isLoadingRewards = false
				lastUpdatedRewardsTime = .now
			}
		case .notifications:
			if !isLoadingNotifications {
				isLoadingNotifications = true
				if let result = try? await connectionManager.getAllNotifications() {
					self.notifications = result
				}
				isLoadingNotifications = false
				lastUpdatedNotificatinsTime = .now
			}
		}
	}
}

extension MainRepo: AppRepository {
	func load<T: Decodable>() async throws -> T {
		if T.self == [Reward].self {
			await self.updateRepoIfNeeded(type: .rewards)
			if let res = self.rewards as? T { return res }
			throw RepoError.decodingIssue
		}
		
		// returning latest Reward
		if T.self == Reward.self {
			await self.updateRepoIfNeeded(type: .rewards)
			guard let res = self.rewards.first else {
				throw RepoError.noData
			}
			if let res = res as? T { return res }
			throw RepoError.decodingIssue
		}
		
		if T.self == [AppNotification].self {
			await self.updateRepoIfNeeded(type: .notifications)
			if let res = self.notifications as? T { return res }
			throw RepoError.decodingIssue
		}
		
		// returning latest AppNotification
		if T.self == AppNotification.self {
			await self.updateRepoIfNeeded(type: .notifications)
			guard let res = self.notifications.first else {
				throw RepoError.noData
			}
			if let res = res as? T { return res }
			throw RepoError.decodingIssue
		}
		
		if T.self == [Payment].self {
			await self.updateRepoIfNeeded(type: .payments)
			if let res = self.payments as? T { return res }
			throw RepoError.decodingIssue
		}
		
		// returning latest AppNotification
		if T.self == Payment.self {
			await self.updateRepoIfNeeded(type: .payments)
			guard let res = self.payments.first else {
				throw RepoError.noData
			}
			if let res = res as? T { return res }
			throw RepoError.decodingIssue
		}
		
		throw RepoError.unknownType
	}
}
