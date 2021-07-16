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
210 count=0
220 'Varsion_Name$:ヴァージョンネーム
230 Varsion_Name$ = "バージョン:0.1.0.2021.07.16"
240 dim buffer_Maya_chart$(52*3+1,14)
250 '1-2:buffer_Sun_crist$(縦のデーター 261,横のデーター 2):太陽の紋章
260 dim buffer_Sun_crest$(261,2)
270 '1-3:buffer_Wave_Spell$(縦のデータ261 ,横のデーター  2):ウェーブスペル
280 dim buffer_Wave_spell$(261,2)
290 '1.マヤチャートデーター読み込み
300 open "data/Maya_Chart1.csv" for input as #1
310 for i=0 to (52*3)
320 for j=0 to 13
330 input #1,buffer_Maya_chart$(i,j)
340 next j
350 next i
360 close #1
370 '2.太陽の紋章データーの読み込み
380 open "data/Sun_crest.csv" for input as #2
390 for i=0 to 260
400 for j=0 to 1
410 input #2,buffer_Sun_crest$(i,j)
420 next j
430 next i
440 close #2
450 '3.ウェーブ スペル データーの読み込み
460 open "data/Wave_Spell.csv" for input as #3
470 for i=0 to 260
480 for j=0 to 1
490 input #3,buffer_Wave_spell$(i,j)
500 next j
510 next i
520 close #3
530 goto Top_Screen:
540 '初期化関数  All_erase()
550 buf_erase:
560 erase buffer_Sun_crest$
570 erase buffer_Maya_chart$
580 erase buffer_Wave_spell$
590 end
600 func All_erase()
610 'メモリーを消去
620 endfunc
630 'clear=All_erase()
640 Top_Screen:
650 cls 3:font 48
660 gload "Picture/Screen1.png",0,0,0
670 'Voice フォルダ "data/voice"
680 play ""
690 play "data/voice/Main_Screen.mp3"
700 'トップ画面
710 color rgb(255,255,255)
720 print "メイン画面"+chr$(13)
730 color  rgb(212,255,127)
740 print "番号を選んでください"+chr$(13)
750 print "1.マヤ暦占い"+chr$(13)
760 print "2.設定"+chr$(13)
770 print "3.ヘルプ"+chr$(13)
780 print "4.プログラム終了"+chr$(13)
790 color  rgb(0,0,0)
800 Input"番号:",key
810 '誕生日入力に飛ぶ
820 if key = 1 then play "":goto Menu1_Input_Year:
830 if key = 2 then play "":goto Config_Top:
840 if key = 3 then play "":goto Help_Screen_Top:
850 '選択肢４ プログラム終了 メモリーを消去して終了する
860 if key = 4 then cls 3:play "":color rgb(255,255,255):goto buf_erase:
870 if key > 4 then talk "番号をもう一度入れてください":goto Top_Screen:
880 'マヤ暦 占い 誕生日入力 西暦入力
890 '年入力
900 Menu1_Input_Year:
910 cls 3
920 '非表示 ここから
930 gload "Picture/Screen1.png",1,0,0
940 '非表示　ここまで
950 '表示　ここから
960 gload "Picture/Input_born_year.png",0,0,0
970 '表示　ここまで
980 'Voice:data/voice/born_year.mp3"
990 play ""
1000 play "data/voice/born_year.mp3"
1010 color rgb(255,255,255)
1020 print"生まれた年を入れてください"+chr$(13)
1030 color rgb(0,0,0)
1040 Input"生れた年(1910〜)：",born_year
1050 if ((born_year > 2065) or (born_year<1910)) then goto Menu1_Input_Year:
1060 '月入力
1070 Menu1_Input_Month:
1080 cls
1090 'Voice:/data/voice/born_month.mp3"
1100 play ""
1110 play "data/voice/born_month.mp3"
1120 color rgb(255,255,255)
1130 print"生れた月を入れてください"+chr$(13)
1140 color rgb(0,0,0)
1150 Input"生れた月:",born_month
1160 if born_month > 12 then goto Menu1_Input_Month:
1170 '日付入力
1180 Menu1_Input_Day:
1190 cls
1200 'Voice:data/voice/born_day.mp3
1210 play ""
1220 play"data/voice/born_day.mp3"
1230 color rgb(255,255,255)
1240 print"生れた日を入れてください"+chr$(13)
1250 color rgb(0,0,0)
1260 Input"生れた日:",born_day
1270 if born_day > 31 then play "":goto Menu1_Input_Day:
1280 play ""
1290 '計算領域
1300 Maya_Value1 = val(buffer_Maya_chart$(born_year - 1909,born_month))
1310 Maya_Value = Maya_Value1 + born_day
1320 'うるう年変数  チェック:Maya_Uruu
1330 Maya_Uruu = val(buffer_Maya_chart$(born_year - 1909,13))
1340 '閏年チェック
1350 '閏年ではないとき Maya_Uruu = 0
1360 if Maya_Uruu = 0 then
1370 if Maya_Value < 260 then
1380 if (born_month = 3 and born_day >= 1 and born_day =< 31) then
1390 'sun crest:太陽の紋章
1400 sun_crest = Maya_Value + 1
1410 else
1420 sun_crest = Maya_Value
1430 endif
1440 else
1450 if Maya_Value > 260 then
1460 sun_crest = Maya_Value - 260
1470 endif
1480 endif
1490 else
1500 '閏年のとき  Maya_Uruu=1
1510 if Maya_Uruu = 1 then
1520 if Maya_Value < 260 then
1530 sun_crest=Maya_Value
1540 if (born_month = 3 and born_day >= 1 and born_day =< 31) then
1550 sun_crest = Maya_Value + 1 + 1
1560 else
1570 sun_crest = Maya_Value + 1
1580 endif
1590 else
1600 if Maya_Value > 260 then
1610 sun_crest = (Maya_Value - 260) + 1
1620 endif
1630 endif
1640 endif
1650 endif
1660 '太陽の紋章:Sun_crest$
1670 Sun_crest$ = buffer_Sun_crest$(sun_crest,1)
1680 'ウエイブスペル:wave_spell$=
1690 Wave_spell$ = buffer_Wave_spell$(sun_crest,1)
1700 cls 3
1710 gload "Picture/Result_Screen.png",0,0,0
1720 'voice:data/voice/Result_Message.mp3"
1730 play ""
1740 play "data/voice/Result_Message.mp3"
1750 COLOR rgb(255,255,255)
1760 print "マヤ暦 診断結果";chr$(13)
1770 color rgb(212,255,127)
1780 print "あなたのマヤ暦は";chr$(13)
1790 print "生れた年:";born_year;chr$(13)
1800 print "生れた月:";born_month;chr$(13)
1810 print "生れた日:";born_day;chr$(13)
1820 print "太陽の紋章:";Sun_crest$;chr$(13)
1830 print "ウェーブスペル:";Wave_spell$;chr$(13)
1840 color rgb(0,0,0)
1850 print "エンターキー:トップ,S:保存する"
1860 a$ = input$(1)
1870 if a$ = chr$(13) then play "":goto Top_Screen
1880 if a$="S" or a$="s" then goto Save_data:
1890 Help_Screen_Top:
1900 cls 3
1910 gload"Picture/Screen1.png",0,0,0
1920 'Voice:Help画面 "data/voice/help_Screen.mp3"
1930 play"data/voice/help_Screen.mp3"
1940 color rgb(255,255,255)
1950 print "ヘルプ" + chr$(13)
1960 color rgb(212,255,157)
1970 PRINT "番号を選んでください" + chr$(13)
1980 print "1.バージョン" + chr$(13)
1990 print "2.参考文献" + chr$(13)
2000 print "3.前の画面に戻る" + chr$(13)
2010 print "4.プログラムの終了" + chr$(13)
2020 color rgb(0,0,0)
2030 Input "番号:",No
2040 if No=1 then play"":Version:
2050 if No=2 then play"": goto Reference_Book:
2060 if No=3 then play"":goto Top_Screen:
2070 if No=4 then color rgb(255,255,255):cls 3:goto buf_erase:
2080 if (No > 4 or No = 0) then play"":goto Help_Screen_Top:
2090 'バージョン情報
2100 Version:
2110 cls 3
2120 'Voice:/data/voice/Version_Screen.mp3"
2130 play "data/voice/version_screen.mp3"
2140 gload"Picture/Screen2.png",0,0,0
2150 color rgb(255,255,255)
2160 print "バージョン" + chr$(13)
2170 color rgb(125,255,212)
2180 print ""+chr$(13)
2190 print "Title:マヤ暦" + chr$(13)
2200 print Varsion_Name$ + chr$(13)
2210 print "（C)copy rights licksjp" + chr$(13)
2220 print "All rights reserved" + chr$(13)
2230 print ""+chr$(13)+chr$(13)
2240 color rgb(0,0,0)
2250 print "エンターキーを押してください" + chr$(13)
2260 key$ = input$(1)
2270 if key$ = chr$(13) then play "":goto Top_Screen:
2280 '参考文献
2290 Reference_Book:
2300 cls 3
2310 gload "Picture/Screen2.png",0,0,0
2320 'voice:/data/voice/Referencebook.mp3
2330 play ""
2340 play "data/voice/Referencebook.mp3"
2350 color rgb(255,255,255)
2360 print"参考文献"+chr$(13)
2370 color rgb(212,255,127)
2380 print"書名:マヤ暦占星術でなりたい自分 を叶える"+chr$(13)
2390 print"出版社:カシオペア出版" + chr$(13)
2400 print"発売：サンクチュアリ出版" + chr$(13)
2410 print"著者：MASAYUKi" + chr$(13)
2420 print"ISBN:978-4-86113-858-4" + chr$(13)
2430 print"定価:1400+税" + chr$(13)+chr$(13)
2440 color rgb(0,0,0)
2450 print"エンターキーを押してください"
2460 key$=Input$(1)
2470 if key$=chr$(13) then play"":goto Top_Screen:
2480 '設定トップメニュー
2490 Config_Top:
2500 cls 3
2510 play ""
2520 play "data/voice/ConfigScreen_Top.mp3"
2530 gload "Picture/Screen1.png",0,0,0
2540 Color rgb(255,255,255)
2550 print "設 定" + chr$(13)
2560 If dir$("data/Parsonal.csv")="" then
2570 color rgb(212,255,127)
2580 print "番号を選んでください" + chr$(13)
2590 print "*.未実装です。" + chr$(13)
2600 print "*.未実装です。" +chr$(13)
2610 print "3.前の画面に戻る" + chr$(13)
2620 print "4.プログラムを終了します" + chr$(13)
2630 else
2640 color rgb(212,255,127)
2650 print "番号を選んでください"+chr$(13)
2660 print "1.登録件数"+chr$(13)
2670 print "*.未実装"+chr$(13)
2680 print "3.前の画面に戻る"+chr$(13)
2690 PRINT "4.プログラムを終了する"+chr$(13)
2700 endif
2710 color rgb(0,0,0)
2720 input "番号：",No
2730 if No=3 then play "":goto Top_Screen:
2740 if No=4 then cls 3:play "":color rgb(255,255,255):goto buf_erase:
2750 '番号1,2は未実装なので、数字は無効
2760 if dir$("data/Parsonal.csv") = "" then
2770 if No=1 or No2=2 or No > 4 then
2780 play "":goto Config_Top:
2790 endif
2800 else
2810 if No=1 then
2820 play "":goto check_entry_count:
2830 'if No=2 then
2840 endif
2850 endif
2860 Save_data:
2870 buf_name$=ui_input$("名前","")
2880 if dir$("data/Parsonal.csv")="" then
2890 open "data/Parsonal.csv" for output as #1
2900 print #1,buf_name$ + ",生まれた年:" + str$(born_year) + ",生まれた月:" + str$(born_month) + ",生まれた日:" + str$(born_day) + ",太陽の紋章:" + Sun_crest$ + ",ウェーブスペース:" + Wave_spell$ + chr$(13)
2910 close #1
2920 else
2930 open "data/Parsonal.csv" for append as #1
2940 print #1,buf_name$ + ",生まれた年:" + str$(born_year) + ",生まれた月:" + str$(born_month) + ",生まれた日:" + str$(born_day) + ",太陽の紋章:" + Sun_crest$ + ",ウェーブスペース:" + Wave_spell$ + chr$(13)
2950 close #1
2960 endif
2970 ui_msg "保存しました":goto Top_Screen:
2980 '登録件数を求める
2990 check_entry_count:
3000 cls 3:count=0
3010 open "data/Parsonal.csv" for input as #1
3020 while (eof(1) = 0)
3030 line input #1,line$:count = count + 1
3040 wend
3050 close #1
3060 COLOR rgb(255,255,255)
3070 print "count=";count-1
