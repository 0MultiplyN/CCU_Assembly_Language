409410025 資工三 邱晨恩
Q1:描述你程式的內容 ? 

A1:計算出 2*r1+3*r5-2*r6的值後放置於r0。
我測試的範例 r1 = 6, r5= 4, r6 = 3來說，最後放置於r0的值就會是 2*6+3*4-2*3=18。

Q2:如何編譯程式 ?

A2:
使用以下指令對程式進行編譯:
~/assem/arm-newtool/bin/arm-none-eabi-gcc -g hw2.s -o hw2.exe
編譯時加上的"-g"參數，會讓程式在編譯完之後產生GBD可以辨識的除錯碼。

Q3:程式的執行環境 ? 

A3:此程式的主要執行環境是在 vmware 下的 ubuntu 20.04 ，
使用課堂上提供的arm-none-eabi-insight的ARM simulator進行程式的執行與除錯。
 
Q4:如何執行你的程式 ? 
A4:此程式中，我是使用課堂上提供的arm-none-eabi-insight執行程式。
由於我是直接在虛擬機上下載的linux系統,所以不用另外下載x server。
在根目錄下這個指令後~/assem/arm-newtool/bin/arm-none-eabi-insight
接著設置好Target setting為ARM simulator，再選擇本次作業的執行檔hw2.exe。
就可以利用insight去做本程式的模擬執行與除錯。
