Raspberry Pi system status graph.
====

mrtgもどき。 グラフの描画は、クライアントサイドのライブラリ Google charts を使用する。  
サーバー側は、ロギングと文字列操作をしているだけである。

**使い方によってはSDカードの寿命を縮めるので注意。**

Raspberry Pi の Raspbian 用に作成したが、温度測定以外は他のLinuxでも動くかもしれない。  
基本的にはHDDでの運用を想定している。 /dev/sda の状態も取りに行っているので、必要に応じて
ここは見に行かないように変える必要があるかもしれない。

使い方
----
1. ファイル一式をどこかに展開。 例: /opt/rpgraph  
2. rpgraph.conf をシステムに合わせて編集。
3. cron.d に入っているサンプルのファイルのパス、ユーザーを合わせて /etc/cron.d にコピー。

これで、5分ごとにシステム状態のロギングと、html の作成が行われる。

www-data ユーザなどの pi 以外のユーザで動作させる場合は、vigr で video グループにwww-data ユーザを追加する必要があるかもしれない。 温度測定(vcgencmd)に必要な権限。

うまく動かない場合は、 /var/log/syslog にcronのエラーログが出ているので、それを見て対応する。

ファイルの説明
----
### rpgraph_logger.sh
cronで5分ごとに起動して、システム状態のログを記録する。ログは rpgraph_raw.txt および rpgraph_diff.txtに記録される。

### rpgraph_buildchart.sh
rpgraph_logger.sh の生成したログをもとに、htmlを生成する。 html の中には JavaScript で書かれた、Google chartsのコードが入っている。 内部でmake\*.htmlを呼び出していて、html生成はこれらのmake-ファイルで行われる。




todo
====
temp
----
ラズパイかどうかのフラグを作る

disk
----
sda は **on/off** できるように。  
