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
220 Varsion_Name$ = "バージョン:0.0.9.2021.07.13"
230 dim buffer_Maya_chart$(52*3+1,14)
240 '1-2:buffer_Sun_crist$(縦のデーター 261,横のデーター 2):太陽の紋章
250 dim buffer_Sun_crest$(261,2)
260 '1-3:buffer_Wave_Spell$(縦のデータ261 ,横のデーター  2):ウェーブスペル
270 dim buffer_Wave_spell$(261,2)
280 '1.マヤチャートデーター読み込み
290 open "data/Maya_Chart1.csv" for input as #1
300 for i=0 to (52*3)
310 for j=0 to 13
320 input #1,buffer_Maya_chart$(i,j)
330 next j
340 next i
350 close #1
360 '2.太陽の紋章データーの読み込み
370 open "data/Sun_crest.csv" for input as #2
380 for i=0 to 260
390 for j=0 to 1
400 input #2,buffer_Sun_crest$(i,j)
410 next j
420 next i
430 close #2
440 '3.ウェーブ スペル データーの読み込み
450 open "data/Wave_Spell.csv" for input as #3
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
650 gload "Picture/Screen1.png",0,0,0
660 'Voice フォルダ "data/voice"
670 play ""
680 play "data/voice/Main_Screen.mp3"
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
920 gload "Picture/Screen1.png",1,0,0
930 '非表示　ここまで
940 '表示　ここから
950 gload "Picture/Input_born_year.png",0,0,0
960 '表示　ここまで
970 'Voice:data/voice/born_year.mp3"
980 play ""
990 play "data/voice/born_year.mp3"
1000 color rgb(255,255,255)
1010 print"生まれた年を入れてください"+chr$(13)
1020 color rgb(0,0,0)
1030 Input"生れた年(1910〜)：",born_year
1040 if ((born_year > 2065) or (born_year<1910)) then goto Menu1_Input_Year:
1050 '月入力
1060 Menu1_Input_Month:
1070 cls
1080 'Voice:/data/voice/born_month.mp3"
1090 play ""
1100 play "data/voice/born_month.mp3"
1110 color rgb(255,255,255)
1120 print"生れた月を入れてください"+chr$(13)
1130 color rgb(0,0,0)
1140 Input"生れた月:",born_month
1150 if born_month > 12 then goto Menu1_Input_Month:
1160 '日付入力
1170 Menu1_Input_Day:
1180 cls
1190 'Voice:data/voice/born_day.mp3
1200 play ""
1210 play"data/voice/born_day.mp3"
1220 color rgb(255,255,255)
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
1700 gload "Picture/Result_Screen.png",0,0,0
1710 'voice:data/voice/Result_Message.mp3"
1720 play ""
1730 play "data/voice/Result_Message.mp3"
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
1840 print "エンターキーを押してください"
1850 a$ = input$(1)
1860 if a$ = chr$(13) then play "":goto Top_Screen
1870 Help_Screen_Top:
1880 cls 3
1890 gload"Picture/Screen1.png",0,0,0
1900 'Voice:Help画面 "data/voice/help_Screen.mp3"
1910 play"data/voice/help_Screen.mp3"
1920 color rgb(255,255,255)
1930 print "ヘルプ" + chr$(13)
1940 color rgb(212,255,157)
1950 PRINT "番号を選んでください" + chr$(13)
1960 print "1.バージョン" + chr$(13)
1970 print "2.参考文献" + chr$(13)
1980 print "3.前の画面に戻る" + chr$(13)
1990 print "4.プログラムの終了" + chr$(13)
2000 color rgb(0,0,0)
2010 Input "番号:",No
2020 if No=1 then play"":Version:
2030 if No=2 then play"": goto Reference_Book:
2040 if No=3 then play"":goto Top_Screen:
2050 if No=4 then color rgb(255,255,255):cls 3:goto buf_erase:
2060 if (No > 4 or No = 0) then play"":goto Help_Screen_Top:
2070 'バージョン情報
2080 Version:
2090 cls 3
2100 'Voice:/data/voice/Version_Screen.mp3"
2110 play "data/voice/version_screen.mp3"
2120 gload"Picture/Screen2.png",0,0,0
2130 color rgb(255,255,255)
2140 print "バージョン" + chr$(13)
2150 color rgb(125,255,212)
2160 print ""+chr$(13)
2170 print "Title:マヤ暦" + chr$(13)
2180 print Varsion_Name$ + chr$(13)
2190 print "（C)copy rights licksjp" + chr$(13)
2200 print "All rights reserved" + chr$(13)
2210 print ""+chr$(13)+chr$(13)
2220 color rgb(0,0,0)
2230 print "エンターキーを押してください" + chr$(13)
2240 key$ = input$(1)
2250 if key$ = chr$(13) then play "":goto Top_Screen:
2260 '参考文献
2270 Reference_Book:
2280 cls 3
2290 gload "Picture/Screen2.png",0,0,0
2300 'voice:/data/voice/Referencebook.mp3
2310 play ""
2320 play "data/voice/Referencebook.mp3"
2330 color rgb(255,255,255)
2340 print"参考文献"+chr$(13)
2350 color rgb(212,255,127)
2360 print"書名:マヤ暦占星術でなりたい自分 を叶える"+chr$(13)
2370 print"出版社:カシオペア出版" + chr$(13)
2380 print"発売：サンクチュアリ出版" + chr$(13)
2390 print"著者：MASAYUKi" + chr$(13)
2400 print"ISBN:978-4-86113-858-4" + chr$(13)
2410 print"定価:1400+税" + chr$(13)+chr$(13)
2420 color rgb(0,0,0)
2430 print"エンターキーを押してください"
2440 key$=Input$(1)
2450 if key$=chr$(13) then play"":goto Top_Screen:
2460 '設定トップメニュー
2470 Config_Top:
2480 cls 3
2490 play ""
2500 play "data/voice/ConfigScreen_Top.mp3"
2510 gload "Picture/Screen1.png",0,0,0
2520 Color rgb(255,255,255)
2530 print "設 定" + chr$(13)
2540 color rgb(212,255,127)
2550 print "番号を選んでください" + chr$(13)
2560 print "*.未実装です。" + chr$(13)
2570 print "*.未実装です。" +chr$(13)
2580 print "3.前の画面に戻る" + chr$(13)
2590 print "4.プログラムを終了します" + chr$(13)
2600 color rgb(0,0,0)
2610 input "番号：",No
2620 if No=3 then play "":goto Top_Screen:
2630 if No=4 then cls 3:play "":color rgb(255,255,255):goto buf_erase:
2640 '番号1,2は未実装なので、数字は無効
2650 if No=1 or No2=2 or No > 4 then play "":goto Config_Top:
2660 if No=2 then play "":goto Config_Top:
