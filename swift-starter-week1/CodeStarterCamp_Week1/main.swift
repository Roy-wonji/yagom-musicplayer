//
//  main.swift
//  CodeStarterCamp_Week1
//
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

class ContactInfo {
    //이름  나이  핸드폰  번호를  선언
    var informationName: String = ""
    var informationAge: String = ""
    var informationPhoneNumber: String = ""
}
 // 각 케이스 별로  메뉴를  선택  하면  함수를  호출해서 함수를   실행 하게  선언을  하고
    // readline 함수를 이용해서 케이스별로  입력을 받게 코드를 짯습니다

class ContactManagementProgram {
   private var contanctList = [ContactInfo]()
    
    func startProgram() {
        
        while true {
        print("1) 연락처 추가 2) 연락처 목록보기 3) 연락처 검색 x) 종료")
        print("메뉴를 선택해주세요: ", terminator: " ")
        
        guard let userInput =  readLine() else { return }
        
        switch (userInput) {
        case "1": addContactInfo()
        case "2": showContactList()
        case "3": searchContactInfo()
        case "x":
            exitProgram()
          return
        default:  return
        
        }
    }
}
      // 연락처  추가  함수는  오류 문을  던진걸 try문으로  시도해서 각  부분별  오류르 처리 하면서  do  catch 문으로 감싸서 처리 한  부분
    func addContactInfo() {
        
        let contactInfo =  ContactInfo()
        guard let splitedStringArray = askContactInfo() else {return}
        do  {
            try saveRawValue(InputString: splitedStringArray, to: contactInfo)
            try checkAgeFormatCorrect(Age: contactInfo.informationAge)
            try checkPhonenumberFormatCorrect(phonenumber: contactInfo.informationPhoneNumber)
            printContanctInfo(of: contactInfo)
        } catch  ContactInfoError.inputFormatError {print("입력 형식을 확인해주세요.") }
        catch  ContactInfoError.ageIsNotNumber{print("나이는 숫자로 입력해야 돼요! 입력 형식을 확인 해주세요")}
        catch  ContactInfoError.phoneNumberFormatError{print("입력한 연락처 정보가 잘못되었습니다! 입력 형식을 확인 해주세요")}
        catch  ContactInfoError.phoneNumberOutOfRange{print("연락처는 9자리 이상이어야 합니다")}
        catch{}
        
        self.contanctList.append(contactInfo)
    }
    // 연락처의 정보를   이별
    func askContactInfo() -> [String]? {
        
        print("입력할 연락처 정보를 입력해주세요 : ", terminator: " ")
        guard let userInputString =  readLine() else { return nil}
        return userInputString.split(separator: "/").map{ String( $0) }
    }
     // 연락처  정보  보기  욘락처의  이름을  sort라는 함수로   오름 차순으로 정렬을  해서  연락처를   출력하게  코드를  짰습니다
    func showContactList() {
        let sortContactList = self.contanctList.sorted{$0.informationName < $1.informationName}
        sortContactList.forEach {
            guard let ageInt = Int($0.informationAge) else {return}
            print("- \($0.informationName) / \(ageInt) / \($0.informationPhoneNumber)")
        }
    }
      //  찾는 이름이  만약에  없으면  연락처에  000님이  없습니다  라고  출력을 하는데  이것을  fillter 라는 함수를 이용해서 참  거짓을 판별해서  참이면  이름 /나이 /핸드폰  번호가  출력
    func searchContactInfo() {
        let nameForSearch = askNameForSearch()
        let  searchedList = self.contanctList.filter { $0.informationName ==  nameForSearch }
        guard searchedList.count != 0 else {
            print(" 연락처에 \(nameForSearch)이 없습니다")
            return
        }
        printSearchedList(list: searchedList)
    }
         // 저장 된  배열에서 리스트에서 검색된  이름이  참이면  - 이름 / 나일 / 핸드폰  번호를 출력  하게  적용
    func printSearchedList(list : [ContactInfo]) {
        list.forEach{
            guard let ageInt = Int($0.informationAge) else {return }
            print("- \($0.informationName) / \(ageInt) / \($0.informationPhoneNumber)")
        }
    }
    
    func askNameForSearch() -> String {
        print("연락처에서 찾을 이름을 입력해주세요 : ", terminator: " ")
        guard let userInputString =  readLine() else { return " "}
        return userInputString
    }
    
    // 프로 그램 메뉴중  x를  눌르면  프로그램  종료 라도  출력
    func exitProgram() {
        print("[프로그램 종료]!")
    }
    // 받은 입력 기준으로 찢고, 그거를 강제로 String이라는 형으로 하나하나 바꿔준 [스트링, 스트링, 스트링 ...]  save여기로 저 배열이 전달됐고그 배열이 만약에 3개 가 아니면
    //에러 처리 왜냐면 이름, 연락처, 나이 3개만 들어와야하니까 이중 하나가 안들어오거나 3개 이상이 들어오면 에러날린거고 그다음에 각 배열 인덱스 하나씩 이름, 나이, 폰넘버로 넣어준거
    func saveRawValue(InputString rawValue: [String], to: ContactInfo) throws {
        guard rawValue.count == 3 else {throw ContactInfoError.inputFormatError }
        
        to.informationName = removeSpace(from: rawValue[0])
        to.informationAge = removeSpace(from: rawValue[1])
        to.informationPhoneNumber =  removeSpace(from: rawValue[2])
        
    }
      //  입려받은  ㅈ어보가  제대로  되있으면  요구사항  대로   입력한 정보는  00세  이름 전화 번호를  입니다라고  출력 하게  짬
    func printContanctInfo(of: ContactInfo) {
        guard let ageInt = Int(of.informationAge) else {return}
        print("입력한 정보는 \(ageInt)세 \(of.informationName)(\(of.informationPhoneNumber))입니다")
        
    }
    // 이름의  칸수를  홍, 길, 동이라고  만약에  출력이  되면 .components가  [홍길동] 이라고  출력을  하고  .joined로 인해  []가  벗겨지고  상요자가  빈칸을  입력을 하면  제거를 하게  코드의 흐름을 만들도록 함
    func removeSpace(from inputString: String) -> String {
        return inputString.components(separatedBy: " ").joined()
    }
     //  나이가  999살이하까지   출력이  되고  그이상이면  오류처리를 해서  선언을 함   나이를 위쪼에서  string 처리를 해서  여기에서  가드 문으로   Int 처리를 해서   변형을 해서  실행
    func checkAgeFormatCorrect(Age: String)  throws {
        guard let ageInt = Int(Age) else { throw ContactInfoError.ageIsNotNumber}
        if ageInt > 1000 {throw ContactInfoError.ageIsOutOfRange }
    }
    //  요구사항에서 - 이  2개 이면  참 이고   필터  고파 함수를 사용해서 3개이면  오류 처리 ,
    func checkPhonenumberFormatCorrect(phonenumber: String) throws {
        guard phonenumber.filter({ $0 == "-" }).count == 2 else { throw ContactInfoError.phoneNumberFormatError}
        guard phonenumber.split(separator: "-").joined().count >= 9 else {throw ContactInfoError.phoneNumberOutOfRange}
    }
}
  // 함수를 선언후   실행  할  함수를 받아서  실행
func managementSystemProgramStart() {
    
    let managementSystem: ContactManagementProgram = ContactManagementProgram()
    managementSystem.startProgram()
}
   
managementSystemProgramStart()

// 오류  각  부분  별을  케이스 별로  오류 처리
enum ContactInfoError: Error {
    case inputFormatError
    case ageIsNotNumber
    case ageIsOutOfRange
    case phoneNumberFormatError
    case phoneNumberOutOfRange
}
