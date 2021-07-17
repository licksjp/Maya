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
210 dim buffer_list$(16)
220 count=0
230 'Varsion_Name$:ヴァージョンネーム
240 Varsion_Name$ = "バージョン:0.1.1.2021.07.17"
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
630 endfunc
640 'clear=All_erase()
650 Top_Screen:
660 cls 3:font 48
670 gload "Picture/Screen1.png",0,0,0
680 'Voice フォルダ "data/voice"
690 play ""
700 play "data/voice/Main_Screen.mp3"
710 'トップ画面
720 color rgb(255,255,255)
730 print "メイン画面"+chr$(13)
740 color  rgb(212,255,127)
750 print "番号を選んでください"+chr$(13)
760 print "1.マヤ暦占い"+chr$(13)
770 print "2.設定"+chr$(13)
780 print "3.ヘルプ"+chr$(13)
790 print "4.プログラム終了"+chr$(13)
800 color  rgb(0,0,0)
810 Input"番号:",key
820 '誕生日入力に飛ぶ
830 if key = 1 then play "":goto Menu1_Input_Year:
840 if key = 2 then play "":goto Config_Top:
850 if key = 3 then play "":goto Help_Screen_Top:
860 '選択肢４ プログラム終了 メモリーを消去して終了する
870 if key = 4 then cls 3:play "":color rgb(255,255,255):goto buf_erase:
880 if key > 4 then talk "番号をもう一度入れてください":goto Top_Screen:
890 'マヤ暦 占い 誕生日入力 西暦入力
900 '年入力
910 Menu1_Input_Year:
920 cls 3
930 '非表示 ここから
940 gload "Picture/Screen1.png",1,0,0
950 '非表示　ここまで
960 '表示　ここから
970 gload "Picture/Input_born_year.png",0,0,0
980 '表示　ここまで
990 'Voice:data/voice/born_year.mp3"
1000 play ""
1010 play "data/voice/born_year.mp3"
1020 color rgb(255,255,255)
1030 print"生まれた年を入れてください"+chr$(13)
1040 color rgb(0,0,0)
1050 Input"生れた年(1910〜)：",born_year
1060 if ((born_year > 2065) or (born_year<1910)) then goto Menu1_Input_Year:
1070 '月入力
1080 Menu1_Input_Month:
1090 cls
1100 'Voice:/data/voice/born_month.mp3"
1110 play ""
1120 play "data/voice/born_month.mp3"
1130 color rgb(255,255,255)
1140 print"生れた月を入れてください"+chr$(13)
1150 color rgb(0,0,0)
1160 Input"生れた月:",born_month
1170 if born_month > 12 then goto Menu1_Input_Month:
1180 '日付入力
1190 Menu1_Input_Day:
1200 cls
1210 'Voice:data/voice/born_day.mp3
1220 play ""
1230 play"data/voice/born_day.mp3"
1240 color rgb(255,255,255)
1250 print"生れた日を入れてください"+chr$(13)
1260 color rgb(0,0,0)
1270 Input"生れた日:",born_day
1280 if born_day > 31 then play "":goto Menu1_Input_Day:
1290 play ""
1300 '計算領域
1310 Maya_Value1 = val(buffer_Maya_chart$(born_year - 1909,born_month))
1320 Maya_Value = Maya_Value1 + born_day
1330 'うるう年変数  チェック:Maya_Uruu
1340 Maya_Uruu = val(buffer_Maya_chart$(born_year - 1909,13))
1350 '閏年チェック
1360 '閏年ではないとき Maya_Uruu = 0
1370 if Maya_Uruu = 0 then
1380 if Maya_Value < 260 then
1390 if (born_month = 3 and born_day >= 1 and born_day =< 31) then
1400 'sun crest:太陽の紋章
1410 sun_crest = Maya_Value + 1
1420 else
1430 sun_crest = Maya_Value
1440 endif
1450 else
1460 if Maya_Value > 260 then
1470 sun_crest = Maya_Value - 260
1480 endif
1490 endif
1500 else
1510 '閏年のとき  Maya_Uruu=1
1520 if Maya_Uruu = 1 then
1530 if Maya_Value < 260 then
1540 sun_crest=Maya_Value
1550 if (born_month = 3 and born_day >= 1 and born_day =< 31) then
1560 sun_crest = Maya_Value + 1 + 1
1570 else
1580 sun_crest = Maya_Value + 1
1590 endif
1600 else
1610 if Maya_Value > 260 then
1620 sun_crest = (Maya_Value - 260) + 1
1630 endif
1640 endif
1650 endif
1660 endif
1670 '太陽の紋章:Sun_crest$
1680 Sun_crest$ = buffer_Sun_crest$(sun_crest,1)
1690 'ウエイブスペル:wave_spell$=
1700 Wave_spell$ = buffer_Wave_spell$(sun_crest,1)
1710 cls 3
1720 gload "Picture/Result_Screen.png",0,0,0
1730 'voice:data/voice/Result_Message.mp3"
1740 play ""
1750 play "data/voice/Result_Message.mp3"
1760 COLOR rgb(255,255,255)
1770 print "マヤ暦 診断結果";chr$(13)
1780 color rgb(212,255,127)
1790 print "あなたのマヤ暦は";chr$(13)
1800 print "生れた年:";born_year;chr$(13)
1810 print "生れた月:";born_month;chr$(13)
1820 print "生れた日:";born_day;chr$(13)
1830 print "太陽の紋章:";Sun_crest$;chr$(13)
1840 print "ウェーブスペル:";Wave_spell$;chr$(13)
1850 color rgb(0,0,0)
1860 print "エンターキー:トップ,S:保存する"
1870 a$ = input$(1)
1880 if a$ = chr$(13) then play "":goto Top_Screen
1890 if a$="S" or a$="s" then goto Save_data:
1900 Help_Screen_Top:
1910 cls 3
1920 gload"Picture/Screen1.png",0,0,0
1930 'Voice:Help画面 "data/voice/help_Screen.mp3"
1940 play"data/voice/help_Screen.mp3"
1950 color rgb(255,255,255)
1960 print "ヘルプ" + chr$(13)
1970 color rgb(212,255,157)
1980 PRINT "番号を選んでください" + chr$(13)
1990 print "1.バージョン" + chr$(13)
2000 print "2.参考文献" + chr$(13)
2010 print "3.前の画面に戻る" + chr$(13)
2020 print "4.プログラムの終了" + chr$(13)
2030 color rgb(0,0,0)
2040 Input "番号:",No
2050 if No=1 then play"":Version:
2060 if No=2 then play"": goto Reference_Book:
2070 if No=3 then play"":goto Top_Screen:
2080 if No=4 then color rgb(255,255,255):cls 3:goto buf_erase:
2090 if (No > 4 or No = 0) then play"":goto Help_Screen_Top:
2100 'バージョン情報
2110 Version:
2120 cls 3
2130 'Voice:/data/voice/Version_Screen.mp3"
2140 play "data/voice/version_screen.mp3"
2150 gload"Picture/Screen2.png",0,0,0
2160 color rgb(255,255,255)
2170 print "バージョン" + chr$(13)
2180 color rgb(125,255,212)
2190 print ""+chr$(13)
2200 print "Title:マヤ暦" + chr$(13)
2210 print Varsion_Name$ + chr$(13)
2220 print "（C)copy rights licksjp" + chr$(13)
2230 print "All rights reserved" + chr$(13)
2240 print ""+chr$(13)+chr$(13)
2250 color rgb(0,0,0)
2260 print "エンターキーを押してください" + chr$(13)
2270 key$ = input$(1)
2280 if key$ = chr$(13) then play "":goto Top_Screen:
2290 '参考文献
2300 Reference_Book:
2310 cls 3
2320 gload "Picture/Screen2.png",0,0,0
2330 'voice:/data/voice/Referencebook.mp3
2340 play ""
2350 play "data/voice/Referencebook.mp3"
2360 color rgb(255,255,255)
2370 print"参考文献"+chr$(13)
2380 color rgb(212,255,127)
2390 print"書名:マヤ暦占星術でなりたい自分 を叶える"+chr$(13)
2400 print"出版社:カシオペア出版" + chr$(13)
2410 print"発売：サンクチュアリ出版" + chr$(13)
2420 print"著者：MASAYUKi" + chr$(13)
2430 print"ISBN:978-4-86113-858-4" + chr$(13)
2440 print"定価:1400+税" + chr$(13)+chr$(13)
2450 color rgb(0,0,0)
2460 print"エンターキーを押してください"
2470 key$=Input$(1)
2480 if key$=chr$(13) then play"":goto Top_Screen:
2490 '設定トップメニュー
2500 Config_Top:
2510 cls 3
2520 play ""
2530 play "data/voice/ConfigScreen_Top.mp3"
2540 gload "Picture/Screen1.png",0,0,0
2550 Color rgb(255,255,255)
2560 print "設 定" + chr$(13)
2570 If dir$("data/Parsonal.csv")="" then
2580 color rgb(212,255,127)
2590 print "番号を選んでください" + chr$(13)
2600 print "*.未実装です。" + chr$(13)
2610 print "*.未実装です。" +chr$(13)
2620 print "3.前の画面に戻る" + chr$(13)
2630 print "4.プログラムを終了します" + chr$(13)
2640 else
2650 color rgb(212,255,127)
2660 print "番号を選んでください"+chr$(13)
2670 print "1.登録件数"+chr$(13)
2680 print "2.登録リスト"+chr$(13)
2690 print "3.前の画面に戻る"+chr$(13)
2700 PRINT "4.プログラムを終了する"+chr$(13)
2710 endif
2720 color rgb(0,0,0)
2730 input "番号：",No
2740 if No=3 then play "":goto Top_Screen:
2750 if No=4 then cls 3:play "":color rgb(255,255,255):goto buf_erase:
2760 '番号1,2は未実装なので、数字は無効
2770 if dir$("data/Parsonal.csv") = "" then
2780 if No=1 or No2=2 or No > 4 then
2790 play "":goto Config_Top:
2800 endif
2810 else
2820 if No=1 then
2830 play "":goto check_entry_count:
2840 endif
2850 if No=2 then
2860 play"":goto Entry_Parsonal_list:
2870 endif
2880 endif
2890 Save_data:
2900 buf_name$=ui_input$("名前","")
2910 if dir$("data/Parsonal.csv")="" then
2920 open "data/Parsonal.csv" for output as #1
2930 print #1,"番号" + ",名  前" + ",生まれた年" + ",生まれた月" + ",生まれた日" + ",太陽の紋章" + ",ウェーブスペース"
2940 close #1
2950 open "data/Parsonal.csv" for append as #2
2960 print #2,str$(count + 1) + "," + buf_name$+"," + str$(born_year) + "," + str$(born_month) + "," + str$(born_day)+"," + Sun_crest$ + "," + Wave_spell$
2970 close #2
2980 else
2990 open "data/Parsonal.csv" for append as #1
3000 print #1,str$(count+1)+","+buf_name$+"," + str$(born_year)+"," + str$(born_month)+"," + str$(born_day)+"," + Sun_crest$ + "," Wave_spell$ + chr$(13)
3010 close #1
3020 endif
3030 ui_msg "保存しました":goto Top_Screen:
3040 '登録件数を求める
3050 check_entry_count:
3060 cls 3:count=0
3070 open "data/Parsonal.csv" for input as #1
3080 while (eof(1) = 0)
3090 line input #1,line$:count = count + 1
3100 wend
3110 close #1
3120 COLOR rgb(255,255,255)
3130 count = count - 2
3140 gload "Picture/Input_born_year.png"
3150 talk "登録件数は"+str$(count-1)+"件です"
3160 print "登録件数は、";count;"件数です"+chr$(13)
3170 print "エンターキーを押してください";chr$(13)
3180 key$=input$(1)
3190 if key$=chr$(13) then goto Top_Screen:
3200 '登録リスト
3210 Entry_Parsonal_list:
3220 cls 3:
3230 gload "Picture/Result_Screen.png"
3240 open "data/Parsonal.csv" for input as #1
3250 'while (eof(1)=0)
3260 'for j=1 to count-1
3270 for i=0 to 2*7-1
3280 input #1,buffer_list$(i)
3290 next i
3300 'NEXT j
3310 'wend
3320 close #1
3330 cls
3340 print "マヤ暦　登録リスト" + chr$(13)
3350 print chr$(13)
3360 'j=1
3370 'while (j < 2)
3380 print "No:";buffer_list$(7) + chr$(13)
3390 print "名前:";buffer_list$(8) + chr$(13)
3400 print "誕生日:";buffer_list$(9);"年";buffer_list$(10);"月";buffer_list$(11);"日" +chr$(13)
3410 print "太陽の紋章:";buffer_list$(12)+chr$(13)
3420 print "ウェーブスペース:";buffer_list$(13)+chr$(13)
3430 color rgb(255,255,255)
3440 print "エンターキーを押してください"+chr$(13)
3450 key$=input$(1)
3460 if key$=chr$(13) then end
3470 'wend
