#!/usr/bin/env bash
# Copy required Ghidra JARs from a Ghidra installation to ./lib/
#
# Usage: ./copy-ghidra-libs.sh /path/to/ghidra
# Example: ./copy-ghidra-libs.sh ~/ghidra_11.3.2_PUBLIC

set -e

GHIDRA_ROOT="${1:?Usage: $0 /path/to/ghidra}"

LIBS=(
  "Ghidra/Features/Base/lib/Base.jar"
  "Ghidra/Features/Decompiler/lib/Decompiler.jar"
  "Ghidra/Framework/Docking/lib/Docking.jar"
  "Ghidra/Framework/Generic/lib/Generic.jar"
  "Ghidra/Framework/Project/lib/Project.jar"
  "Ghidra/Framework/SoftwareModeling/lib/SoftwareModeling.jar"
  "Ghidra/Framework/Utility/lib/Utility.jar"
  "Ghidra/Framework/Gui/lib/Gui.jar"
)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="${SCRIPT_DIR}/lib"
mkdir -p "$LIB_DIR"

for relpath in "${LIBS[@]}"; do
  src="${GHIDRA_ROOT}/${relpath}"
  if [[ ! -f "$src" ]]; then
    echo "Error: not found: $src" >&2
    exit 1
  fi
  echo "Copying $(basename "$relpath")..."
  cp "$src" "$LIB_DIR/"
done

echo "Done. Copied ${#LIBS[@]} JARs to $LIB_DIR"
