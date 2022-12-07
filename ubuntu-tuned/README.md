# Ubuntu Tuned 映像檔

參照 wujidadi/ap，但未安裝 Apache、Nginx、PHP、Node.js 及相關軟體，僅安裝基本套件和 Zsh（含 Oh My Zsh），是相對乾淨的 Ubuntu 環境。

## 版本說明

### 2.1, 2.1-arm（2022-12-07）
* 作業系統使用 **Ubuntu 22.04 LTS**
* 主要軟體版本：
  * **Vim 9.0.1025**
  * **GNU Nano 7.0**
* 取消 Dockerfile 中的註釋，將其併入輸出訊息

### 2.0, 2.0-arm（2022-10-29）

* 作業系統使用 **Ubuntu 22.04 LTS**
  * 因由 **20.04 LTS** 升級上來，故映像檔大版本跳號至 **2**
* 主要軟體版本：
  * **Vim 9.0.749**
  * **GNU Nano 6.4**

### 1.2（2022-03-22）

* 加裝 **gpg-agent**

### 1.1, 1.1-arm（2022-02-19）

* 以 **Ubuntu 20.04 LTS** 為基底
* 環境建構參照 **wujidadi/ap:2.3**
* 開始同步建立 ARM64 版本
* 比照 **wujidadi/ap 1.4** 及 **2.2 版**起的變動，更換 `root` 與預設使用者 `user` 的預設密碼

### 1.0（2021-08-07；2022-01-20 有小幅更動）

* 以 **Ubuntu 20.04 LTS** 為基底
* 環境建構參照 **wujidadi/ap:2.1**
