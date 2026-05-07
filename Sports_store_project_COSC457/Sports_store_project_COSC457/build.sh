#!/usr/bin/env bash
# Plain javac/jar build script. Works on macOS and Linux.
# Requires a JDK (not just a JRE) on PATH — verify with `javac -version`.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLASSES_DIR="$ROOT_DIR/target/classes"
# Use a temp dir under the system tmpdir so this runs on Linux as well as macOS.
FAT_DIR="$(mktemp -d -t sports-store-fat.XXXXXX 2>/dev/null || mktemp -d)"
trap 'rm -rf "$FAT_DIR"' EXIT
MYSQL_JAR="$ROOT_DIR/lib/mysql-connector-j-8.3.0.jar"

if ! command -v javac >/dev/null 2>&1; then
  echo "javac not found on PATH."
  echo "Install a JDK 17 (or newer). A JRE alone is not enough."
  exit 1
fi

if [[ ! -f "$MYSQL_JAR" ]]; then
  echo "Missing $MYSQL_JAR"
  echo "Download it with:"
  echo "  mkdir -p lib && curl -L -o lib/mysql-connector-j-8.3.0.jar \\"
  echo "    https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.3.0/mysql-connector-j-8.3.0.jar"
  exit 1
fi

rm -rf "$CLASSES_DIR"
mkdir -p "$CLASSES_DIR" "$ROOT_DIR/target"

javac -encoding UTF-8 -d "$CLASSES_DIR" $(find "$ROOT_DIR/src/main/java" -name "*.java")

(cd "$FAT_DIR" && jar xf "$MYSQL_JAR")
jar cfe "$ROOT_DIR/target/sports-store-app.jar" com.sportsstore.App \
  -C "$FAT_DIR" . \
  -C "$CLASSES_DIR" .

echo "Built $ROOT_DIR/target/sports-store-app.jar"
