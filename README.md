# 당신의 아늑한 심리상담 챗봇, Heimish

## ☀️ Project
> Dongguk Univ 2021 4-1 Capston Design</b>
>
> 프로젝트 기간: 2020.03.13 ~ 2021.06.10  


<img style="border: 0px solid black !important; border-radius:20px;" width=30% src="https://user-images.githubusercontent.com/42789819/121189492-1e649780-c8a5-11eb-90a4-267190aa68e1.png"> 

<br>
<br>

## 🛠 개발 환경 및 사용한 라이브러리 (Development Environment and Using Library)

* Development Environment  
![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg) ![iOS](https://img.shields.io/badge/Platform-iOS-black.svg)


* Using Library  
    ```ruby
    # Pods for Heimish-iOS
    pod 'Moya'
    pod 'RealmSwift'
    pod 'SwiftLint'
    pod 'FloatingPanel`
    ```

<br>
<br>

## 📌 Work flow
<img width=100% src=https://user-images.githubusercontent.com/42789819/121510189-52b19280-ca22-11eb-9360-ea7a59832918.jpg>


<br>
<br>

## 🧑🏻‍💼 Description
 <img width="1289" alt="flow-1" src="https://user-images.githubusercontent.com/42789819/121510164-4fb6a200-ca22-11eb-9232-558abca942dc.png">
<img width="1054" alt="flow-2" src="https://user-images.githubusercontent.com/42789819/121510178-51806580-ca22-11eb-942f-0201588768dc.png">
<img width="1144" alt="flow-3" src="https://user-images.githubusercontent.com/42789819/121510184-5218fc00-ca22-11eb-8e82-a8a47d1ac275.png">


<br>
<br>

 ## 📄 Coding Convention 
 > 다음 스타일 Guide를 참고헀습니다. 👉🏻[Style Guide](https://github.com/StyleShare/swift-style-guide)
 <details>
 <summary> 🗂 폴더구조 </summary>
 <div markdown="1">       


---

**Resources**
* AppDelegate
* SceneDelegate
* Assets.xcassets
* Storyboard
* APIService
    * APIConstant
* Font

**Sources**
* VC
* Class
* Cell
* Model
    * GenericResponse
* Extension
            
**Info.plist**

<br>
<br>
 </div>
 </details>
 
 
 <details>
 <summary> ⚙️ 폴더링 규칙 </summary>
 <div markdown="1"> 
 
 
--- 

- 폴더링 한 후 Sources 폴더에 있는 파일들은 각 파일 하위에 자신 스토리보드 이름에 해당하는 폴더를 만들어 관리합니다. 
  <img width="265" alt="Sources" src="https://user-images.githubusercontent.com/63224278/103536203-6b4ad900-4ed5-11eb-9614-b4731aa3773a.png">

- 파일 네이밍 시, 접두에 스토리보드이름을 붙여서 네이밍합니다.
    -  (ex. 스토리보드 이름이 Main, Watering이라고 가정했을 때 cell파일 생성 시 MainBlahblahCVC, WateringBlahblahTVC와 같이 네이밍합니다.)
        
👉🏻 [자세히](https://github.com/TeamCherish/Cherish-iOS/wiki/CodingConvention)

 </div>
 </details>



<details>
<summary> 🖋 네이밍 </summary>
<div markdown="1">       


---

**Class & Struct**

- 클래스/구조체 이름은 **UpperCamelCase**를 사용합니다.

- 클래스 이름에는 접두사를 붙이지 않습니다.

**함수 & 변수 & 상수**

- 함수와 변수에는 **lowerCamelCase**를 사용합니다.

- 버튼명에는 **Btn 약자**를 사용합니다.

- 모든 IBOutlet에는 해당 클래스명을 뒤에 붙입니다. 
    - ~~ImageView, ~~Label, ~~TextField와 같이 속성값을 붙여줍니다.
    
- 테이블 뷰는 **TV**, 컬렉션뷰는 **CV**로 줄여서 네이밍합니다.

- 테이블 뷰 셀은 **TVC**, 컬렉션뷰 셀은 **CVC**로 줄여서 네이밍합니다.
<br>

</div>
</details>

<details>
<summary> 📎 기타 </summary>
<div markdown="1">       


---

- viewDidLoad() 내에는 **Function만 위치**시킵니다.
- 중복되는 부분들은 +Extension.swift로 만들어 활용합니다.
- 접근 제어자를 잘 활용합니다.
- 메인컬러와 같이 자주 쓰이는 컬러들은 Asset에 Color Set을 만들어서 사용합니다.
- , 뒤에 반드시 띄어쓰기를 합니다.
- 함수끼리 1줄 개행합니다.
- 중괄호는 아래와 같은 형식으로 사용합니다.
```swift
if (condition) {

  Statements
  /*
  ...
  */
  
}
```
</div>
</details>
 
<details>
<summary> ✉️ Commit Messge Rules  </summary>
<div markdown="1"> 

<br>

```
- feat    : 기능 (새로운 기능)
- fix     : 버그 (버그 수정)
- refactor: 리팩토링
- style   : 스타일 (코드 형식, 세미콜론 추가: 비즈니스 로직에 변경 없음)
- docs    : 문서 (문서 추가, 수정, 삭제)
- test    : 테스트 (테스트 코드 추가, 수정, 삭제: 비즈니스 로직에 변경 없음)
- chore   : 기타 변경사항 (빌드 스크립트 수정 등)
```
<br>

### ℹ️ 커밋 메세지 형식
  - `[커밋메세지] 설명` 형식으로 커밋 메시지를 작성합니다.
  - 커밋 메시지는 영어 사용을 권장합니다.
    ```
    [feat] Fetchcontacts
    ```
</div>
</details>
 
<br>
<br>


## <img width=20px src=https://user-images.githubusercontent.com/42789819/115146245-9cb87080-a090-11eb-9762-1a686d8fc737.png> Heimish iOS Dev


| 이원석 |
|:---:|
| <img src="https://user-images.githubusercontent.com/63224278/103280936-ee22ee00-4a14-11eb-9161-aa5249d74f20.png" width="200px" height = "200px" />  |
|  [snowedev](https://github.com/snowedev) |

<br>
<br>
