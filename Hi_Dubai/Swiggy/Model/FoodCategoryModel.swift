//
//  FoodCategoryModel.swift
//  Hi_Dubai
//
//  Created by Asif Khan on 07/06/2023.
//

import Foundation

struct FoodCategoryModel {
    let categoryName: String
    let categoryImage: String
}

let foodCategoryMockData = [
    FoodCategoryModel(categoryName: "offers near you", categoryImage: "ic_offer"),
    FoodCategoryModel(categoryName: "veg only", categoryImage: "ic_vegonly"),
    FoodCategoryModel(categoryName: "premium", categoryImage: "ic_premium"),
    FoodCategoryModel(categoryName: "top rated", categoryImage: "ic_toprated"),
    FoodCategoryModel(categoryName: "express delivery", categoryImage: "ic_express"),
    FoodCategoryModel(categoryName: "pocket friendly", categoryImage: "ic_pocket"),
    FoodCategoryModel(categoryName: "best sellers", categoryImage: "ic_bestseller"),
    FoodCategoryModel(categoryName: "newly launched", categoryImage: "ic_newlaunch"),
]
