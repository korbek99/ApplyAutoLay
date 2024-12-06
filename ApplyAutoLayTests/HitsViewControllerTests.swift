//
//  HitsViewControllerTests.swift
//  ApplyAutoLayTests
//
//  Created by Jose Preatorian on 05-12-24.
//

import XCTest
@testable import ApplyAutoLay

final class HitsViewControllerTests: XCTestCase {

    var viewController: HitsViewController!
    
    override func setUp() {
           super.setUp()
           viewController = HitsViewController()
           viewController.loadViewIfNeeded()
       }
    
    override func tearDown() {
            viewController = nil
            super.tearDown()
    }
    
    func testTableViewNumberOfRows() {
        
        let autors = Author(matchLevel: "YoMismo", matchedWords: ["YoMismo"], value: "YoMismo", fullyHighlighted: true)
        
        let high = HighlightResult(author: autors, commentText: autors, storyTitle: autors, storyURL: autors, title: autors, url: autors, storyText: autors)
   
        let hits =  [Hit(highlightResult: high, tags: ["YoMismo"], author: "YoMismo", commentText: "YoMismo", createdAt: "YoMismo", createdAtI: 1, objectID: "YoMismo", parentID: 1, storyID: 1, storyTitle: "YoMismo", storyURL: "YoMismo", updatedAt: "YoMismo", children: [2], numComments: 2, points: 1, title: "YoMismo", url: "YoMismo", storyText: "YoMismo")]
           
           viewController.tableView.reloadData()
           let rows = viewController.tableView.numberOfRows(inSection: 0)
           
           XCTAssertEqual(rows, 2, "El número de filas debe coincidir con el número de hits en el modelo.")
    }
    
    func testCellConfiguration() {
            viewController.tableView.reloadData()
            
       let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? HitsTableViewCell
            
        XCTAssertNotNil(cell, "La celda no debe ser nil.")
        XCTAssertEqual(cell?.lblName.text, "Author1", "El nombre del autor debe configurarse correctamente.")
        XCTAssertEqual(cell?.lblTitle.text, "Title1", "El título debe configurarse correctamente.")
    }
    
    func testDeleteRow() {
        let autors = Author(matchLevel: "YoMismo", matchedWords: ["YoMismo"], value: "YoMismo", fullyHighlighted: true)
        
        let high = HighlightResult(author: autors, commentText: autors, storyTitle: autors, storyURL: autors, title: autors, url: autors, storyText: autors)
   
        let hits =  [Hit(highlightResult: high, tags: ["YoMismo"], author: "YoMismo", commentText: "YoMismo", createdAt: "YoMismo", createdAtI: 1, objectID: "YoMismo", parentID: 1, storyID: 1, storyTitle: "YoMismo", storyURL: "YoMismo", updatedAt: "YoMismo", children: [2], numComments: 2, points: 1, title: "YoMismo", url: "YoMismo", storyText: "YoMismo")]
        
            viewController.tableView.reloadData()
            
            viewController.tableView(viewController.tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
            
            XCTAssertEqual(hits.count, 1, "El número de hits debe disminuye.")
    }
    
    func testDidSelectRowWithValidURL() {
        let autors = Author(matchLevel: "YoMismo", matchedWords: ["YoMismo"], value: "YoMismo", fullyHighlighted: true)
        
        let high = HighlightResult(author: autors, commentText: autors, storyTitle: autors, storyURL: autors, title: autors, url: autors, storyText: autors)
   
        let hits =  Hit(highlightResult: high, tags: ["YoMismo"], author: "YoMismo", commentText: "YoMismo", createdAt: "YoMismo", createdAtI: 1, objectID: "YoMismo", parentID: 1, storyID: 1, storyTitle: "YoMismo", storyURL: "YoMismo", updatedAt: "YoMismo", children: [2], numComments: 2, points: 1, title: "YoMismo", url: "YoMismo", storyText: "YoMismo")
            
            viewController.tableView(viewController.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
            
        XCTAssertEqual(((viewController.routers?.goToDetailWeb(with: hits)) != nil), true, "La navegación debe ocurrir cuando se selecciona un URL valida.")
    }
    
    func testDidSelectRowWithInvalidURL() {
        let autors = Author(matchLevel: "YoMismo", matchedWords: ["YoMismo"], value: "YoMismo", fullyHighlighted: true)
        
        let high = HighlightResult(author: autors, commentText: autors, storyTitle: autors, storyURL: autors, title: autors, url: autors, storyText: autors)
   
        let hits =  Hit(highlightResult: high, tags: ["YoMismo"], author: "YoMismo", commentText: "YoMismo", createdAt: "YoMismo", createdAtI: 1, objectID: "YoMismo", parentID: 1, storyID: 1, storyTitle: "YoMismo", storyURL: "YoMismo", updatedAt: "YoMismo", children: [2], numComments: 2, points: 1, title: "YoMismo", url: "YoMismo", storyText: "YoMismo")
            
            viewController.tableView(viewController.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
            
        XCTAssertEqual(((viewController.routers?.goToError(error: "Ocurrio error")) != nil), true, "Se debe mostrar un error cuando se selecciona un hit con URL inválida.")
        }
    


}
