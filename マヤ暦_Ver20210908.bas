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
210 'Varsion_Name$:ヴァージョンネーム
220 Varsion_Name$ = "バージョン:0.1.1.2021.09.08"
230 dim buffer_Maya_chart$(52*3+1,14)
240 '1-2:buffer_Sun_crist$(縦のデーター 261,横のデーター 2):太陽の紋章
250 dim buffer_Sun_crest$(261,2)
260 '1-3:buffer_Wave_Spell$(縦のデータ261 ,横のデーター  2):ウェーブスペル
270 dim buffer_Wave_spell$(261,2)
280 '1.マヤチャートデーター読み込み
290 open "config/data/Maya_Chart1.csv" for input as #1
300 for i=0 to (52*3)
310 for j=0 to 13
320 input #1,buffer_Maya_chart$(i,j)
330 next j
340 next i
350 close #1
360 '2.太陽の紋章データーの読み込み
370 open "config/data/Sun_crest.csv" for input as #2
380 for i=0 to 260
390 for j=0 to 1
400 input #2,buffer_Sun_crest$(i,j)
410 next j
420 next i
430 close #2
440 '3.ウェーブ スペル データーの読み込み
450 open "config/data/Wave_Spell.csv" for input as #3
460 for i=0 to 260
470 for j=0 to 1
480 input #3,buffer_Wave_spell$(i,j)
490 next j
500 next i
510 close #3
520 goto Top_Screen:
530 '初期化関数  All_erase()
540 buf_erase:
550 erase buffer_Sun_crest$
560 erase buffer_Maya_chart$
570 erase buffer_Wave_spell$
580 end
590 func All_erase()
600 'メモリーを消去
610 endfunc
620 'clear=All_erase()
630 Top_Screen:
640 cls 3:font 48
650 gload "config/Picture/Screen1.png",0,0,0
660 'Voice フォルダ "data/voice"
670 play ""
680 play "config/data/voice/Main_Screen.mp3"
690 'トップ画面
700 color rgb(255,255,255)
710 print "メイン画面"+chr$(13)
720 color  rgb(212,255,127)
730 print "番号を選んでください"+chr$(13)
740 print "1.マヤ暦占い"+chr$(13)
750 print "2.設定"+chr$(13)
760 print "3.ヘルプ"+chr$(13)
770 print "4.プログラム終了"+chr$(13)
780 color  rgb(0,0,0)
790 Input"番号:",key
800 '誕生日入力に飛ぶ
810 if key = 1 then play "":goto Menu1_Input_Year:
820 if key = 2 then play "":goto Config_Top:
830 if key = 3 then play "":goto Help_Screen_Top:
840 '選択肢４ プログラム終了 メモリーを消去して終了する
850 if key = 4 then cls 3:play "":color rgb(255,255,255):goto buf_erase:
860 if key > 4 then talk "番号をもう一度入れてください":goto Top_Screen:
870 'マヤ暦 占い 誕生日入力 西暦入力
880 '年入力
890 Menu1_Input_Year:
900 cls 3
910 '非表示 ここから
920 gload "config/Picture/Screen1.png",1,0,0
930 '非表示　ここまで
940 '表示　ここから
950 gload "config/Picture/Input_born_year.png",0,0,0
960 '表示　ここまで
970 'Voice:data/voice/born_year.mp3"
980 play ""
990 play "config/data/voice/born_year.mp3"
1000 color rgb(255,255,255)
1010 print"生まれた年を入れてください"+chr$(13)
1020 color rgb(255,0,0)
1030 Input"生れた年(1910〜)：",born_year
1040 if ((born_year > 2065) or (born_year<1910)) then goto Menu1_Input_Year:
1050 '月入力
1060 Menu1_Input_Month:
1070 cls
1080 'Voice:/data/voice/born_month.mp3"
1090 play ""
1100 play "config/data/voice/born_month.mp3"
1110 color rgb(255,0,0)
1120 print"生れた月を入れてください"+chr$(13)
1130 color rgb(0,0,0)
1140 Input"生れた月:",born_month
1150 if born_month > 12 then goto Menu1_Input_Month:
1160 '日付入力
1170 Menu1_Input_Day:
1180 cls
1190 'Voice:data/voice/born_day.mp3
1200 play ""
1210 play"config/data/voice/born_day.mp3"
1220 color rgb(255,0,0)
1230 print"生れた日を入れてください"+chr$(13)
1240 color rgb(0,0,0)
1250 Input"生れた日:",born_day
1260 if born_day > 31 then play "":goto Menu1_Input_Day:
1270 play ""
1280 '計算領域
1290 Maya_Value1 = val(buffer_Maya_chart$(born_year - 1909,born_month))
1300 Maya_Value = Maya_Value1 + born_day
1310 'うるう年変数  チェック:Maya_Uruu
1320 Maya_Uruu = val(buffer_Maya_chart$(born_year - 1909,13))
1330 '閏年チェック
1340 '閏年ではないとき Maya_Uruu = 0
1350 if Maya_Uruu = 0 then
1360 if Maya_Value < 260 then
1370 if (born_month = 3 and born_day >= 1 and born_day =< 31) then
1380 'sun crest:太陽の紋章
1390 sun_crest = Maya_Value + 1
1400 else
1410 sun_crest = Maya_Value
1420 endif
1430 else
1440 if Maya_Value > 260 then
1450 sun_crest = Maya_Value - 260
1460 endif
1470 endif
1480 else
1490 '閏年のとき  Maya_Uruu=1
1500 if Maya_Uruu = 1 then
1510 if Maya_Value < 260 then
1520 sun_crest=Maya_Value
1530 if (born_month = 3 and born_day >= 1 and born_day =< 31) then
1540 sun_crest = Maya_Value + 1 + 1
1550 else
1560 sun_crest = Maya_Value + 1
1570 endif
1580 else
1590 if Maya_Value > 260 then
1600 sun_crest = (Maya_Value - 260) + 1
1610 endif
1620 endif
1630 endif
1640 endif
1650 '太陽の紋章:Sun_crest$
1660 Sun_crest$ = buffer_Sun_crest$(sun_crest,1)
1670 'ウエイブスペル:wave_spell$=
1680 Wave_spell$ = buffer_Wave_spell$(sun_crest,1)
1690 cls 3
1700 gload "config/Picture/Result_Screen.png",0,0,0
1710 'voice:data/voice/Result_Message.mp3"
1720 play ""
1730 play "config/data/voice/Result_Message.mp3"
1740 COLOR rgb(255,255,255)
1750 print "マヤ暦 診断結果";chr$(13)
1760 color rgb(212,255,127)
1770 print "あなたのマヤ暦は";chr$(13)
1780 print "生れた年:";born_year;chr$(13)
1790 print "生れた月:";born_month;chr$(13)
1800 print "生れた日:";born_day;chr$(13)
1810 print "太陽の紋章:";Sun_crest$;chr$(13)
1820 print "ウェーブスペル:";Wave_spell$;chr$(13)
1830 color rgb(0,0,0)
1840 print "エンターキー:トップ,S:保存する"
1850 a$ = input$(1)
1860 if a$ = chr$(13) then play "":goto Top_Screen
1870 if a$="S" or a$="s" then goto Save_data:
1880 Help_Screen_Top:
1890 cls 3
1900 gload"config/Picture/Screen1.png",0,0,0
1910 'Voice:Help画面 "data/voice/help_Screen.mp3"
1920 play"config/data/voice/help_Screen.mp3"
1930 color rgb(255,255,255)
1940 print "ヘルプ" + chr$(13)
1950 color rgb(212,255,157)
1960 PRINT "番号を選んでください" + chr$(13)
1970 print "1.バージョン" + chr$(13)
1980 print "2.参考文献" + chr$(13)
1990 print "3.前の画面に戻る" + chr$(13)
2000 print "4.プログラムの終了" + chr$(13)
2010 color rgb(0,0,0)
2020 Input "番号:",No
2030 if No=1 then play"":goto Version:
2040 if No=2 then play"": goto Reference_Book:
2050 if No=3 then play"":goto Top_Screen:
2060 if No=4 then
2070 play"":color rgb(255,255,255):cls 3:goto buf_erase:
2080 else
2090 play"":goto Help_Screen_Top:
2100 endif
2110 'バージョン情報
2120 Version:
2130 cls 3
2140 'Voice:/data/voice/Version_Screen.mp3"
2150 play "config/data/voice/version_screen.mp3"
2160 gload"config/Picture/Screen2.png",0,0,0
2170 color rgb(255,255,255)
2180 print "バージョン" + chr$(13)
2190 color rgb(125,255,212)
2200 print ""+chr$(13)
2210 print "Title:マヤ暦" + chr$(13)
2220 print Varsion_Name$ + chr$(13)
2230 print "（C)copy rights licksjp" + chr$(13)
2240 print "All rights reserved" + chr$(13)
2250 print ""+chr$(13)+chr$(13)
2260 color rgb(0,0,0)
2270 print "エンターキーを押してください" + chr$(13)
2280 key$ = input$(1)
2290 if key$ = chr$(13) then play "":goto Top_Screen:
2300 '参考文献
2310 Reference_Book:
2320 cls 3
2330 gload "config/Picture/Screen2.png",0,0,0
2340 'voice:/data/voice/Referencebook.mp3
2350 play ""
2360 play "config/data/voice/Referencebook.mp3"
2370 color rgb(255,255,255)
2380 print"参考文献"+chr$(13)
2390 color rgb(212,255,127)
2400 print"書名:マヤ暦占星術でなりたい自分 を叶える"+chr$(13)
2410 print"出版社:カシオペア出版" + chr$(13)
2420 print"発売：サンクチュアリ出版" + chr$(13)
2430 print"著者：MASAYUKi" + chr$(13)
2440 print"ISBN:978-4-86113-858-4" + chr$(13)
2450 print"定価:1400+税" + chr$(13)+chr$(13)
2460 color rgb(0,0,0)
2470 print"エンターキーを押してください"
2480 key$=Input$(1)
2490 if key$=chr$(13) then play"":goto Top_Screen:
2500 '設定トップメニュー
2510 Config_Top:
2520 cls 3
2530 play ""
2540 play "config/data/voice/ConfigScreen_Top.mp3"
2550 gload "config/Picture/Screen1.png",0,0,0
2560 Color rgb(255,255,255)
2570 print "設 定" + chr$(13)
2580 color rgb(212,255,127)
2590 print "番号を選んでください" + chr$(13)
2600 print "*.未実装です。" + chr$(13)
2610 print "*.未実装です。" +chr$(13)
2620 print "3.前の画面に戻る" + chr$(13)
2630 print "4.プログラムを終了します" + chr$(13)
2640 color rgb(0,0,0)
2650 input "番号：",No
2660 if No=3 then play "":goto Top_Screen:
2670 if No=4 then cls 3:play "":color rgb(255,255,255):goto buf_erase:
2680 '番号1,2は未実装なので、数字は無効
2690 if No=1 or No2=2 or No > 4 then play "":goto Config_Top:
2700 if No=2 then play "":goto Config_Top:
2710 Save_data:
2720 buf_name$=ui_input$("名前","")
2730 if dir$("config/data/Parsonal.csv")="" then
2740 open "config/data/Parsonal.csv" for output as #1
2750 print #1,buf_name$ + ",生まれた年:" + str$(born_year) + ",生まれた月:" + str$(born_month) + ",生まれた日:" + str$(born_day) + ",太陽の紋章:" + Sun_crest$ + ",ウェーブスペース:" + Wave_spell$ + chr$(13)
2760 close #1
2770 else
2780 open "config/data/Parsonal.csv" for append as #1
2790 print #1,buf_name$ + ",生まれた年:" + str$(born_year) + ",生まれた月:" + str$(born_month) + ",生まれた日:" + str$(born_day) + ",太陽の紋章:" + Sun_crest$ + ",ウェーブスペース:" + Wave_spell$ + chr$(13)
2800 close #1
2810 endif
2820 ui_msg "保存しました":goto Top_Screen:
