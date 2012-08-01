# Use abs path, otherwise daily builds automagic won't work
%env %import ${SABAYON_MOLECULE_HOME:-/sabayon}/molecules/lxde.common

# Release Version
release_version: 9

# Release Version string description
release_desc: amd64 LXDE

# Path to source ISO file (MANDATORY)
%env source_iso: ${SABAYON_MOLECULE_HOME:-/sabayon}/iso/Sabayon_Linux_SpinBase_DAILY_amd64.iso

# Destination ISO image name, call whatever you want.iso, not mandatory
destination_iso_image_name: Sabayon_Linux_9_amd64_LXDE.iso
