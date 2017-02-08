//
//  XCUIElementQueryTests.swift
//  AutoMateExample
//
//  Created by Bartosz Janda on 01.02.2017.
//  Copyright © 2017 PGS Software. All rights reserved.
//

import XCTest
import AutoMate

class XCUIElementQueryTests: AppUITestCase {

    // MARK: Arrange View Objects
    lazy var mainView: MainView = MainView(in: self.app)
    lazy var tableView: TableView = TableView(in: self.app)

    // MARK: Set up
    override func setUp() {
        super.setUp()
        TestLauncher.configure(app).launch()
        wait(forVisibilityOf: mainView)
    }

    // MARK: Tests
    func testElementMatchingLabel() {
        mainView.goToTableViewMenu()

        let creditCellLabelDefault = app.any.element(withLabelMatching: "Made with love by")
        let creditCellLabelEquals = app.any.element(withLabelMatching: "Made with love by", comparisonOperator: .equals)
        let creditCellLabelLike = app.any.element(withLabelMatching: "Made *", comparisonOperator: .like)
        let creditCellLabelMatches = app.any.element(withLabelMatching: "Made.*", comparisonOperator: .matches)
        let creditCellLabelBeginsWith = app.any.element(withLabelMatching: "Made", comparisonOperator: .beginsWith)
        let creditCellLabelEndsWith = app.any.element(withLabelMatching: "love by", comparisonOperator: .endsWith)
        let creditCellLabelContains = app.any.element(withLabelMatching: "with love", comparisonOperator: .contains)

        XCTAssertTrue(creditCellLabelDefault.isHittable)
        creditCellLabelDefault.tap()

        XCTAssertTrue(creditCellLabelEquals.isHittable)
        creditCellLabelEquals.tap()

        XCTAssertTrue(creditCellLabelLike.isHittable)
        creditCellLabelLike.tap()

        XCTAssertTrue(creditCellLabelMatches.isHittable)
        creditCellLabelMatches.tap()

        XCTAssertTrue(creditCellLabelBeginsWith.isHittable)
        creditCellLabelBeginsWith.tap()

        XCTAssertTrue(creditCellLabelEndsWith.isHittable)
        creditCellLabelEndsWith.tap()

        XCTAssertTrue(creditCellLabelContains.isHittable)
        creditCellLabelContains.tap()
    }

    func testElementMatchingIdentifier() {
        mainView.goToTableViewMenu()

        let creditCell = app.any.element(withLocator: Locators.credit, label: "Made with love by")
        let wrongLabelCell = app.any.element(withLocator: Locators.credit, label: "")

        XCTAssertTrue(creditCell.isHittable)
        creditCell.tap()

        XCTAssertFalse(wrongLabelCell.exists)
    }

    func testCellMatching() {
        mainView.goToTableViewMenu()

        let firstCellOfAKind = app.cells.element(containingLabels: [Locators.title: "Kind A", Locators.subtitle: "1st cell"])
        let secondCellOfBKind = app.cells.element(containingLabels: [Locators.title: "*B", Locators.rightDetail: "2*"], labelsComparisonOperator: .like)
        let creditCell = app.cells.element(containingLabels: [Locators.credit: "with love"], labelsComparisonOperator: .contains)
        let wrongRightDetailCell = app.cells.element(containingLabels: [Locators.title: "Kind B", Locators.rightDetail: "3rd"])
        let wrongIdentifierCell = app.cells.element(containingLabels: [Locators.title: "Kind A", Locators.rightDetail: "3rd cell"])

        XCTAssertTrue(firstCellOfAKind.isHittable)
        firstCellOfAKind.tap()

        XCTAssertTrue(secondCellOfBKind.isHittable)
        secondCellOfBKind.tap()

        XCTAssertTrue(creditCell.isHittable)
        creditCell.tap()

        XCTAssertFalse(wrongRightDetailCell.exists)
        XCTAssertFalse(wrongIdentifierCell.exists)
    }

    // MARK: Test for movie
    func testForMovie() {
        testCellMatching()
        tableView.goBack()
    }
}

// MARK: - Locators
private extension XCUIElementQueryTests {
    enum Locators: String, Locator {
        case title
        case subtitle
        case rightDetail
        case credit
    }
}
