//
//  DashboardPaymentsViewModelTest.swift
//  NavigationDEmoTests
//
//  Created by Dmitrii Zverev on 5/3/2025.
//

import Testing
@testable import NavigationDEmo

struct DashboardPaymentsViewModelTest {
	
	private enum DashboardPaymentsViewModelTestError: Error {
		case testError
		case secondError
	}
	
	@Test func happyFlow() async throws {
		let connectionManager: ConnectionManager = ConnectionManagerMock(error: nil, secondsDelay: 0)
		let repo: AppRepository = MainRepo(connectionManager: connectionManager, timeIntervalBetweenRefresing: 600)
		let viewModel = await DashboardPaymentsViewModel(repo: repo)
		
		await #expect(viewModel.loadingState == .loading(nil))
		await #expect(viewModel.loadingState.currentValue == nil)
		await viewModel.load()
		
		switch await viewModel.loadingState {
		case .error(let error):
			Issue.record(error)
		case .loaded:
			break
		case .loading:
			Issue.record("Incorrect state")
		}
	}
	
	@Test func networkErrorFlow() async throws  {
		let error = DashboardPaymentsViewModelTestError.testError
		let connectionManager: ConnectionManager = ConnectionManagerMock(error: error, secondsDelay: 0)
		let viewModel = await PaymentPreDetailsViewModel(paymentId: "124", connectionManager: connectionManager)
		
		await #expect(viewModel.loadingState == .loading(nil))
		await #expect(viewModel.loadingState.currentValue == nil)
		await viewModel.load()
		
		switch await viewModel.loadingState {
		case .error(let apiError):
			guard let recievedError = apiError as? DashboardPaymentsViewModelTestError else {
				Issue.record("Incorrect error type")
				return
			}
			#expect(recievedError == error)
		case .loaded:
			Issue.record("Incorrect state")
		case .loading:
			Issue.record("Incorrect state")
		}
	}
}
