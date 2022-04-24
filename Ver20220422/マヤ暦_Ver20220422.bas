100 'マヤ暦
110 '製作開始:2021年4月8日
120 '
130 '2022.04.22 入力方法改良開始
140 '誕生日を入れてマヤ暦の何かを求めるプログラム
150 'トップ画面表示の流れ
160 '1.ファイルを読み込む
170 '2.読み込んだファイルを配列に代入
180 '3.トップ画面表示
190 'ここからスタート
200 '1.配列定義
210 '1-1:buffer_Maya_chart1$(縦のデータ数,横のデーター数):マヤ暦チャート
220 'Varsion_Name$:ヴァージョンネーム
230 Varsion_Name$ = "バージョン:0.2.1.2022.04.22"
240 dim buffer_Maya_chart$(52*3+1,14)
250 '1-2:buffer_Sun_crist$(縦のデーター 261,横のデーター 2):太陽の紋章
260 dim buffer_Sun_crest$(261,2)
270 '1-3:buffer_Wave_Spell$(縦のデータ261 ,横のデーター  2):ウェーブスペル
280 dim buffer_Wave_spell$(261,2)
290 '1.マヤチャートデーター読み込み
300 open "config/data/Maya_Chart1.csv" for input as #1
310 for i=0 to (52*3)
320 for j=0 to 13
330 input #1,buffer_Maya_chart$(i,j)
340 next j
350 next i
360 close #1
370 '2.太陽の紋章データーの読み込み
380 open "config/data/Sun_crest.csv" for input as #2
390 for i=0 to 260
400 for j=0 to 1
410 input #2,buffer_Sun_crest$(i,j)
420 next j
430 next i
440 close #2
450 '3.ウェーブ スペル データーの読み込み
460 open "config/data/Wave_Spell.csv" for input as #3
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
650 cls 3:font 48:screen 1,1,1,1:count=0
660 gload "config/Picture/Screen1.png",0,0,0
670 gload "config/Picture/Selection.png",1,5,200
680 gload "config/Picture/Selection.png",1,5,300
690 gload "config/Picture/Selection.png",1,5,400
700 Gload "config/Picture/Selection.png",1,5,500
710 'Voice フォルダ "data/voice"
720 play ""
730 play "config/data/voice/Main_Screen.mp3"
740 sp_def 0,(5,200),32,32:sp_on 0,1
750 sp_def 1,(5,300),32,32:sp_on 1,0
760 sp_def 2,(5,400),32,32:sp_on 2,0
770 sp_def 3,(5,500),32,32:sp_on 3,0
780 sp_put 0,(5,200),0,0
790 'トップ画面
800 color rgb(255,255,255)
810 print "メイン画面"+chr$(13)
820 color  rgb(212,255,127)
830 print "番号を選んでください"+chr$(13)
840 print " :1.マヤ暦占い"+chr$(13)
850 print " :2.設定"+chr$(13)
860 print " :3.ヘルプ"+chr$(13)
870 print " :4.プログラム終了"+chr$(13)
880 color  rgb(0,0,0)
890 locate 2,12
900 print "1.マヤ暦を選択"+chr$(13)
910 key$ = input$(1)
920 'カーソル下
930 if key$=chr$(31) then
940 select case (count Mod 4)
950 case 0:
960        count=1:sp_on 0,0:sp_on 1,1 :sp_put 1,(5,300),0,0:locate 2,12:print "            ":locate 2,12:print"2.設定を選択":goto 910
970 case 1:
980        count=2:sp_on 1,0:sp_on 2,1:sp_on 3,0:sp_on 0,0:sp_put 2,(5,400),0,0:locate 2,12:print"               ":locate 2,12:print"3.ヘルプを選択":goto 910
990 case 2:
1000        count=3:sp_on 2,0:sp_on 3,1:sp_on 0,0:sp_put 3,(5,500),0,0:locate 2,12:print"               ":locate 2,12:print "4.プログラム終了を選択":goto 910
1010 case 3:
1020       count=0:sp_on 0,1:sp_on 3,0:sp_on 1,0:sp_on 2,0:sp_put 0,(5,200),0,0:locate 2,12:print"                ":locate 2,12:print "1.マヤ暦占いを選択":goto 910
1030 end select
1040 else
1050 'カーソル上
1060 if key$ = chr$(30) then
1070 select case (count Mod 4)
1080 case 0:
1090        count = 3:sp_on 0,0:sp_on 1,0:sp_on 2,0:sp_on 3,1:sp_put 3,(5,500),0,0:locate 2,12:print "                 ":locate 2,12:print"4.プログラム終了を選択":goto 910
1100 case 1:
1110        count = 0:sp_on 0,1:SP_on 1,0:sp_on 2,0:sp_on 3,0:sp_put 0,(5,200),0,0:locate 2,12:print"                         ":locate 2,12:print "1.マヤ暦を選択":goto 910
1120 case 2:
1130        count = 1:sp_on 0,0:sp_on 1,1:sp_on 2,0:sp_on 3,0:sp_put 1,(5,300),0,0:locate 2,12:print "                     ":locate 2,12:print "2.設定を選択":goto 910
1140 case 3:
1150       count = 2:sp_on 0,0:sp_on 1,0:sp_on 2,1:sp_on 3,0:sp_put 2,(5,400),0,0:locate 2,12:print "                      ":locate 2,12:print"3.ヘルプを選択":goto 910
1160 end select
1170 '誕生日入力に飛ぶ
1180 else
1190 if key$ = chr$(13) then
1200 if count= 0 then play "":goto Menu1_Input_Year:
1210 if count = 1 then play "":goto Config_Top:
1220 if count = 2 then play "":goto Help_Screen_Top:
1230 '選択肢４ プログラム終了 メモリーを消去して終了する
1240 if count = 3 then cls 3:cls 4:play "":color rgb(255,255,255):goto buf_erase:
1250 else
1260 goto 910
1270 endif
1280 endif
1290 endif
1300 'if key > 4 then talk "番号をもう一度入れてください":goto Top_Screen:
1310 'マヤ暦 占い 誕生日入力 西暦入力
1320 '年入力
1330 Menu1_Input_Year:
1340 cls 3
1350 '非表示 ここから
1360 gload "config/Picture/Screen1.png",1,0,0
1370 '非表示　ここまで
1380 '表示　ここから
1390 gload "config/Picture/Input_born_year.png",0,0,0
1400 '表示　ここまで
1410 'Voice:data/voice/born_year.mp3"
1420 play ""
1430 play "config/data/voice/born_year.mp3"
1440 color rgb(255,255,255)
1450 print"生まれた年を入れてください"+chr$(13)
1460 color rgb(255,0,0)
1470 Input"生れた年(1910〜)：",born_year
1480 if ((born_year > 2065) or (born_year<1910)) then goto Menu1_Input_Year:
1490 '月入力
1500 Menu1_Input_Month:
1510 cls
1520 'Voice:/data/voice/born_month.mp3"
1530 play ""
1540 play "config/data/voice/born_month.mp3"
1550 color rgb(255,0,0)
1560 print"生れた月を入れてください"+chr$(13)
1570 color rgb(0,0,0)
1580 Input"生れた月:",born_month
1590 if born_month > 12 then goto Menu1_Input_Month:
1600 '日付入力
1610 Menu1_Input_Day:
1620 cls
1630 'Voice:data/voice/born_day.mp3
1640 play ""
1650 play"config/data/voice/born_day.mp3"
1660 color rgb(255,0,0)
1670 print"生れた日を入れてください"+chr$(13)
1680 color rgb(0,0,0)
1690 Input"生れた日:",born_day
1700 if born_day > 31 then play "":goto Menu1_Input_Day:
1710 play ""
1720 '計算領域
1730 Maya_Value1 = val(buffer_Maya_chart$(born_year - 1909,born_month))
1740 Maya_Value = Maya_Value1 + born_day
1750 'うるう年変数  チェック:Maya_Uruu
1760 Maya_Uruu = val(buffer_Maya_chart$(born_year - 1909,13))
1770 '閏年チェック
1780 '閏年ではないとき Maya_Uruu = 0
1790 if Maya_Uruu = 0 then
1800 if Maya_Value < 260 then
1810 if (born_month = 3 and born_day >= 1 and born_day =< 31) then
1820 'sun crest:太陽の紋章
1830 sun_crest = Maya_Value + 1
1840 else
1850 sun_crest = Maya_Value
1860 endif
1870 else
1880 if Maya_Value > 260 then
1890 sun_crest = Maya_Value - 260
1900 endif
1910 endif
1920 else
1930 '閏年のとき  Maya_Uruu=1
1940 if Maya_Uruu = 1 then
1950 if Maya_Value < 260 then
1960 sun_crest=Maya_Value
1970 if (born_month = 3 and born_day >= 1 and born_day =< 31) then
1980 sun_crest = Maya_Value + 1 + 1
1990 else
2000 sun_crest = Maya_Value + 1
2010 endif
2020 else
2030 if Maya_Value > 260 then
2040 sun_crest = (Maya_Value - 260) + 1
2050 endif
2060 endif
2070 endif
2080 endif
2090 '太陽の紋章:Sun_crest$
2100 Sun_crest$ = buffer_Sun_crest$(sun_crest,1)
2110 'ウエイブスペル:wave_spell$=
2120 Wave_spell$ = buffer_Wave_spell$(sun_crest,1)
2130 cls 3
2140 gload "config/Picture/Result_Screen.png",0,0,0
2150 'voice:data/voice/Result_Message.mp3"
2160 play ""
2170 play "config/data/voice/Result_Message.mp3"
2180 COLOR rgb(255,255,255)
2190 print "マヤ暦 診断結果";chr$(13)
2200 color rgb(212,255,127)
2210 print "あなたのマヤ暦は";chr$(13)
2220 print "生れた年:";born_year;chr$(13)
2230 print "生れた月:";born_month;chr$(13)
2240 print "生れた日:";born_day;chr$(13)
2250 print "太陽の紋章:";Sun_crest$;chr$(13)
2260 print "ウェーブスペル:";Wave_spell$;chr$(13)
2270 color rgb(0,0,0)
2280 print "エンターキー:トップ,S:保存する"
2290 a$ = input$(1)
2300 if a$ = chr$(13) then play "":goto Top_Screen
2310 if a$="S" or a$="s" then goto Save_data:
2320 Help_Screen_Top:
2330 cls 3
2340 gload"config/Picture/Screen1.png",0,0,0
2350 'Voice:Help画面 "data/voice/help_Screen.mp3"
2360 play"config/data/voice/help_Screen.mp3"
2370 sp_on 0,1:sp_on 1,0:sp_on 2,0:sp_on 3,0:sp_put 0,(5,200),0,0:count=0
2380 color rgb(255,255,255)
2390 print "ヘルプ" + chr$(13)
2400 color rgb(212,255,157)
2410 PRINT "番号を選んでください" + chr$(13)
2420 print " :1.バージョン" + chr$(13)
2430 print " :2.参考文献" + chr$(13)
2440 print " :3.前の画面に戻る" + chr$(13)
2450 print " :4.プログラムの終了" + chr$(13)
2460 color rgb(0,0,0)
2470 locate 2,12:print "                          ":locate 2,12:print "1.バージョンを選択"
2480 key$ = input$(1)
2490 'カーソル下
2500 if key$=chr$(31) then
2510 select case (count Mod 4)
2520 case  0:
2530         count =1:sp_on 0,0:sp_on 1,1:sp_on 2,0:sp_on 3,0:sp_put 1,(5,300),0,0:locate 2,12:print "                                 ":locate 2,12:print "2.参考文献を選択":goto 2480
2540 case  1:
2550         count =2:sp_on 0,0:sp_on 1,0:sp_on 2,1:sp_on 3,0:sp_put 2,(5,400),0,0:locate 2,12:print "                                       ":locate 2,12:print "3.前の画面に戻るを選択":goto 2480
2560 case  2:
2570         count =3:sp_on 0,0:sp_on 1,0:sp_on 2,0:sp_on 3,1:sp_put 3,(5,500),0,0:locate 2,12:print"                         ":locate 2,12:print"4.プログラムの終了を選択":goto 2480
2580 case  3:
2590         count =0:sp_on 0,1:sp_on 1,0:sp_on 2,0:sp_on 3,0:sp_put 0,(5,200),0,0:locate 2,12:PRINT"                     ":locate 2,12:print"1.バージョンを選択":goto 2480
2600 end select
2610 else
2620 'エンターキーを押したとき
2630 if key$=chr$(13) then
2640 if count=0 then play"":cls 4:goto Version:
2650 if count=1 then play"":cls 4:goto Reference_Book:
2660 if count=2 then play"":cls 4:goto Top_Screen:
2670 if count=3 then
2680 play"":color rgb(255,255,255):cls 3:cls 4:goto buf_erase:
2690 else
2700 play"":cls 4:goto Help_Screen_Top:
2710 endif
2720 else
2730 goto 2480
2740 endif
2750 endif
2760 'バージョン情報
2770 Version:
2780 cls 3
2790 'Voice:/data/voice/Version_Screen.mp3"
2800 play "config/data/voice/version_screen.mp3"
2810 gload"config/Picture/Screen2.png",0,0,0
2820 color rgb(255,255,255)
2830 print "バージョン" + chr$(13)
2840 color rgb(125,255,212)
2850 print ""+chr$(13)
2860 print "Title:マヤ暦" + chr$(13)
2870 print Varsion_Name$ + chr$(13)
2880 print "（C)copy rights licksjp" + chr$(13)
2890 print "All rights reserved" + chr$(13)
2900 print ""+chr$(13)+chr$(13)
2910 color rgb(0,0,0)
2920 print "エンターキーを押してください" + chr$(13)
2930 key$ = input$(1)
2940 if key$ = chr$(13) then play "":goto Top_Screen:
2950 '参考文献
2960 Reference_Book:
2970 cls 3
2980 gload "config/Picture/Screen2.png",0,0,0
2990 'voice:/data/voice/Referencebook.mp3
3000 play ""
3010 play "config/data/voice/Referencebook.mp3"
3020 color rgb(255,255,255)
3030 print"参考文献"+chr$(13)
3040 color rgb(212,255,127)
3050 print"書名:マヤ暦占星術でなりたい自分 を叶える"+chr$(13)
3060 print"出版社:カシオペア出版" + chr$(13)
3070 print"発売：サンクチュアリ出版" + chr$(13)
3080 print"著者：MASAYUKi" + chr$(13)
3090 print"ISBN:978-4-86113-858-4" + chr$(13)
3100 print"定価:1400+税" + chr$(13)+chr$(13)
3110 color rgb(0,0,0)
3120 print"エンターキーを押してください"
3130 key$=Input$(1)
3140 if key$=chr$(13) then play"":goto Top_Screen:
3150 '設定トップメニュー
3160 Config_Top:
3170 cls 3
3180 play ""
3190 play "config/data/voice/ConfigScreen_Top.mp3"
3200 gload "config/Picture/Screen1.png",0,0,0
3210 Color rgb(255,255,255)
3220 print "設 定" + chr$(13)
3230 color rgb(212,255,127)
3240 print "番号を選んでください" + chr$(13)
3250 print "*.未実装です。" + chr$(13)
3260 print "*.未実装です。" +chr$(13)
3270 print "3.前の画面に戻る" + chr$(13)
3280 print "4.プログラムを終了します" + chr$(13)
3290 color rgb(0,0,0)
3300 input "番号：",No
3310 if No=3 then play "":goto Top_Screen:
3320 if No=4 then cls 3:play "":color rgb(255,255,255):goto buf_erase:
3330 '番号1,2は未実装なので、数字は無効
3340 if No=1 or No2=2 or No > 4 then play "":goto Config_Top:
3350 if No=2 then play "":goto Config_Top:
3360 Save_data:
3370 buf_name$=ui_input$("名前","")
3380 if dir$("config/data/Parsonal.csv")="" then
3390 open "config/data/Parsonal.csv" for output as #1
3400 print #1,buf_name$ + ",生まれた年:" + str$(born_year) + ",生まれた月:" + str$(born_month) + ",生まれた日:" + str$(born_day) + ",太陽の紋章:" + Sun_crest$ + ",ウェーブスペース:" + Wave_spell$ + chr$(13)
3410 close #1
3420 else
3430 open "config/data/Parsonal.csv" for append as #1
3440 print #1,buf_name$ + ",生まれた年:" + str$(born_year) + ",生まれた月:" + str$(born_month) + ",生まれた日:" + str$(born_day) + ",太陽の紋章:" + Sun_crest$ + ",ウェーブスペース:" + Wave_spell$ + chr$(13)
3450 close #1
3460 endif
3470 ui_msg "保存しました":goto Top_Screen:
