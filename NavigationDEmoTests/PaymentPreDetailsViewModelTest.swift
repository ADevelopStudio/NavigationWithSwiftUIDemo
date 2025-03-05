//
//  PaymentPreDetailsViewModelTest.swift
//  NavigationDEmoTests
//
//  Created by Dmitrii Zverev on 5/3/2025.
//

import Testing
@testable import NavigationDEmo

struct PaymentPreDetailsViewModelTest {
	
	private enum PaymentPreDetailsViewModelTestError: Error {
		case testError
		case secondError
	}
	
	@Test func happyFlow() async throws  {
		let connectionManager: ConnectionManager = ConnectionManagerMock(error: nil, secondsDelay: 0)
		let viewModel = await PaymentPreDetailsViewModel(paymentId: "124", connectionManager: connectionManager)
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
		let error = PaymentPreDetailsViewModelTestError.testError
		let connectionManager: ConnectionManager = ConnectionManagerMock(error: error, secondsDelay: 0)
		let viewModel = await PaymentPreDetailsViewModel(paymentId: "124", connectionManager: connectionManager)
		
		await #expect(viewModel.loadingState == .loading(nil))
		await #expect(viewModel.loadingState.currentValue == nil)
		await viewModel.load()
		
		switch await viewModel.loadingState {
		case .error(let apiError):
			guard let recievedError = apiError as? PaymentPreDetailsViewModelTestError else {
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

