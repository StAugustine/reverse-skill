#!/bin/bash
# BurpSuite MCP Full Control - Linux/macOS Build Script
# Requires: JDK 21+, curl

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# Auto-detect JAVA_HOME
if [ -z "$JAVA_HOME" ]; then
    if command -v javac &>/dev/null; then
        JAVA_HOME="$(dirname $(dirname $(readlink -f $(which javac))))"
    else
        echo "ERROR: javac not found. Install JDK 21+ or set JAVA_HOME."
        exit 1
    fi
fi

JAVAC="$JAVA_HOME/bin/javac"
JAR="$JAVA_HOME/bin/jar"
SRC="src/main/java/com/burpmcp"
LIB="lib"
OUT="build/classes"
DIST="build/libs"

echo "[1/4] Downloading dependencies..."
mkdir -p "$LIB"

[ -f "$LIB/montoya-api.jar" ] || curl -sL -o "$LIB/montoya-api.jar" "https://repo1.maven.org/maven2/net/portswigger/burp/extensions/montoya-api/2025.5/montoya-api-2025.5.jar"
[ -f "$LIB/gson.jar" ] || curl -sL -o "$LIB/gson.jar" "https://repo1.maven.org/maven2/com/google/code/gson/gson/2.11.0/gson-2.11.0.jar"
[ -f "$LIB/nanohttpd.jar" ] || curl -sL -o "$LIB/nanohttpd.jar" "https://repo1.maven.org/maven2/org/nanohttpd/nanohttpd/2.3.1/nanohttpd-2.3.1.jar"

echo "[2/4] Compiling..."
mkdir -p "$OUT"
"$JAVAC" -cp "$LIB/montoya-api.jar:$LIB/gson.jar:$LIB/nanohttpd.jar" -d "$OUT" $SRC/*.java

echo "[3/4] Packaging fat jar..."
mkdir -p "$DIST"
cd "$OUT"
"$JAR" xf "../../$LIB/gson.jar" com
"$JAR" xf "../../$LIB/nanohttpd.jar" fi
cd ../..
"$JAR" cf "$DIST/burp-mcp-full.jar" -C "$OUT" .

echo "[4/4] Done!"
echo "Output: $DIST/burp-mcp-full.jar"
echo ""
echo "Install: Burp Suite 鈫?Extensions 鈫?Add 鈫?Java 鈫?Select $DIST/burp-mcp-full.jar"
echo ""
echo "MCP config (any client):"
echo '  { "command": "node", "args": ["'$SCRIPT_DIR'/mcp-bridge.js"] }'
