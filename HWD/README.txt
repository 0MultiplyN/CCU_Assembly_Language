409410025 資工三 邱晨恩 hw6
Q1:程式的內容:

A1:
本作業目的 ： 實作bcd的加減法
首先在主程式hw6.c的部份會有輸入一個binary的值,
接著利用bin2bcd先換成bcd表示法,
而作這個轉換的時候會用到idiv.s,
提供類似除法的功能.
原因是arm 的指令裡面並沒有除法的功能,
因此利用減法來達成除法的效果.
雖然需要另外實做其他的程式碼檔案
但是多了這個idiv.s可以讓bin2bcd.s的程式碼變得比較精簡.
---
接著是bcd加法的部份,bcdadd.s
這邊需要處理進位的問題,
這邊我是在各個位數作分別的判斷大於10就會在前一個位數加一.
而題目要求只有三個位數,
所以即便是999+999我這邊也是只會有三個位數
這樣的好處是可以節省空間,
但是又能達成程式碼識讀性的效果.
---
bcd減法的部份,bcdsub.s
這邊需要處理進位的問題,而題目要求只有三個位數
且a一定大於b,所以一定不會有負數的情況
這邊我是在各個位數作分別的判斷,
若a的位數的值小於b,就會在前面的位數做borrow的動作.
而這邊可能會有需要借兩位數的判斷
而這邊我是直接分三層作判斷,
這樣的程式碼也比較好理解.
---
上面的.s檔案都只是.c檔案會用到的function
所以我有多加了extern這個東西幫忙編譯器認出我寫在另外檔案
---

輸出的部份我使用printf,並且以每四個bit為一組,以底線隔開,方便閱讀.
而每組答案就是12個bit.
   
Q2:如何編譯程式:

A2：額外撰寫makefile，以"make"指令編譯程式。
可以在makefile 中看見以下文字
arm-none-eabi-gcc -g -O0 hw6.c idiv.s bin2bcd.s bcdadd.s bcdsub.s -o hw6.exe 
這行的意思就是編譯的指令。
比較需要注意的事情是,
主程式 hw6.c 除了多加extern 之外,
compile時也要把其他用到的檔案加入makefile裡面.

Q3:程式的執行環境、

A3:此程式的主要執行環境是在 vmware 下的 ubuntu 20.04 ，
使用課堂上提供的arm-none-eabi-insight的ARM simulator進行程式的執行與除錯。
 
Q4:如何執行程式

A4:此程式中，我是使用課堂上提供的arm-none-eabi-insight執行程式。
由於我是直接在虛擬機上下載的linux系統,所以不用另外下載x server。
在根目錄下這個指令後~/assem/arm-newtool/bin/arm-none-eabi-insight
接著設置好Target setting為ARM simulator，再選擇本次作業的執行檔hw6.exe。
就可以利用insight去做本程式的模擬執行與除錯。
除此之外，
在此作業中我將指令加入 makefile 中，以 "make gbd"進行程式的執行。


