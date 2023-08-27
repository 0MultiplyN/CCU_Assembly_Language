409410025 資工三 邱晨恩 hw3
Q1:程式的內容:

A1:此程式hw3.exe的目標是計算出 4x3矩陣 加 4x3矩陣 後的 4x3矩陣。
   我用的方式是有4個row,我就分4次作加法.
   矩陣做後相加結果如下
   c(1,1)= 2 / c(1,2)= 5 / c(1,3)= 5  
   c(2,1)= 10 / c(2,2)= 4 / c(2,3)= 5  
   c(3,1)= 5 / c(3,2)= 5 / c(3,3)= 5
   c(4,1)= 5 / c(4,2)= 9 / c(4,3)= 6
   
Q2:如何編譯程式:

A2：額外撰寫makefile，以"make"指令編譯程式。
可以在makefile 中看見以下文字
arm-none-eabi-gcc -g -O0 hw3.s -o hw3.exe
這行的意思就是編譯的指令。

Q3:程式的執行環境、

A3:此程式的主要執行環境是在 vmware 下的 ubuntu 20.04 ，
使用課堂上提供的arm-none-eabi-insight的ARM simulator進行程式的執行與除錯。
 
Q4:如何執行程式

A4:此程式中，我是使用課堂上提供的arm-none-eabi-insight執行程式。
由於我是直接在虛擬機上下載的linux系統,所以不用另外下載x server。
在根目錄下這個指令後~/assem/arm-newtool/bin/arm-none-eabi-insight
接著設置好Target setting為ARM simulator，再選擇本次作業的執行檔hw3.exe。
就可以利用insight去做本程式的模擬執行與除錯。


