#!/bin/bash

# barebones installer

if command -v rish &>/dev/null; then
  echo "Rish is already installed.."
  printf "Overwrite? [ y/N ]"
  read -r ans
  case "$ans" in
    y|Y)
      ;;
    *)
      echo "Abort."
      exit 1
      ;;
  esac
fi

LBIN="$HOME/.local/bin/"
echo "Installing rish for shizuku.."

downloadfiles() {

  wget https://raw.githubusercontent.com/byscourge/rishinstall/master/rish || {
    echo "Installation failed!"
    exit 1
  }

  wget https://raw.githubusercontent.com/byscourge/rishinstall/master/rish_shizuku.dex || {
    echo "Installation failed!"
    exit 1
  }

}

if command -v wget &>/dev/null; then

  downloadfiles || exit 1

  chmod +x rish rish_shizuku.dex

  mkdir -p $LBIN 2>/dev/null
  mv rish "$LBIN"
  mv rish_shizuku.dex "$LBIN"
else
  pkg install wget || {
    echo "wget Installation failed!"
    exit 1
  }
downloadfiles || exit 1
fi

if command -v rish &>/dev/null; then
  echo "Shizuku install complete! run rish to enter."
fi
