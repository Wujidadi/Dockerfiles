# Nginx + PHP 映像檔

基於 Ubuntu，安裝自己調校過的 Nginx、PHP 及 Node.js 等相關軟體，建構而成的複合映像檔。

須搭配 Docker Compose，在 command 項設置 `bash -c "php-fpm${PHP_Version} && nginx -g 'daemon off;'"` 方能在容器建立時同時帶起 PHP-FPM 及 Nginx。

## 版本說明

### latest, 2.0, 2.0-arm（2022-10-29）

* 作業系統使用 **Ubuntu 22.04 LTS**
  * 因由 **20.04 LTS** 升級上來，故映像檔大版本跳號至 **2**
* 主要軟體版本：
  * **Vim 9.0.749**
  * **GNU Nano 6.4**
  * **Nginx 1.23.2**
  * **PHP 8.1.12**
  * **Composer 2.4.4**
  * **Node.js 18.12.0**
    * **npm 8.19.2**

### 1.2（2022-03-22）

* 支援 MSSQL：加裝 **gpg-agent**、**Microsoft ODBC 18** 與 **Microsoft SQL Server Driver for PHP**（參照 **wujidadi/ap 1.6** 及 **2.4 版**）
* 此版本所有的改動均和 MSSQL 有關，而目前 MSSQL Driver for PHP 尚不支援 Apple M1 以外的 ARM64 架構，故不建立 ARM 版本

### 1.1, 1.1-arm（2022-02-19）

* 由於 Ubuntu 21.04 上 PHP 8.1 的套件不完整，回退以 **Ubuntu 20.04 LTS** 為基底
* 安裝 **Nginx 1.21.4** 和 **PHP 8.1.2**
* 開始同步建立 ARM64 版本
* 比照 **wujidadi/ap 1.4** 及 **2.2 版**起的變動，更換 `root` 與預設使用者 `dockeruser` 的預設密碼

### 1.0（2021-08-14）

* 以 **Ubuntu 21.04** 為基底
* 安裝 **Nginx 1.21.1** 和 **PHP 8.0.9**
