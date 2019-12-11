#!/usr/bin/env bash

set -euo pipefail

die() {
    echo >&2 "$@"
    exit 1
}

MD_DIR="$1"
OUT_DIR="$2"

[[ -n "$MD_DIR" && -n "$OUT_DIR" ]] || die "Usage: $0 <metadata directory> <output directory>"
[[ -d "$MD_DIR" ]] || die "Metadata directory $MD_DIR does not exist or is not a directory."

[[ -n "${COLLECTOR_MODULES_BUCKET:-}" ]] || die "Must specify a COLLECTOR_MODULES_BUCKET"

mkdir -p "$OUT_DIR" || die "Failed to create output directory ${OUT_DIR}."

for mod_ver_dir in "${MD_DIR}/module-versions"/*; do
    mod_ver="$(basename "$mod_ver_dir")"

    package_root="$(mktemp -d)"
    probe_dir="${package_root}/kernel-modules/${mod_ver}"
    mkdir -p "$probe_dir"
    {
        gsutil ls "${COLLECTOR_MODULES_BUCKET}/${mod_ver}/*.gz" | sed -E 's@^([^/]*/)*@@g'
        cat "${mod_ver_dir}/COMMON_INVENTORY"
    } | sort | uniq -u | awk -v PREFIX="${COLLECTOR_MODULES_BUCKET}/${mod_ver}" '{print PREFIX "/" $1}' \
    | gsutil -m cp -I "$probe_dir"

    package_out_dir="${OUT_DIR}/${mod_ver}"
    mkdir -p "$package_out_dir"
    filename="support-pkg-${mod_ver::6}-$(date '+%Y%m%d%H%M%S').zip"

    ( cd "$package_root" ; zip -r "${package_out_dir}/${filename}" . )
    rm -rf "$package_root" || true
done