#dockerによる開発環境整備の流れ

#任意のフォルダにこのfruit_salesフォルダを格納
#dockerfileのあるファイル上で

#docker build -t fruit_sales:1.0 ./

#と入力し、イメージを作成（上記の文言はこの後説明する自動化したプログラムを壊すので変えないこと）

#その後
#bash setupfile

#と入力するとコンテナ（作業できるLINUX環境）が作成されてそこのbashに入った状態になります。
#bashに入ったら、下記コマンドを入力し、指示どおりに入力していってください。

#bash after_docker_run.exe

#ちなみにpostgresのパスワードを求められるのでそこは任意のパスワードでOKです。

#二回目以降の入り方
#exitで抜けると自動的にコンテナが停止します。
#そのため、次回起動時は

#docker ps -a
#にてコンテナが動いているか確認（upなら起動中、exitedなら停止中）
#動いていない場合
#docker start fruit_sales
#で起動させる。

#コンテナが起動している状態で
#docker exec -it fruit_sales /bin/bash
#と入力すると中に入れます。

#注意！　一度コンテナを停止させるとpostgresも停止します。
#そのため 一度コンテナが停止したら、

#service postgresql start

#と入力し、起動させる必要があります。ここはいつか自動化したい。
#先程のコマンドは面倒なのでエイリアスを入れておきました。

#psqlup で起動します。


#---------------------------------------------------------------------------------
#vimrc,bashrc,bash_profileは九津見が使っているものを指定しています。
#変えたい場合は /root/　以下に配置してあるので自由に変えて下さい。
