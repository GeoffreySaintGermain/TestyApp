//
//  FileReader.swift
//  Testy
//
//  Copyright 2022 Geoffrey Saint-Germain
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation

/// Generic class writing/reading json file
public class FileReader<T: Codable> {
    
    /// Read a json file
    ///  - data: data to write in file
    ///  - file: json file to write into
    public static func writeInFile(data: T, file: String) {
        do {
            let encodedFavorites = try JSONEncoder().encode(data)
            let path = FileManager.default.urls(for: .documentDirectory ,in: .userDomainMask)[0]
            let url = path.appendingPathComponent(file)            
            try encodedFavorites.write(to: url)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// Read from a specific json file
    ///  - type: type of the read data
    ///  - file: json file to read
    public static func readInFile(type: T.Type, file: String) -> T? {
        let decoder = JSONDecoder()
        
        guard let path = FileManager.default.urls(for: .documentDirectory ,in: .userDomainMask).first else {
            print("Cannot find url from path")
            return nil
        }
        
        let url = path.appendingPathComponent(file)
        
        guard let data = try? Data(contentsOf: url) else {
            print("Failed to load from bundle.")
            return nil
        }

        guard let loaded = try? decoder.decode(type.self, from: data) else {
            print("Failed to decode from bundle.")
            return nil
        }

        return loaded
    }
}
