100 'マヤ暦
110 '製作開始:2021年4月8日
120 '
130 '誕生日を入れてマヤ暦の何かを求めるプログラム
140 'トップ画面表示の流れ
150 '1.ファイルを読み込む
160 '2.読み込んだファイルを配列に代入
170 '3.トップ画面表示
180 'ここからスタート
190 '1.配列定義
200 '1-1:buffer_Maya_chart1$(縦のデータ数,横のデーター数):マヤ暦チャート
210 dim buffer_list$(7*10),list$(7*10)
220 count=0
230 'Varsion_Name$:ヴァージョンネーム
240 Varsion_Name$ = "バージョン:0.1.9.2021.07.21"
250 dim buffer_Maya_chart$(52*3+1,14)
260 '1-2:buffer_Sun_crist$(縦のデーター 261,横のデーター 2):太陽の紋章
270 dim buffer_Sun_crest$(261,2)
280 '1-3:buffer_Wave_Spell$(縦のデータ261 ,横のデーター  2):ウェーブスペル
290 dim buffer_Wave_spell$(261,2)
300 '1.マヤチャートデーター読み込み
310 open "data/Maya_Chart1.csv" for input as #1
320 for i=0 to (52*3)
330 for j=0 to 13
340 input #1,buffer_Maya_chart$(i,j)
350 next j
360 next i
370 close #1
380 '2.太陽の紋章データーの読み込み
390 open "data/Sun_crest.csv" for input as #2
400 for i=0 to 260
410 for j=0 to 1
420 input #2,buffer_Sun_crest$(i,j)
430 next j
440 next i
450 close #2
460 '3.ウェーブ スペル データーの読み込み
470 open "data/Wave_Spell.csv" for input as #3
480 for i=0 to 260
490 for j=0 to 1
500 input #3,buffer_Wave_spell$(i,j)
510 next j
520 next i
530 close #3
540 goto Top_Screen:
550 '初期化関数  All_erase()
560 buf_erase:
570 erase buffer_Sun_crest$
580 erase buffer_Maya_chart$
590 erase buffer_Wave_spell$
600 end
610 func All_erase()
620 'メモリーを消去
630 erase line$
640 erase buffer_line$
650 endfunc
660 clear=All_erase()
670 Top_Screen:
680 cls 3:font 48
690 gload "Picture/Screen1.png",0,0,0
700 'Voice フォルダ "data/voice"
710 play ""
720 play "data/voice/Main_Screen.mp3"
730 'トップ画面
740 color rgb(255,255,255)
750 print "メイン画面"+chr$(13)
760 color  rgb(212,255,127)
770 print "番号を選んでください"+chr$(13)
780 print "1.マヤ暦占い"+chr$(13)
790 print "2.設定"+chr$(13)
800 print "3.ヘルプ"+chr$(13)
810 print "4.プログラム終了"+chr$(13)
820 color  rgb(0,0,0)
830 Input"番号:",key
840 '誕生日入力に飛ぶ
850 if key = 1 then play "":goto Menu1_Input_Year:
860 if key = 2 then play "":goto Config_Top:
870 if key = 3 then play "":goto Help_Screen_Top:
880 '選択肢４ プログラム終了 メモリーを消去して終了する
890 if key = 4 then cls 3:play "":color rgb(255,255,255):clear:end
900 if key > 4 then talk "番号をもう一度入れてください":goto Top_Screen:
910 'マヤ暦 占い 誕生日入力 西暦入力
920 '年入力
930 Menu1_Input_Year:
940 cls 3
950 '非表示 ここから
960 gload "Picture/Screen1.png",1,0,0
970 '非表示　ここまで
980 '表示　ここから
990 gload "Picture/Input_born_year.png",0,0,0
1000 '表示　ここまで
1010 'Voice:data/voice/born_year.mp3"
1020 play ""
1030 play "data/voice/born_year.mp3"
1040 color rgb(255,255,255)
1050 print"生まれた年を入れてください"+chr$(13)
1060 color rgb(0,0,0)
1070 Input"生れた年(1910〜)：",born_year
1080 if ((born_year > 2065) or (born_year<1910)) then goto Menu1_Input_Year:
1090 '月入力
1100 Menu1_Input_Month:
1110 cls
1120 'Voice:/data/voice/born_month.mp3"
1130 play ""
1140 play "data/voice/born_month.mp3"
1150 color rgb(255,255,255)
1160 print"生れた月を入れてください"+chr$(13)
1170 color rgb(0,0,0)
1180 Input"生れた月:",born_month
1190 if born_month > 12 then goto Menu1_Input_Month:
1200 '日付入力
1210 Menu1_Input_Day:
1220 cls
1230 'Voice:data/voice/born_day.mp3
1240 play ""
1250 play"data/voice/born_day.mp3"
1260 color rgb(255,255,255)
1270 print"生れた日を入れてください"+chr$(13)
1280 color rgb(0,0,0)
1290 Input"生れた日:",born_day
1300 if born_day > 31 then play "":goto Menu1_Input_Day:
1310 play ""
1320 '計算領域
1330 Maya_Value1 = val(buffer_Maya_chart$(born_year - 1909,born_month))
1340 Maya_Value = Maya_Value1 + born_day
1350 'うるう年変数  チェック:Maya_Uruu
1360 Maya_Uruu = val(buffer_Maya_chart$(born_year - 1909,13))
1370 '閏年チェック
1380 '閏年ではないとき Maya_Uruu = 0
1390 if Maya_Uruu = 0 then
1400 if Maya_Value < 260 then
1410 if (born_month = 3 and born_day >= 1 and born_day =< 31) then
1420 'sun crest:太陽の紋章
1430 sun_crest = Maya_Value + 1
1440 else
1450 sun_crest = Maya_Value
1460 endif
1470 else
1480 if Maya_Value > 260 then
1490 sun_crest = Maya_Value - 260
1500 endif
1510 endif
1520 else
1530 '閏年のとき  Maya_Uruu=1
1540 if Maya_Uruu = 1 then
1550 if Maya_Value < 260 then
1560 sun_crest=Maya_Value
1570 if (born_month = 3 and born_day >= 1 and born_day =< 31) then
1580 sun_crest = Maya_Value + 1 + 1
1590 else
1600 sun_crest = Maya_Value + 1
1610 endif
1620 else
1630 if Maya_Value > 260 then
1640 sun_crest = (Maya_Value - 260) + 1
1650 endif
1660 endif
1670 endif
1680 endif
1690 '太陽の紋章:Sun_crest$
1700 Sun_crest$ = buffer_Sun_crest$(sun_crest,1)
1710 'ウエイブスペル:wave_spell$=
1720 Wave_spell$ = buffer_Wave_spell$(sun_crest,1)
1730 cls 3
1740 gload "Picture/Result_Screen.png",0,0,0
1750 'voice:data/voice/Result_Message.mp3"
1760 play ""
1770 play "data/voice/Result_Message.mp3"
1780 COLOR rgb(255,255,255)
1790 print "マヤ暦 診断結果";chr$(13)
1800 color rgb(212,255,127)
1810 print "あなたのマヤ暦は";chr$(13)
1820 print "生れた年:";born_year;chr$(13)
1830 print "生れた月:";born_month;chr$(13)
1840 print "生れた日:";born_day;chr$(13)
1850 print "太陽の紋章:";Sun_crest$;chr$(13)
1860 print "ウェーブスペル:";Wave_spell$;chr$(13)
1870 color rgb(0,0,0)
1880 print "エンターキー:トップ,S:保存する"
1890 a$ = input$(1)
1900 if a$ = chr$(13) then play "":goto Top_Screen
1910 if a$="S" or a$="s" then goto Save_data:
1920 Help_Screen_Top:
1930 cls 3
1940 gload"Picture/Screen1.png",0,0,0
1950 'Voice:Help画面 "data/voice/help_Screen.mp3"
1960 play"data/voice/help_Screen.mp3"
1970 color rgb(255,255,255)
1980 print "ヘルプ" + chr$(13)
1990 color rgb(212,255,157)
2000 PRINT "番号を選んでください" + chr$(13)
2010 print "1.バージョン" + chr$(13)
2020 print "2.参考文献" + chr$(13)
2030 print "3.前の画面に戻る" + chr$(13)
2040 print "4.プログラムの終了" + chr$(13)
2050 color rgb(0,0,0)
2060 Input "番号:",No
2070 if No=1 then play"":Version:
2080 if No=2 then play"": goto Reference_Book:
2090 if No=3 then play"":goto Top_Screen:
2100 if No=4 then color rgb(255,255,255):cls 3:clear
2110 if (No > 4 or No = 0) then play"":goto Help_Screen_Top:
2120 'バージョン情報
2130 Version:
2140 cls 3
2150 'Voice:/data/voice/Version_Screen.mp3"
2160 play "data/voice/version_screen.mp3"
2170 gload"Picture/Screen2.png",0,0,0
2180 color rgb(255,255,255)
2190 print "バージョン" + chr$(13)
2200 color rgb(125,255,212)
2210 print ""+chr$(13)
2220 print "Title:マヤ暦" + chr$(13)
2230 print Varsion_Name$ + chr$(13)
2240 print "（C)copy rights licksjp" + chr$(13)
2250 print "All rights reserved" + chr$(13)
2260 print ""+chr$(13)+chr$(13)
2270 color rgb(0,0,0)
2280 print "エンターキーを押してください" + chr$(13)
2290 key$ = input$(1)
2300 if key$ = chr$(13) then play "":goto Top_Screen:
2310 '参考文献
2320 Reference_Book:
2330 cls 3
2340 gload "Picture/Screen2.png",0,0,0
2350 'voice:/data/voice/Referencebook.mp3
2360 play ""
2370 play "data/voice/Referencebook.mp3"
2380 color rgb(255,255,255)
2390 print"参考文献"+chr$(13)
2400 color rgb(212,255,127)
2410 print"書名:マヤ暦占星術でなりたい自分 を叶える"+chr$(13)
2420 print"出版社:カシオペア出版" + chr$(13)
2430 print"発売：サンクチュアリ出版" + chr$(13)
2440 print"著者：MASAYUKi" + chr$(13)
2450 print"ISBN:978-4-86113-858-4" + chr$(13)
2460 print"定価:1400+税" + chr$(13)+chr$(13)
2470 color rgb(0,0,0)
2480 print"エンターキーを押してください"
2490 key$=Input$(1)
2500 if key$=chr$(13) then play"":goto Top_Screen:
2510 '設定トップメニュー
2520 Config_Top:
2530 cls 3
2540 play ""
2550 play "data/voice/ConfigScreen_Top.mp3"
2560 gload "Picture/Screen1.png",0,0,0
2570 Color rgb(255,255,255)
2580 print "設 定" + chr$(13)
2590 If dir$("data/Parsonal.csv")="" then
2600 color rgb(212,255,127)
2610 print "番号を選んでください" + chr$(13)
2620 print "*.未実装です。" + chr$(13)
2630 print "*.未実装です。" +chr$(13)
2640 print "3.前の画面に戻る" + chr$(13)
2650 print "4.プログラムを終了します" + chr$(13)
2660 else
2670 color rgb(212,255,127)
2680 print "番号を選んでください"+chr$(13)
2690 print "1.登録件数"+chr$(13)
2700 print "2.登録リスト"+chr$(13)
2710 print "3.前の画面に戻る"+chr$(13)
2720 PRINT "4.プログラムを終了する"+chr$(13)
2730 endif
2740 color rgb(0,0,0)
2750 input "番号：",No
2760 if No=3 then play "":goto Top_Screen:
2770 if No=4 then cls 3:play "":color rgb(255,255,255):goto buf_erase:
2780 '番号1,2は未実装なので、数字は無効
2790 if dir$("data/Parsonal.csv") = "" then
2800 if No=1 or No2=2 or No > 4 then
2810 play "":goto Config_Top:
2820 endif
2830 else
2840 if No=1 then
2850 play "":goto check_entry_count:
2860 endif
2870 if No=2 then
2880 play"":goto Entry_Parsonal_list:
2890 endif
2900 endif
2910 Save_data:
2920 buf_name$=ui_input$("名前","")
2930 if dir$("data/Parsonal.csv")="" then
2940 open "data/Parsonal.csv" for output as #1
2950 print #1,"番号" + ",名  前" + ",生まれた年" + ",生まれた月" + ",生まれた日" + ",太陽の紋章" + ",ウェーブスペース"
2960 close #1
2970 open "data/Parsonal.csv" for append as #2
2980 print #2,str$(n+1) + "," + buf_name$+"," + str$(born_year) + "," + str$(born_month) + "," + str$(born_day)+"," + Sun_crest$ + "," + Wave_spell$
2990 close #2
3000 else
3010 open "data/Parsonal.csv" for append as #1
3020 print #1,str$(n+1)+"," + buf_name$+"," + str$(born_year) + "," + str$(born_month) + "," + str$(born_day) + "," + Sun_crest$ + "," + Wave_spell$
3030 close #1
3040 endif
3050 ui_msg "保存しました":goto Top_Screen:
3060 '登録件数を求める
3070 check_entry_count:
3080 cls 3:count=0
3090 open "data/Parsonal.csv" for input as #1
3100 while (eof(1) = 0)
3110 line input #1,line$:count = count + 1
3120 wend
3130 close #1
3140 COLOR rgb(255,255,255)
3150 gload "Picture/Input_born_year.png"
3160 talk "登録件数は" + str$(count-1)+"件です"
3170 print "登録件数は、";count-1;"件数です"+chr$(13)
3180 print "エンターキーを押してください";chr$(13)
3190 key$ = input$(1)
3200 if key$=chr$(13) then goto Top_Screen:
3210 '登録リスト
3220 Entry_Parsonal_list:
3230 cls 3:
3240 gload "Picture/Result_Screen.png"
3250 '登録件数を出す
3260 count=0
3270 open "data/Parsonal.csv" for input as #1
3280 while (eof(1)=0)
3290 line input #1,line$:count = count + 1
3300 wend
3310 close #1
3320 N = count
3330 open "data/Parsonal.csv" for input as #1
3340 for i=0 to (N * 7) - 1
3350 input #1,buffer_list$(i)
3360 next i
3370 'wend
3380 close #1
3390 for j = 7 to ((N*7) - 1)
3400 list$(j-7) = buffer_list$(j)
3410 next j
3420 'erase buffer_list$
3430 'cls
3440 'print "マヤ暦　登録リスト" + chr$(13)
3450 'print chr$(13)
3460 n=0
3470 while (n < (7*(N-1)) - 1)
3480 color rgb(212,255,127)
3490 'if (n=1) then
3500 'print "No:";list$(7*(n-1)+0) + chr$(13)
3510 'print "名前:";list$(7*(n-1)+1) + chr$(13)
3520 'print "誕生日:";list$(7*(n-1)+2);"年";list$(7*(n-1)+3);"月";list$(7*(n-1)+4);"日"+chr$(13)
3530 'print "太陽の紋章:";list$(7*(n-1)+5)+chr$(13)
3540 'print "ウェーブスペース:";list$(7*(n-1)+6)
3550 'color rgb(255,255,255)
3560 'print "エンターキー:トップ" + chr$(13)
3570 'key$ = input$(1)
3580 'if key$ = chr$(13) then goto Top_Screen:
3590 'else
3600 cls
3610 print "マヤ暦 登録リスト";"n=";n;chr$(13)
3620 print chr$(13)
3630 print "No:";list$((7*n)+0)+chr$(13)
3640 print "名前:";list$((7*n)+1) ;chr$(13)
3650 print "誕生日:";list$((7*n)+2);"年";list$((7*n)+3);"月";list$((7*n)+4);"日"+chr$(13)
3660 print "太陽の紋章:";list$((7*n)+5)+chr$(13)
3670 print "ウェーブスペース:";list$((7*n)+6)+chr$(13)
3680 color rgb(255,255,255)
3690 print "スペース:次へ、エンターキー:トップ"+chr$(13)
3700 'n=n+1
3710 key$ = input$(1)
3720 'n=n+1
3730 if key$ = chr$(13) then goto Top_Screen:
3740 if key$ = " " then n=((n+1) mod (N-1))
3750 wend
