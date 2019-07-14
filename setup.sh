#!/usr/bin/env sh

PUBLIC_KEY_PATH="${HOME}/.ssh/id_rsa.pub"

if [ ! -f "$PUBLIC_KEY_PATH" ]; then
  echo "Cannot find a public key at ${PUBLIC_KEY_PATH}." 2>/dev/null
  exit 1
fi

adb root

adb install resources/x1125io.initdlight_2.apk 

adb push resources/sshd_config /data/ssh/sshd_config

adb shell mkdir -m 700 /data/.ssh
adb push -- "$PUBLIC_KEY_PATH" /data/.ssh/authorized_keys
adb shell chown -R shell:shell /data/.ssh

adb push resources/99sshd /data/user/0/x1125io.initdlight/files/99sshd
