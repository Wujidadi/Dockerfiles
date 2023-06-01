# Ubuntu Tuned

On the basis of wujidadi/ap, but without Apache, Nginx, PHP, Node.js and related software, only basic packages and Zsh (including Oh My Zsh) are installed, which is a relatively pure Ubuntu environment.

## Release Notes

### 2.6 (2023-06-01)

* `docker buildx` commands: (`$D` is a custom alias of the log directory)
  ```sh
  docker buildx build --no-cache --progress=plain --push --platform linux/amd64,linux/arm64 --rm -t wujidadi/ubuntu-tuned:2.6 -t wujidadi/ubuntu-tuned:latest ubuntu-tuned/2.6 2>&1 | tee $D/docker-build-ut.log
  ```
* OS: **Ubuntu 22.04 LTS**
* Main software versions:
  * **Vim 9.0.1595**
  * **GNU Nano 7.2**

### 2.5.2 (2023-05-11)

* OS: **Ubuntu 22.04 LTS**
* Main software versions:
  * **Vim 9.0.1539**
  * **GNU Nano 7.2**

### 2.5.1 (2023-05-10)

* OS: **Ubuntu 22.04 LTS**
* Main software versions:
  * **Vim 9.0.1536**
  * **GNU Nano 7.2**

### 2.5 (2023-05-01)

* OS: **Ubuntu 22.04 LTS**
* Main software versions:
  * **Vim 9.0.1503**
  * **GNU Nano 7.2**

### 2.4 (2023-04-01)

* OS: **Ubuntu 22.04 LTS**
* Main software versions:
  * **Vim 9.0.1433**
  * **GNU Nano 7.2**

### 2.3 (2023-02-16)

* `docker buildx` is used to build multiarch images since this version.
* OS: **Ubuntu 22.04 LTS**
* Main software versions:
  * **Vim 9.0.1313**
  * **GNU Nano 7.2**

### 2.2, 2.2-arm (2022-12-30)

* OS: **Ubuntu 22.04 LTS**
* Main software versions:
  * **Vim 9.0.1108**
  * **GNU Nano 7.1**

### 2.1, 2.1-arm (2022-12-07)

* OS: **Ubuntu 22.04 LTS**
* Main software versions:
  * **Vim 9.0.1025**
  * **GNU Nano 7.0**
* Comments in the Dockerfile are changed as output while building.

### 2.0, 2.0-arm (2022-10-29)

* OS: **Ubuntu 22.04 LTS**
  * Great version number of the image jumps to **2** for upgrading from **20.04 LTS**.
* Main software versions:
  * **Vim 9.0.749**
  * **GNU Nano 6.4**

### 1.2 (2022-03-22)

* **gpg-agent** is installed.

### 1.1, 1.1-arm (2022-02-19)

* Based on **Ubuntu 20.04 LTS**.
* Building environment is like **wujidadi/ap:2.3**.
* Image of `arm` architecture is also built since this version.
* Default passwords of `root` and `user` are changed just like **wujidadi/ap** version **1.4** and **2.2**.

### 1.0 (2021-08-07; 2022-01-20 little changes)

* Based on **Ubuntu 20.04 LTS**.
* Building environment is like **wujidadi/ap:2.1**.
