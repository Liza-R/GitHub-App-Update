import XCTest
@testable import GitHub_App_Update

class UserDetailsViewModelMock: UserDeatilsViewModel {
    var loadAllMainDetailsWasCalled: Bool = false
    var loadAllReposInfoWasCalled: Bool = false

    override func uploadAllDetailsInfo(chooseLogin: String) {
        super.uploadAllDetailsInfo(chooseLogin: chooseLogin)
        loadAllMainDetailsWasCalled = true
    }
    
    override func uploadAllReposInfo(chooseLogin: String) {
        super.uploadAllReposInfo(chooseLogin: chooseLogin)
        loadAllReposInfoWasCalled = true
    }
}

class ReposTableViewMock: UITableView {
    var reloadDataWasCalled = false
    override func reloadData() {
        super.reloadData()
        reloadDataWasCalled = true
    }
}

class UserDetailsTests: XCTestCase {

    var detailsInfoController: UserDetailsViewController!
    var userDetailsVMMock: UserDetailsViewModelMock!
    var reposTableViewMock: ReposTableViewMock!
    
    override func setUp() {
        super.setUp()
        detailsInfoController = UserDetailsViewController()
        userDetailsVMMock = UserDetailsViewModelMock(chooseLogin: "Liza-R")
        reposTableViewMock = ReposTableViewMock()
        detailsInfoController.reposTableView = reposTableViewMock
    }
    
    func testUserDetailsUIs() throws {
        // when
        detailsInfoController.viewDidLoad()
        
        // then
        XCTAssert(detailsInfoController.contains(detailsInfoController.mainInfoStack ?? UIStackView()))
        XCTAssert(detailsInfoController.contains(detailsInfoController.loginLabel))
        XCTAssert(detailsInfoController.contains(detailsInfoController.avatarImageView))
        XCTAssert(detailsInfoController.contains(detailsInfoController.nameLabel))
        XCTAssert(detailsInfoController.contains(detailsInfoController.companyNameLabel))
        XCTAssert(detailsInfoController.contains(detailsInfoController.locationLabel))
        XCTAssert(detailsInfoController.contains(detailsInfoController.emailLabel))
        XCTAssert(detailsInfoController.contains(detailsInfoController.countPublicReposLabel))
        XCTAssert(detailsInfoController.contains(detailsInfoController.reposTableView))
    }
    
    func testUserDetailsLoad() throws {
        // when
        detailsInfoController.viewDidLoad()
                
        // then
        XCTAssert(userDetailsVMMock.loadAllMainDetailsWasCalled)
        userDetailsVMMock.loadAllMainDetailsWasCalled = false
    }
    
    func testUserReposLoad() throws {
        // when
        detailsInfoController.viewDidLoad()
                
        // then
        XCTAssert(userDetailsVMMock.loadAllReposInfoWasCalled)
        userDetailsVMMock.loadAllReposInfoWasCalled = false
    }
    
    func testAllUsersTableView(){
        // when
        detailsInfoController.viewDidLoad()
        detailsInfoController.reposTableView.reloadData()
        
        // then
        XCTAssert(detailsInfoController.contains(detailsInfoController.reposTableView))
        XCTAssertNotNil(detailsInfoController.reposTableView)
        XCTAssertNotNil(detailsInfoController.reposTableView.dataSource)
        XCTAssertNotNil(detailsInfoController.reposTableView.delegate)
        XCTAssert(detailsInfoController.conforms(to: UITableViewDelegate.self))
        XCTAssert(reposTableViewMock.reloadDataWasCalled)
        reposTableViewMock.reloadDataWasCalled = false
    }
    
    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

}
