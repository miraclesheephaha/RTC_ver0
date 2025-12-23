<img width="775" height="413" alt="image" src="https://github.com/user-attachments/assets/c1b7558a-1319-4ffd-bac6-bf3588f9b54d" />
<img width="663" height="114" alt="image" src="https://github.com/user-attachments/assets/f11dc6aa-9809-4ef5-820a-41c47c5b5ea8" />

先設定RTC_STS之後的RTC Alarm Enable才能啟用，先將RTC_STS設1清空
<img width="663" height="97" alt="image" src="https://github.com/user-attachments/assets/284a651a-ca20-44e4-ac08-17d5b5c340aa" />

Power Management 1 Control(PM1_CNT)-offset 4h  Sleep Enable也要開啟
<img width="667" height="158" alt="image" src="https://github.com/user-attachments/assets/cb83d374-3a3d-49d8-87dd-b64d8fac9490" />

<img width="663" height="154" alt="image" src="https://github.com/user-attachments/assets/7c5cbdc3-53c2-416e-ade9-debd3d63b419" />

先將等候五秒的程式註解原因?   先因為「鬧鐘」在你下達「關機指令」之前就已經響過了。在計算機的電源管理邏輯中，如果 喚醒事件（Wake Event） 已經發生且 狀態位元（Status Bit） 已被設為 1，此時系統通常會拒絕進入睡眠或關機狀態，以防止系統進入一個「永遠醒不來」或「邏輯矛盾」的狀態。
