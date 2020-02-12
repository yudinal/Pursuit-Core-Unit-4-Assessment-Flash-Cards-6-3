//
//  FlashCardService.swift
//  Unit4Assessment
//
//  Created by Lilia Yudina on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

public enum FlashCardServiceError: Error {
  case resourcePathDoesNotExist
  case contentsNotFound
  case decodingError(Error)
}

final class FlashCardService {
  public static func fetchFlashCards() throws -> [FlashCard] {
    guard let path = Bundle.main.path(forResource: "Data", ofType: "Json") else {
      throw FlashCardServiceError.resourcePathDoesNotExist
    }
    guard let json = FileManager.default.contents(atPath: path) else {
      throw FlashCardServiceError.contentsNotFound
    }
    do {
      let flashCards = try JSONDecoder().decode([FlashCard].self, from: json)
      return flashCards
    } catch {
      throw FlashCardServiceError.decodingError(error)
    }
  }
}
