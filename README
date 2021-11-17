# まだ作りかけで、下記通り実行しても上手く動きません。

# これはなに？

inajobの家でファイルサーバ兼、デジタルサイネージを司っているRaspberry Piのレシピです。

- LAN内での動作を想定しており、Sambaはパスワードなしでログインできます
- 2つのHDDをUSBで接続しており、これらをアクティブディスクとスタンバイディスクとして扱い、定時バックアップを行っています。どちらかのディスクに物理故障が発生してもデータは守られます。
- スマートフォンなどで撮影した写真をSamba経由で転送し保存しておくことが出来ます
- Sambaで転送されたデータは毎朝5時にセカンダリディスクにrsyncされます。
- Webサイネージを搭載しており、TimeTreeの1週間分の予定を表示できます。
- WebサイネージはHDDに存在する写真をランダムで表示します。この表示は15分毎に切り替わります。
- google-home-notifierが起動しており、これを経由して同一LAN内のGoogle Homeに任意の文言をしゃべらせたり、mp3を再生挿せることが出来ます
- 上記仕組みを使い「こもりうた」を定時に再生します。

# 構成

## mirror

2台のHDDをUSBで接続している事を想定しています。
HDDのUUIDを使いこれらを識別し `/media/mystorage`, `/media/mystorage2` にマウントします。

`/media/mystorage` がアクティブで、`/media/mystorage2` がスタンバイです。

Sambaサーバはアクティブなディスクを公開しています。

mirrorはこの2つのディスクの内容を定期的に同期する仕組みです。
単に朝5時にrsyncを実行しているだけです。

結果はSlackに通知します。

## slack

mirrorがSlack通知するためのスクリプトです。

## google-home-notifier

https://github.com/noelportugal/google-home-notifier を元に日本語用に変更したものです。

## google-home

google-home-notifierを起動するためのスクリプト、定期的に子守歌を鳴らすためのスクリプトです。

## web-signage

Webブラウザを使い TimeTreeの1週間分の予定、ディスク内の写真のランダム表示というサイネージ機能のためのスクリプトとWebページです。

# インストール方法

## 事前準備

- SDカードに Raspberry Pi OS を書き込む
  - SSHを有効化する
    - bootドライブに`ssh`というファイルを作っておく
  - 必要ならWiFiのSSID/パスワードを設定する
    - bootドライブに`wpa_supplicant.conf`を作っておく
- Raspberry Piの配線を行う
  - HDMIケーブルでディスプレイと接続
  - （必要に応じて）イーサネットケーブルでネットワークに接続
  - USB経由で同じ容量のHDDを接続（USB3.0の方が良いと思う）
  - （必要に応じて） キーボードを接続

## おうちRaspberryPi構築用リポジトリの取得

- 何らかの方法でIPアドレスを取得し、SSHでログインする
- `apt-get update` を実行
- `apt-get install git`を実行(TODO: gitはデフォルトで入っている？）
- `git clone https://github.com/inajob/ouchi-raspberry-pi.git`
- `cd ouchi-raspberry-pi`

## 環境に合わせたデータの用意1

- `mkdir secrets` # .gitkeepで用意しよう
- `./secrets`以下に下記ファイル名・内容のファイルを配置する
  - `slack-token` バックアップの成功・失敗を通知するためのSlack API Token
  - `timetree-token` TimeTree APIにアクセスするためのToken
  - `timetree-id` TimeTreeで表示するカレンダーを示すID
  - `photo-path` サイネージにランダム表示する写真が格納されているルートディレクトリまでのパスを `/media/mystorage`からの相対パスで記載したもの(`/media/mystorage`以下の画像すべてであれば `./`と記載したファイルでOK)

## 環境に合わせたデータの用意2

- `cd ~/ouchi-raspberry-pi/provision/files`
  - `fstab-backup-info` fstapに2つのUSBディスクをマウントするためにfstabを追記するための内容

https://qiita.com/wnoguchi/items/b31e268b6b7236cdf8db などを参考にUUIDを取得します。

(例)


```
UUID=取得したUUID1 /media/mystorage ntfs-3g async,auto,dev,exec,nofail,gid=65534,rw,uid=65534,umask=000    0    0
UUID=取得したUUID2 /media/mystorage2 ntfs-3g async,auto,dev,exec,nofail,gid=65534,rw,uid=65534,umask=000    0    0
```

ここではディスクはNFTSでフォーマットされていることを想定しています。
(我が家はWindowsPCを使っており、いざという時に簡単にデータをコピーできるようにNTFSとしています。）

## 環境構築スクリプトの実行

- `./setup.sh`を実行（TODO: setup.shを用意する)

## 現状の制限

- セットアップスクリプトはAnsibleで記述していますが、適切にhandlerを設定していないので、何か構成を変更して、Ansible実行した際ははRaspberryPiを再起動して設定を反映して下さい。
- まだ作りかけで、上記の通り実行しても上手く動かない可能性があります。
- PR、Issueは一応受け付けていますが、汎用的にするつもりはあまりないので、カスタマイズしたい場合は好きなようにforkしてください。
