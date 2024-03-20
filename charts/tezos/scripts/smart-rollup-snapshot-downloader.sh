#!/bin/sh

set -e

data_dir="/var/tezos"
smart_rollup_node_dir="${data_dir}/rollup"
smart_rollup_snapshot_file="${smart_rollup_node_dir}/rollup-snapshot.archive"

if [ ! -d "${data_dir}" ]; then
  echo "ERROR: /var/tezos doesn't exist. There should be a volume mounted."
  exit 1
fi

if [ -e "${smart_rollup_node_dir}/context/store.dict" ]; then
  echo "Smart rollup snapshot has already been imported. Exiting."
  exit 0
fi

echo "Did not find a pre-existing smart rollup snapshot."

mkdir -p "${smart_rollup_node_dir}"
curl -LfsS ${SNAPSHOT_URL} | tee >(sha256sum > ${smart_rollup_snapshot_file}.sha256sum) > "${smart_rollup_snapshot_file}"
chown -R 1000:1000 "${smart_rollup_node_dir}"
echo "Rollup snapshot downloaded"