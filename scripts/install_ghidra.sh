if [ -f ~/src/ghidra_11.2_PUBLIC/ghidraRun ]; then
  echo "Ghidra already installed"
else
  wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb
  sudo dpkg -i jdk-21_linux-x64_bin.deb && rm jdk-21_linux-x64_bin.deb

  wget https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_11.2_build/ghidra_11.2_PUBLIC_20240926.zip
  unzip ghidra_11.2_PUBLIC_20240926.zip && rm ghidra_11.2_PUBLIC_20240926.zip

  mkdir -p ~/src
  mv ghidra_11.2_PUBLIC ~/src
fi
