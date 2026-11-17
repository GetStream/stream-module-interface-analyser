#!/usr/bin/env bash
# Usage: smoke-test.sh <path to the interface-analyser binary>
# Analyses two versions of a small source file and checks the diff report.
set -euo pipefail

bin=$1
dir=$(mktemp -d)
mkdir -p "$dir/old" "$dir/new"

printf 'public struct Sample {\n    public func run() {}\n}\n' > "$dir/old/Sample.swift"
printf 'public struct Sample {\n    public func run() {}\n    public func stop() {}\n}\n' > "$dir/new/Sample.swift"

"$bin" analysis "$dir/old" "$dir/old.json"
"$bin" analysis "$dir/new" "$dir/new.json"
"$bin" diff "$dir/new.json" "$dir/old.json" "$dir/report.md"

grep -q '"name" : "Sample"' "$dir/new.json"
grep -q 'public func stop()' "$dir/report.md"
echo "Smoke test passed"
