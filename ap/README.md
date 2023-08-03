# ap (Apache + PHP)

Base on Ubuntu, with Apache, PHP, Node.js and other softwares tuned and installed.

> To run syslog in the container, `bash -c "service rsyslog start ; /usr/sbin/apache2ctl -D FOREGROUND"` should be set in the `command` option in `docker-compose.yaml`.

## Release Notes (since version 0.17)

### 3.8 (2023-08-03)

* `docker buildx` commands: (`$D` is a custom alias of the log directory)
  ```sh
  docker buildx build --no-cache --progress=plain --push --platform linux/amd64,linux/arm64 --rm -t wujidadi/ap:3.8 -t wujidadi/ap:latest ap/3.8 2>&1 | tee $D/docker-build-ap.log
  ```
* OS: **Ubuntu 22.04 LTS**
* Main software versions:
  * **Vim 9.0.1677**
  * **GNU Nano 7.2**
  * **Apache 2.4.57**
  * **PHP 8.2.7**
  * **Composer 2.5.8**
  * **Swoole 5.0.3**
  * **Microsoft ODBC Driver for SQL Server 18.3.1.1**
  * **Node.js 20.5.0**
    * **npm 9.8.1**
* PHP **xdebug** and **http** (with **raphf**) extensions are specifically installed.

### 3.7 (2023-07-01)

* OS: **Ubuntu 22.04 LTS**
* Main software versions:
  * **Vim 9.0.1671**
  * **GNU Nano 7.2**
  * **Apache 2.4.57**
  * **PHP 8.2.7**
  * **Composer 2.5.8**
  * **Swoole 5.0.3**
  * **Microsoft ODBC Driver for SQL Server 18.2.2.1**
  * **Node.js 20.3.1**
    * **npm 9.7.2**

### 3.6 (2023-06-01)

* OS: **Ubuntu 22.04 LTS**
* Main software versions:
  * **Vim 9.0.1595**
  * **GNU Nano 7.2**
  * **Apache 2.4.57**
  * **PHP 8.2.6**
  * **Composer 2.5.7**
  * **Swoole 5.0.3**
  * **Microsoft ODBC Driver for SQL Server 18.2.1.1**
  * **Node.js 20.2.0**
    * **npm 9.6.7**

### 3.5.2 (2023-05-11)

* **MySQL Client** and **PostgreSQL Client** is installed.
* OS: **Ubuntu 22.04 LTS**
* Main software versions:
  * **Vim 9.0.1539**
  * **GNU Nano 7.2**
  * **Apache 2.4.57**
  * **PHP 8.2.5**
  * **Composer 2.5.5**
  * **Swoole 5.0.2**
  * **Microsoft ODBC Driver for SQL Server 18.2.1.1**
  * **Node.js 20.1.0**
    * **npm 9.6.6**

### 3.5.1 (2023-05-10)

* Create `.zsh_history` files for root and default user (`user`) while image building so that the history of Zsh can be mounted to the volume.
* OS: **Ubuntu 22.04 LTS**
* Main software versions:
  * **Vim 9.0.1536**
  * **GNU Nano 7.2**
  * **Apache 2.4.57**
  * **PHP 8.2.5**
  * **Composer 2.5.5**
  * **Swoole 5.0.2**
  * **Microsoft ODBC Driver for SQL Server 18.2.1.1**
  * **Node.js 20.1.0**
    * **npm 9.6.6**

### 3.5 (2023-05-01)

* OS: **Ubuntu 22.04 LTS**
* Main software versions:
  * **Vim 9.0.1503**
  * **GNU Nano 7.2**
  * **Apache 2.4.57**
  * **PHP 8.2.5**
  * **Composer 2.5.5**
  * **Swoole 5.0.2**
  * **Microsoft ODBC Driver for SQL Server 18.2.1.1**
  * **Node.js 20.0.0**
    * **npm 9.6.5**

### 3.4 (2023-04-01)

* OS: **Ubuntu 22.04 LTS**
* Main software versions:
  * **Vim 9.0.1433**
  * **GNU Nano 7.2**
  * **Apache 2.4.56**
  * **PHP 8.2.4**
  * **Composer 2.5.5**
  * **Swoole 5.0.2**
  * **Microsoft ODBC Driver for SQL Server 18.2.1.1**
  * **Node.js 19.8.1**
    * **npm 9.5.1**

### 3.3 (2023-02-16)

* `docker buildx` is used to build multiarch images since this version.
* OS: **Ubuntu 22.04 LTS**
* Main software versions:
  * **Vim 9.0.1313**
  * **GNU Nano 7.2**
  * **Apache 2.4.55**
  * **PHP 8.2.3**
  * **Composer 2.5.4**
  * **Node.js 19.6.0**
    * **npm 9.4.0**
* PHP 7 is no longer maintained (i.e. no version 1.9).

### 3.2, 3.2-arm (2022-12-30)

* OS: **Ubuntu 22.04 LTS**
* Main software versions:
  * **Vim 9.0.1108**
  * **GNU Nano 7.1**
  * **Apache 2.4.54**
  * **PHP 8.2.0**
  * **Composer 2.5.1**
  * **Node.js 19.3.0**
    * **npm 9.2.0**

### 1.8, 1.8-arm, 3.1, 3.1-arm (2022-12-07)

* OS: **Ubuntu 22.04 LTS**
* Main software versions:
  * **Vim 9.0.1025**
  * **GNU Nano 7.0**
  * **Apache 2.4.54**
  * **PHP 7.4.33** (1.8), **PHP 8.1.13** (3.1)
  * **Composer 2.4.4**
  * **Node.js 19.2.0**
    * **npm 8.19.3**
* **Swoole** and **Supervisor** are installed.
* `cron` folder under the home directory is removed.
* Comments in the Dockerfile are changed as output while building.

### 1.7, 1.7-arm (2022-11-03)

* Node.js, Composer, Vim and Nano are updated based on version 1.6 on demands of personal work with PHP 7.
  > Actually based on version 1.5, PHP SQL Server extension is installed while updating the above softwares.  
  > Therefore, the Dockerfile is also divided into two versions for ARM and non-ARM architectures.
* OS: **Ubuntu 20.04 LTS**
* Main software versions:
  * **Vim 9.0.749**
  * **GNU Nano 6.4**
  * **Apache 2.4.53**
  * **PHP 7.4.28**
  * **Composer 2.4.4**
  * **Node.js 18.12.0**
    * **npm 8.19.2**

### 3.0, 3.0-arm (2022-10-29)

* OS: **Ubuntu 22.04 LTS**
  * Great version number of the image jumps to **3** for upgrading from **20.04 LTS**.
* Main software versions:
  * **Vim 9.0.749**
  * **GNU Nano 6.4**
  * **Apache 2.4.54**
  * **PHP 8.1.12**
  * **Composer 2.4.4**
  * **Node.js 18.12.0**
    * **npm 8.19.2**

### 2.4 (2022-03-22)

* OS: **Ubuntu 20.04 LTS**
* MSSQL is supported: **gpg-agent**, **Microsoft ODBC 18** and **Microsoft SQL Server Driver for PHP** is installed.
* PHP 8 parallel version with **version 1.6**.
* All changes are related to MSSQL, and MSSQL Driver for PHP does not support ARM64 architecture other than Apple M1 at present, so **2.4-arm** version is not built.

### 1.6 (2022-03-22)

* PHP 7 parallel version with **version 2.4**.
* All changes are related to MSSQL, and MSSQL Driver for PHP does not support ARM64 architecture other than Apple M1 at present, so **1.6-arm** version is not built.

### 2.3, 2.3-arm (2022-02-19)

* OS: **Ubuntu 20.04 LTS**
* **sntp** and **ca-certificates** is installed.
* **Composer** is updated to **2.2.6**.
* **GNU Nano** is updated to **6.2**.
* PHP 8 parallel version with **version 1.5**.

### 1.5, 1.5-arm (2022-02-19)

* PHP 7 parallel version with **version 2.3**.

### 2.2, 2.2-arm (2022-01-05)

* OS: **Ubuntu 20.04 LTS**
* **Composer** is updated to **2.2.3**.
* **GNU Nano** is updated to **6.0**.
* Image of `arm` architecture is also built.
* PHP 8 parallel version with **version 1.4**.
* *2021-01-15：default passwords of `root` and `user` are changed.*

### 1.4, 1.4-arm (2022-01-05)

* Image of `arm` architecture is also built since this version, like **version 2.x**.
* PHP 7 parallel version with **version 2.2**.
* *2021-01-15: fix the bug of fail to download rc file from GitHub without following the redirect; default passwords of `root` and `user` are changed.*

### 2.1 (2021-04-10)

* OS: **Ubuntu 20.04**
* **GNU Nano** is updated to **5.6.1**.
* Image of `arm` architecture is also built without the simultaneous build of **version 1.x**.
* PHP 8 parallel version with **version 1.3**.

### 1.3 (2021-04-10)

* PHP 7 parallel version with **version 2.1**.

### 2.0 (2020-12-09)

* **PHP** is updated to **8.0**.
* `locale` is set as `en_US.UTF-8`.
* PHP 8 parallel version with **version 1.x**.
* For running on `arm` architecture devices (like Raspberry Pi), a new version named ~~`-rpi4`~~ `-arm` is built without the simultaneous build of **version 1.x**.

### 1.2 (2020-12-09)

* **Composer** is updated to **2.0.8**.
* **less** is installed, and `less --raw-control-chars` is set for default Git pager.
* **GNU Nano** is updated to **5.4**.
* `locale` is set as `en_US.UTF-8`.
* PHP 7 parallel version with **version 2.x**.

### 1.1 (2020-10-22)

* **GNU Nano** is updated to **5.3**.
* **Composer** is updated to **1.10.15**.

### 1.0 (2020-08-28)

* **Ubuntu** is updated to **20.04 LTS**.
* **Docker Compose** is updated to **1.26.2**.
* **GNU Nano** is updated to **5.2**.
* Due to the upgrade of **Ubuntu** and the long time has been since this image is in practical usage, the version number now jumps to **1.0**.

### 0.22 (2020-08-02)

* Based on version 0.21 (**Ubuntu 18.04**), **less** and **locale** are installed for setting Git pager and system locale, but without the synchronization of updates (the image of **Ubuntu 18.04** will not be maintained in the future).

### 0.21 (2020-06-02)

* Some commands of **apt** and **GNU Nano** installing is updated.

### 0.20 (2020-05-15)

* **Screen**, **Tshark** and **GNU Nano** is installed.

### 0.19 (2020-04-20)

* Adjust `www-data` group permissions.
* **cron** is installed; a `crontab` script which can be called from the host is added.

### 0.18 (2020-04-06)

* **PHP** is updated to **7.4**.
* **Node.js** and **npm** is installed.

### 0.17 (2019-10-11)

* Use **zsh** to take place of **bash** as the default shell of the container.
