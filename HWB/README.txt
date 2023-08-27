409410025 資工三 邱晨恩 hw4
Q1:程式的內容:

A1:
此程式hw4.exe的目標是
translate the binary code 
to the corresponding BCD code.

這邊我選用的輸入是687
而687 原本binary code ＝ 0010 1010 1111
變成 bcd code = 0110 1000 0111放到r2
   
Q2:如何編譯程式:

A2：額外撰寫makefile，以"make"指令編譯程式。
可以在makefile 中看見以下文字
arm-none-eabi-gcc -g -O0 hw4.s -o hw3.exe
這行的意思就是編譯的指令。

Q3:程式的執行環境、

A3:此程式的主要執行環境是在 vmware 下的 ubuntu 20.04 ，
使用課堂上提供的arm-none-eabi-insight的ARM simulator進行程式的執行與除錯。
 
Q4:如何執行程式

A4:此程式中，我是使用課堂上提供的arm-none-eabi-insight執行程式。
由於我是直接在虛擬機上下載的linux系統,所以不用另外下載x server。
在根目錄下這個指令後~/assem/arm-newtool/bin/arm-none-eabi-insight
接著設置好Target setting為ARM simulator，再選擇本次作業的執行檔hw4.exe。
就可以利用insight去做本程式的模擬執行與除錯。
除此之外，
在此作業中我將指令加入 makefile 中，以 "make gbd"進行程式的執行。


