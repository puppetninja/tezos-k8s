set -e

bin_dir="/usr/local/bin"
data_dir="/var/tezos"
smart_rollup_node_dir="${data_dir}/rollup"
smart_rollup_node="${bin_dir}/octez-smart-rollup-node"
smart_rollup_snapshot_file="${smart_rollup_node_dir}/rollup-snapshot.archive"

if [ ! -f ${snapshot_file} ]; then
    echo "No snapshot to import."
    exit 0
fi

if [ -e "${smart_rollup_node_dir}/context/store.dict" ]; then
  echo "Smart rollup snapshot has already been imported. Exiting."
  exit 0
fi

echo "Importing smart rollup snapshot"
${smart_rollup_node} snapshot import ${smart_rollup_snapshot_file} --data-dir ${smart_rollup_node_dir} --no-check
find ${smart_rollup_node_dir}

rm -rvf ${snapshot_file}
