#!/bin/sh
set -e

if [ -z "$1" ]; then
	echo "Syntax: $0 <template-name>" >&2
	exit 1
fi

# sanitize template name
template_name="$(echo "$1" | sed 's_\.__g' | sed 's_/__g')"

# compute base_dir
base_dir=$(dirname -- $(readlink -f -- "$0"))/..
cd "${base_dir}"
base_dir=$(pwd)

# find templates dir
template_dir="${base_dir}/templates/${template_name}"
if [ ! -d "${template_dir}" ]; then
	echo "Template dir ${template_dir} not found" >&2
	exit 1
fi

# find vars dir
var_dir="${base_dir}/vars/${template_name}"
if [ ! -d "${var_dir}" ]; then
	echo "Vars dir ${var_dir} not found" >&2
	exit 1
fi

# compute templates
template_name_upper="$(echo "${template_name}" | tr a-z A-Z)"

hostname_short=$(hostname -s)
hostname_full=$(hostname -f)
platform=$(uname -s | tr A-Z a-z)
release=unknown
if [ ! -z "$(command -v lsb_release)" ]; then
	release=$(lsb_release -cs | tr A-Z a-z)
fi

# defaults first
cd "${var_dir}"
for file in default.sh "${platform}.sh" "${release}.sh" "${hostname_short}.sh" "${hostname_full}.sh" ; do
	if [ -r "${file}" ]; then
  	set -a
		. "./${file}"
		set +a
	fi
done

# replace vars
envsubst

