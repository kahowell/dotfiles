export ANDROID_HOME=$HOME/Android/Sdk
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/emulator"
export AAPT2=$(find ~/Android/Sdk/build-tools/ -name aapt2 2>/dev/null| sort | tail -n 1)
export ANDROID_JAR=$(find ~/Android/Sdk/platforms/ -name android.jar 2>/dev/null | sort | tail -n 1)
