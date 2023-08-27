組合語言 作業七

409410025 資工三 邱晨恩

1: 描述你程式的內容
 主要是程式碼的計算時間以及與原來數值的誤差說明： 
 此次程式包含兩個部分，第一個檔案 hw7.c 為無 SIMD 指令進行 shift / float point 運算，
 第二個檔案 hw7simd.c 則利用 SIMD 指令進行矩陣運算，各編譯為 hw7.exe 及 hw7simd.exe。
 第一個hw7.c的檔案是由老師提供的rgab2.c,
 用來當作無simd指令下,
 運算的初始效能速度.這邊我使用到了timespec這個資料結構幫忙計算時間.

 而第二個hw7simd.c主要是在運算部份通通使用simd的指令,已達到提升計算效能的目的.
 這一點在以下的實驗數據可以看到,兩者之間明顯的差異.
 而我自己作運算優話的部份有shift指令和addtion of float point
 需要將浮點數強至轉型轉回整數的部份為指令mm_cvtps_epi32
 這個指令特別的地方在於說,他是採取rounding的作法
 也就是算出來的小數數值會4捨5入變成整數,
 因此,我的計算結果在經由我的測試後,
 和原本hw7.c的版本會有5.7%的誤差.

2: 執行環境
 CPU型號: Intel(R) Core(TM) i5-10300H CPU @ 2.50GHz
 記憶體: 16GB
 作業系統: ubuntu 20.04
 此程式的主要執行環境是在 vmware 上 的ubuntu 20.04 上進行程式的編譯與執行。
 gcc 版本為 9.3.0

3: Non-SIMD version: computation 的執行時間 
 在17280*30720的case裡面
 我測了10次,平均下來
 computationTime: 3.671245s
 ----------------------------------------------------------------
 除此之外,我還額外測試了前面變數宣告與賦值的時間
 我測了10次,平均下來
 readTime: 3.641245s

4: SIMD version: computation的執行時間
 在17280*30720的case裡面
 我測了10次,平均下來
 computationTime: 1.423137s
 ----------------------------------------------------------------
 除此之外,我還額外測試了前面變數宣告與賦值的時間
 我測了10次,平均下來
 readTime: 3.667245s
 
5: 如何編譯程式 (編譯時所下的參數)
 gcc  -g -msse -msse2
 編譯時使用了參數: -mss2為了使用sse指令 -msse為了使用sse2指令
 -g 用來方便deubg
 -lrt用來計算時間 

6: 如何執行你的程式
 下完make指令後會產生hw7.exe 與 hw7simd.exe
 以./hw7.exe 與 ./hw7simd.exe 指令
 主要執行環境是在 vmware 下的 ubuntu 20.04 上執行。

7: 使用了哪些指令
 SSE2 的 _mm_srai_epi32 負責4個32bit整數的right shift operation。
 SSE2 的 _mm_and_si128 負責4個32bit以組的整數的and operation.
 SSE 的_mm_add_ps 負責4個32bit float point addtion
 SSE 的_mm_mul_ps :
    負責4個32bit float point multiplication
    原因是原程式有red*0.299的運算
    所以我需要先把原本整數的向量變成浮點數向量後再進行運算
    轉型別的function如下
 SSE2  _mm_cvtepi32_ps： 
    負責作整數轉成浮點數的運算
    其原因為需要進行blue(int type) * 小數的運算
    所以我的作法會先將int -> float
 SSE2  _mm_cvtps_epi32：
    負責作浮點數轉成整數的運算
    其原因為需要進行小數強至轉型整數的運算
    所以我的作法會先將小數的結果利用著個function
    四捨五入後得到整數的vector,方便進行接下來的運算.
 SSE2 的 _mm_slli_epi32負責4個32bit整數的 left shift operation.
 SSE2 的 _mm_add_epi32 負責4個32bit整數的 addition operation.

8: 額外對上述實驗結果之分析
 首先就是如果迴圈數目大幅減低肯定可以加速,
 但是越大的vector,指令的支援越少,
 例如說整數和小數的型別轉換等等.
 如果不用intrinsic function支援,
 單單用迴圈作會很耗時間,因此我做了向量大小的取捨.

 而在計算方面，SIMD的效率比無SIMD快上2.6倍左右。
 也就是計算時間剩下原本的40%左右,
 主要是針對迴圈內從17280*30720比資料變成4320*7680的差距
 計算數量變成原本的0.0625倍,
 利用simd指令還會有把資料搬移過程的overhead,
 而最後的實驗數據顯示,用simd指令比原本快2.6倍是最終的結果.
 已知擺放資料的method會影響使用intrinsic function的效能,
 經過實體測試,可發現利用simd的指令可以有效增加程式碼,
 提昇計算部份的效能與效率.

 然而,這樣的代價是需要額外的記憶體配置空間,
 原因是在於,利用這些simd的指令需要將資料對齊,
 並且資料擺放之放是也會影響程式效能.
 因為如此,可以下一個簡單的結論,
 就是這個simd的intrinsic function有點類似於利用「 空間換取時間 」的技巧.
