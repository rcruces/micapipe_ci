
#!/bin/bash
#
# Main script to run the micapipe tests

# micapipe version
version=v0.2.3

# 1. Pull latest docker image (this should be automatic)
img_docker=micalab/micapipe:"${version}"
docker pull "${img_docker}"

# 2. Build singularity image
# set the singularity cache and tmp directories
export SINGULARITY_CACHEDIR=/host/yeatman/local_raid/rcruces/data/images/cache_dir
export SINGULARITY_TMPDIR=/host/yeatman/local_raid/rcruces/data/images/temp_dir

img_singularity=/data/mica1/01_programs/micapipe-v0.2.0/micapipe_"${version}".sif
singularity build "${img_singularity}" docker-daemon://"${img_docker}"

# In the future use datalad to get the BIDS_CI dataset

# 3. Run docker tests
ci_workflow.sh ${version} "docker" "${img_docker}"

# 4. Run singularity tests
ci_workflow.sh ${version} "singularity" "${img_singularity}"

# 5. Output test (number of files outputs)


# 6. Output test (quantitative tests)

