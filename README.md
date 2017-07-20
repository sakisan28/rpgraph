rpgraph
====
Raspberry Pi system status graph.
Generate static html with Google charts, by bash, awk and cron. 

**No warranty, at your own risk.**

デモサイトは[こちら](https://www.sakisan.com/rpgraph/)。 / Live demo [here](https://www.sakisan.com/rpgraph/).

mrtgもどき。 グラフの描画は、クライアントサイドのライブラリ Google charts を使用する。  
サーバー側は、シェルスクリプトと、awk で、ロギングと文字列操作をしているだけである。
software requirement は一切無し。 システムに入っている、bash, awk, cron (と、http サーバ)のみで動作する。
プロセスは、cron が起動するので、常駐プロセスはない。 また、静的 html を生成するだけなので、http サーバ機能も
ない。

**使い方によってはSDカードの寿命を縮めるので注意。**

Raspberry Pi の Raspbian 用に作成したが、温度測定以外は他のLinuxでも動くかもしれない。  
基本的にはHDDでの運用を想定している。 /dev/sda の状態も取りに行っているので、必要に応じて
ここは見に行かないように変える必要があるかもしれない。

![screenshot](https://cloud.githubusercontent.com/assets/28994053/26518176/be637ec6-42e5-11e7-9849-6a15c6472424.png)


使い方 / Usage
----
1. ファイル一式をどこかに展開。 例: /opt/rpgraph  
2. rpgraph.conf をシステムに合わせて編集。
3. rpgraph_buildchart.sh の中で、必要ないものをコメントアウト。
* maketemp.sh CPU温度センサー
* makesda.sh USB接続されたHDD
4. cron.d に入っているサンプルのファイルのパス、ユーザーを合わせて /etc/cron.d にコピー。

----

1. Unzip or clone source somewhere, e.g. `/opt/rpgraph`
2. Edit `rpgraph.conf` for your environment
3. Comment out some functions in `rpgraph_buildchart.sh`
* `maketemp.sh` CPU sensor of Raspberry Pi
* `makesda.sh`  USB HDD
4. Edit scripts in `cron.d`, and copy to `/etc/cron.d` 


これで、5分ごとにシステム状態のロギングと、html の作成が行われる。

www-data ユーザなどの pi 以外のユーザで動作させる場合は、vigr で video グループにwww-data ユーザを追加する必要があるかもしれない。 温度測定(vcgencmd)に必要な権限。

うまく動かない場合は、 /var/log/syslog にcronのエラーログが出ているので、それを見て対応する。

ファイルの説明
----
### rpgraph_logger.sh
cronで5分ごとに起動して、システム状態のログを記録する。ログは rpgraph_raw.txt および rpgraph_diff.txtに記録される。

Record system data on `rpgraph_raw.txt` and `rpgraph_diff.txt`, launch by `cron`.

### rpgraph_buildchart.sh
rpgraph_logger.sh の生成したログをもとに、htmlを生成する。 html の中には JavaScript で書かれた、Google chartsのコードが入っている。 内部でmake\*.htmlを呼び出していて、html生成はこれらのmake-ファイルで行われる。

Generate static html with Google charts from `rpgraph_raw.txt` and `rpgraph_diff.txt`. 
