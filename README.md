<img width="775" height="413" alt="image" src="https://github.com/user-attachments/assets/c1b7558a-1319-4ffd-bac6-bf3588f9b54d" />
<img width="663" height="114" alt="image" src="https://github.com/user-attachments/assets/f11dc6aa-9809-4ef5-820a-41c47c5b5ea8" />

先設定RTC_STS之後的RTC Alarm Enable才能啟用，先將RTC_STS設1清空
<img width="663" height="97" alt="image" src="https://github.com/user-attachments/assets/284a651a-ca20-44e4-ac08-17d5b5c340aa" />

Power Management 1 Control(PM1_CNT)-offset 4h  
<img width="667" height="158" alt="image" src="https://github.com/user-attachments/assets/cb83d374-3a3d-49d8-87dd-b64d8fac9490" /> 

Sleep Enable也要開啟

<img width="653" height="54" alt="image" src="https://github.com/user-attachments/assets/63a873ab-3978-4836-b6bf-88c067a5da5e" />
<img width="663" height="154" alt="image" src="https://github.com/user-attachments/assets/7c5cbdc3-53c2-416e-ade9-debd3d63b419" />

先將等候五秒的程式註解原因?  
先因為「鬧鐘」在你下達「關機指令」之前就已經響過了。在計算機的電源管理邏輯中，如果 喚醒事件（Wake Event） 已經發生且 狀態位元（Status Bit） 已被設為 1，此時系統通常會拒絕進入睡眠或關機狀態，以防止系統進入一個「永遠醒不來」或「邏輯矛盾」的狀態。  

**I/O PORT 70/71，與I/O SPACE 0500有啥區別?**
<img width="708" height="618" alt="image" src="https://github.com/user-attachments/assets/8da74b0b-3cc5-4e0b-833b-568b7ffeb3a4" />

## 程式碼介紹
mm 500 -w 4 -IO  
> 代表查看0500之下所存放的值
mm 70 0B -w 1 -IO
mm 71 20 -w 1 -IO
>代表把 CMOS index register B ，的DATA設成20對應的意思是BIT5 AIE (Alarm Interrupt Enable)允許alarm

mm 70 0C -w 1 -IO  
mm 71 -w 1 -IO  
> read register C，查看register c底下的值，bit5代表alarm flag=當前面設定的alarm時間match當前的時間會為1(high)，bit7 Interrupt Request Flag(IRQF)當AF與AIE同時為1時觸發，會導致 RTC中斷被觸發

mm 501 04 -w 1 -IO  
> (PM1_EN_STS)代表從0X500開始過1個BYTE就會是501，04意思是501的第三個BIT== 500的第十個BIT此BIT代表RTC STATUS(RTC_STS)以上程式先將他RESET

mm 503 04 -w 1 -IO
> (PM1_EN_STS)以此類推是將500開始的第26個BIT RTC ALARM ENABLE設為1，前提是要先將RTC_STS設置好才能觸發，與SCI_EN可組合成兩種模式SMI(無)與SCI(有)，兩者差別在有無作業系統狀況下執行，功能為當SYSTEM進入S3-S5時，然後可觸發WAKE事件，代表前面設置的ALARM若為五秒可在五秒後觸發。

mm 0504 00003C00 -w 4 -IO  
> (PM1_CNT)最後在此REGISTER下將，BIT13代表Sleep Enable(SLP_EN)開啟，並設置Sleep Type(SLP_TYP) BIT12:10 這裡我設定為S5==Soft Off。

**總結：執行完整個程式碼後可達成關機五秒後wakeup的功能。**
