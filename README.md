# yagom-musicplayer

 프로젝트 기간 : 2022.1.12 ~ 2021.1.18    
 
  프로젝트 팀원 : 서원지    
  
---   

 yagom-musicplayer 만들면서 학습한  내용     
 ### [UIButton, UIslider, UILabel](https://www.notion.so/royblog/UIButton-UISlider-UILabel-6fcb351f33e6411b97403f890d48fdca)  
 
 
 ## 프로젝트 목표 

 - 버튼을 이용해서 음악이 실행하게 시킴
 - sider을 이용해서 노래를 시간을 변경
 - 노래 재생이 종료 되면 다시  play 버튼으로 변경 
 
 ## AVFoundation
- AVFoundation은 다양한 Apple 플랫폼에서 사운드 및 영상 미디어의 처리, 제어, 가져오기 및 내보내기 등 광범위한 기능을 제공하는 프레임워크입니다..

주요 기능
- 미디어 재생 및 편집(QuickTime 동영상 및 MPEG-4 파일 재생/생성/편집, HLS 스트림 재생: 재생가능 파일 목록 링크)
- 디바이스 카메라와 마이크를 이용한 영상 녹화 및 사운드 녹음
- 시스템 사운드 제어
- 문자의 음성화
- AVAudioPlayer Class

## AVAudioPlayer 클래스는 파일 또는 메모리에 있는 사운드 데이터를 재생하는 기능을 제공합니다.

## AVAudioPlayer 주요기능
- 파일 또는 메모리에 있는 사운드 재생(네트워크에 있는 사운드 파일은 재생 불가)
- 파일 재생 시간 길이의 제한없이 사운드 재생
- 여러 개 사운드 파일 동시 재생
- 사운드의 재생 속도 제어 및 스테레오 포지셔닝
- 앞으로 감기와 뒤로 감기 등의 기능을 지원해 사운드 파일의 특정 지점 찾기
- 현재 재생 정보 데이터 얻기
- 사운드 반복재생 기능   
- 
## AVAudioPlayer 주요 프로퍼티
- var isPlaying: Bool: 사운드가 현재 재생되고 있는지 아닌지 여부
- var volume: Float: 사운드의 볼륨값, 최소 0.0 ~ 최대 1.0
- var rate: Float: 사운드의 재생 속도
- var numberOfLoops: Int: 사운드 재생 반복 횟수
- 기본값은 0으로 사운드 1회 재생 후 자동 종료
- 양수값으로 설정시 설정값+1회 재생(ex. 1로 설정시 2회 재생 후 종료)
- 음수값으로 설정시 stop 메서드가 호출 될때까지 무한 재생
- var dutation: TimeInterval: 사운드의 총 재생 시간(초 단위)
- var currentTime: TimeInterval: 사운드의 현재 재생 시각(초 단위)
= protocol AVAudioPlayerDelegate: 사운드 재생 완료, 재생 중단 및 디코딩 오류에 응답할 수 있는 프로토콜

## AVAudioPlayer 주요 메서드
 - AVAudioPlayer 초기화 메서드   
 ```swift
 // 특정 위치에 있는 사운드 파일로 초기화 
func init(contentOf: URL)

// 메모리에 올라와있는 데이터를 이용해 초기화
func init(data: Data)
 ```

- AVAudioPlayer 초기화 메서드  

```swift
// 사운드 재생
func play()

// 특정 시점에서 사운드 재생
func play(atTime: TimeInterval)

// 사운드 일시 정지
func pause()

// 사운드 재생 정지 
func stop()
```    

## Timer

Timer 클래스는 일   

 ### Timer 특징
- 타이머는 런 루프(run loops)에서 작동합니다.
- 타이머를 생성할 때 반복 여부를 지정합니다.
    - 비 반복 타이머: 한 번 실행된 다음 자동으로 무효화 됩니다.
    - 반복 타이머: 동일한 런 루프에서 특정 TimeInterval 간격으로 실행됩니다. 반복되는 타이머 기능을 정지하려면 invalidate() 메서드를 호출해 무효화합니다.정한 시간 간격이 지나면 지정된 메시지를 특정 객체로       전달하는 기능 제공합니다.     
    
 ### Timer 주요 프로퍼티
 - var isValid: Bool: 타이머가 현재 유효한지 아닌지 여부
 - var fireDate: Date: 다음에 타이머가 실행될 시각
 - var timeInterval: TimeInterval: 타이머의 실행 시간 간격(초 단위)

### Timer 생성 메서드
1. 타이머 생성과 동시에 런 루프에 default mode로 등록하는 클래스 메서드   
 
 ```swift
 class func scheduledTimer(withTimeInterval: TimeInterval, repeats: Bool, block: (Timer) -> Void)
class func scheduledTimer(timeInterval: TimeInterval, target: Any, selector: Selector, userInfo: Any?, repeats: Bool)
class func scheduledTimer(timeInterval: TimeInterval, invocation: NSInvocation, repeats: Bool)  
 ``` 
 2. 타이머 생성 후 수동으로 타이머 객체를 add(_:forMode:) 메서드를 이용해 런 루프에 추가해줘야 하는 메서드    
 
 ```swift
 func init(timeInterval: TimeInterval, invocation: NSInvocation, repeats: Bool)
func init(timeInterval: TimeInterval, target: Any, selector: Selector, userInfo: Any?, repeats: Bool)
func init(fireAt: Date, interval: TimeInterval, target: Any, selector: Selector, userInfo: Any?, repeats: Bool)
  ```    
 ![화면 기록 2022-01-14 오후 10 14 16](https://user-images.githubusercontent.com/75601594/149521468-faf9c9b4-c06b-453c-9d47-9892fe58f680.gif)









