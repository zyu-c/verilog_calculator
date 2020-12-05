# verilog_calculator
Verilogで実装した電卓
## 参考書籍
浅田邦博 (2003) 「ディジタル集積回路の設計と試作」培風館

## シミュレーション
```bash
iverilog -o sim bintobcd.v ledout.v binled.v syncro.v calc.v calctop.v testbench.v
vvp sim > log.txt
gtkwave wave.vcd
```

## MU200-ECへの書き込み
```bash
#コンパイル
quartus_sh --flow compie calc
```
USB-Blasterを接続し，Quartus II Programmerにて書き込み．

## 入力について
|     |     |     |     |     |
| :-: | :-: | :-: | :-: | --- |
| 7   | 8   | 9   | C   |     |
| 4   | 5   | 6   | -   |     |
| 1   | 2   | 3   | +   |     |
|     | 0   |     | =   |     |

