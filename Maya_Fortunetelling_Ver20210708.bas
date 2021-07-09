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
220 Varsion_Name$ = "バージョン:0.0.8.2021.07.08"
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
670 play "data/voice/Main_Screen.mp3"
680 'トップ画面
690 color rgb(255,255,255)
700 print "メイン画面"+chr$(13)
710 color  rgb(212,255,127)
720 print "番号を選んでください"+chr$(13)
730 print "1.マヤ暦占い"+chr$(13)
740 print "2.設定"+chr$(13)
750 print "3.ヘルプ"+chr$(13)
760 print "4.プログラム終了"+chr$(13)
770 color  rgb(0,0,0)
780 Input"番号:",key
790 '誕生日入力に飛ぶ
800 if key = 1 then  goto Menu1_Input_Year:
810 if key = 2 then goto Config_Top:
820 if key = 3 then goto Help_Screen_Top:
830 '選択肢４ プログラム終了 メモリーを消去して終了する
840 if key = 4 then cls 3:color rgb(255,255,255):goto buf_erase:
850 if key > 4 then talk "番号をもう一度入れてください":goto Top_Screen:
860 'マヤ暦 占い 誕生日入力 西暦入力
870 '年入力
880 Menu1_Input_Year:
890 cls 3
900 '非表示 ここから
910 gload "Picture/Screen1.png",1,0,0
920 '非表示　ここまで
930 '表示　ここから
940 gload "Picture/Input_born_year.png",0,0,0
950 '表示　ここまで
960 'Voice:data/voice/born_year.mp3"
970 play "data/voice/born_year.mp3"
980 color rgb(255,255,255)
990 print"生まれた年を入れてください"+chr$(13)
1000 color rgb(0,0,0)
1010 Input"生れた年(1910〜)：",born_year
1020 if ((born_year > 2065) or (born_year<1910)) then goto Menu1_Input_Year:
1030 '月入力
1040 Menu1_Input_Month:
1050 cls
1060 'Voice:/data/voice/born_month.mp3"
1070 play "data/voice/born_month.mp3"
1080 color rgb(255,255,255)
1090 print"生れた月を入れてください"+chr$(13)
1100 color rgb(0,0,0)
1110 Input"生れた月:",born_month
1120 if born_month > 12 then goto Menu1_Input_Month:
1130 '日付入力
1140 Menu1_Input_Day:
1150 cls
1160 'Voice:data/voice/born_day.mp3
1170 play"data/voice/born_day.mp3"
1180 color rgb(255,255,255)
1190 print"生れた日を入れてください"+chr$(13)
1200 color rgb(0,0,0)
1210 Input"生れた日:",born_day
1220 if born_day > 31 then goto Menu1_Input_Day:
1230 '計算領域
1240 Maya_Value1 = val(buffer_Maya_chart$(born_year - 1909,born_month))
1250 Maya_Value = Maya_Value1 + born_day
1260 'うるう年変数  チェック:Maya_Uruu
1270 Maya_Uruu = val(buffer_Maya_chart$(born_year - 1909,13))
1280 '閏年チェック
1290 '閏年ではないとき Maya_Uruu = 0
1300 if Maya_Uruu = 0 then
1310 if Maya_Value < 260 then
1320 if (born_month = 3 and born_day >= 1 and born_day =< 31) then
1330 'sun crest:太陽の紋章
1340 sun_crest = Maya_Value + 1
1350 else
1360 sun_crest = Maya_Value
1370 endif
1380 else
1390 if Maya_Value > 260 then
1400 sun_crest = Maya_Value - 260
1410 endif
1420 endif
1430 else
1440 '閏年のとき  Maya_Uruu=1
1450 if Maya_Uruu = 1 then
1460 if Maya_Value < 260 then
1470 sun_crest=Maya_Value
1480 if (born_month = 3 and born_day >= 1 and born_day =< 31) then
1490 sun_crest = Maya_Value + 1 + 1
1500 else
1510 sun_crest = Maya_Value + 1
1520 endif
1530 else
1540 if Maya_Value > 260 then
1550 sun_crest = (Maya_Value - 260) + 1
1560 endif
1570 endif
1580 endif
1590 endif
1600 '太陽の紋章:Sun_crest$
1610 Sun_crest$ = buffer_Sun_crest$(sun_crest,1)
1620 'ウエイブスペル:wave_spell$=
1630 Wave_spell$ = buffer_Wave_spell$(sun_crest,1)
1640 cls 3
1650 gload "Picture/Result_Screen.png",0,0,0
1660 'voice:data/voice/Result_Message.mp3"
1670 play "data/voice/Result_Message.mp3"
1680 COLOR rgb(255,255,255)
1690 print "マヤ暦 診断結果";chr$(13)
1700 color rgb(212,255,127)
1710 print "あなたのマヤ暦は";chr$(13)
1720 print "生れた年:";born_year;chr$(13)
1730 print "生れた月:";born_month;chr$(13)
1740 print "生れた日:";born_day;chr$(13)
1750 print "太陽の紋章:";Sun_crest$;chr$(13)
1760 print "ウェーブスペル:";Wave_spell$;chr$(13)
1770 color rgb(0,0,0)
1780 print "エンターキーを押してください"
1790 a$ = input$(1)
1800 if a$ = chr$(13) then goto Top_Screen:
1810 Help_Screen_Top:
1820 cls 3
1830 gload"Picture/Screen1.png",0,0,0
1840 'Voice:Help画面 "data/voice/help_Screen.mp3"
1850 play"data/voice/help_Screen.mp3"
1860 color rgb(255,255,255)
1870 print "ヘルプ" + chr$(13)
1880 color rgb(212,255,157)
1890 PRINT "番号を選んでください" + chr$(13)
1900 print "1.バージョン" + chr$(13)
1910 print "2.参考文献" + chr$(13)
1920 print "3.前の画面に戻る" + chr$(13)
1930 print "4.プログラムの終了" + chr$(13)
1940 color rgb(0,0,0)
1950 Input "番号:",No
1960 if No=1 then goto Version:
1970 if No=2 then goto Reference_Book:
1980 if No=3 then goto Top_Screen:
1990 if No=4 then color rgb(255,255,255):cls 3:goto buf_erase:
2000 if (No > 4 or No = 0) then goto Help_Screen_Top:
2010 'バージョン情報
2020 Version:
2030 cls 3
2040 'Voice:/data/voice/Version_Screen.mp3"
2050 play "data/voice/version_screen.mp3"
2060 gload"Picture/Screen2.png",0,0,0
2070 color rgb(255,255,255)
2080 print "バージョン" + chr$(13)
2090 color rgb(125,255,212)
2100 print ""+chr$(13)
2110 print "Title:マヤ暦" + chr$(13)
2120 print Varsion_Name$ + chr$(13)
2130 print "（C)copy rights licksjp" + chr$(13)
2140 print "All rights reserved" + chr$(13)
2150 print ""+chr$(13)+chr$(13)
2160 color rgb(0,0,0)
2170 print "エンターキーを押してください" + chr$(13)
2180 key$ = input$(1)
2190 if key$ = chr$(13) then goto Top_Screen:
2200 '参考文献
2210 Reference_Book:
2220 cls 3
2230 gload "Picture/Screen2.png",0,0,0
2240 'voice:/data/voice/Referencebook.mp3
2250 play "data/voice/Referencebook.mp3"
2260 color rgb(255,255,255)
2270 print"参考文献"+chr$(13)
2280 color rgb(212,255,127)
2290 print"書名:マヤ暦占星術でなりたい自分 を叶える"+chr$(13)
2300 print"出版社:カシオペア出版" + chr$(13)
2310 print"発売：サンクチュアリ出版" + chr$(13)
2320 print"著者：MASAYUKi" + chr$(13)
2330 print"ISBN:978-4-86113-858-4" + chr$(13)
2340 print"定価:1400+税" + chr$(13)+chr$(13)
2350 color rgb(0,0,0)
2360 print"エンターキーを押してください"
2370 key$=Input$(1)
2380 if key$=chr$(13) then goto Top_Screen:
2390 '設定トップメニュー
2400 Config_Top:
2410 cls 3
2420 gload "Picture/Screen1.png",0,0,0
2430 Color rgb(255,255,255)
2440 print "設 定" + chr$(13)
2450 color rgb(212,255,127)
2460 print "番号を選んでください" + chr$(13)
2470 print "*.未実装です。" + chr$(13)
2480 print "*.未実装です。" +chr$(13)
2490 print "3.前の画面に戻る" + chr$(13)
2500 print "4.プログラムを終了します" + chr$(13)
2510 color rgb(0,0,0)
2520 input "番号：",No
2530 if No=3 then goto Top_Screen:
2540 if No=4 then cls 3:color rgb(255,255,255):goto buf_erase:
2550 '番号1,2は未実装なので、数字は無効
2560 if No=1 or No2=2 or No > 4 then goto Config_Top:
2570 if No=2 then goto Config_Top:
