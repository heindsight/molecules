#!/bin/bash

/usr/sbin/env-update && source /etc/profile

remaster_type="${1}"
isolinux_source="/sabayon/remaster/minimal_isolinux.cfg"
isolinux_destination="${CDROOT_DIR}/isolinux/isolinux.cfg"

if [ "${remaster_type}" = "KDE" ] || [ "${remaster_type}" = "GNOME" ]; then
	isolinux_source="/sabayon/remaster/standard_isolinux.cfg"
elif [ "${remaster_type}" = "ServerBase" ]; then
	echo "ServerBase trigger, copying server kernel over"
	boot_kernel=$(find "${CHROOT_DIR}/boot" -name "kernel-*" | sort | head -n 1)
	boot_ramfs=$(find "${CHROOT_DIR}/boot" -name "initramfs-*" | sort | head -n 1)
	cp "${boot_kernel}" "${CDROOT_DIR}/boot/sabayon" || exit 1
	cp "${boot_ramfs}" "${CDROOT_DIR}/boot/sabayon.igz" || exit 1
	isolinux_source="/sabayon/remaster/serverbase_isolinux.cfg"
fi
cp "${isolinux_source}" "${isolinux_destination}" || exit 1

ver=${RELEASE_VERSION}
[[ -z "${ver}" ]] && ver=${CUR_DATE}
[[ -z "${ver}" ]] && ver="5.5"

sed -i "s/__VERSION__/${ver}/g" "${isolinux_destination}"
sed -i "s/__FLAVOUR__/${remaster_type}/g" "${isolinux_destination}"

kms_string=""
# should KMS be enabled?
if [ -f "${CHROOT_DIR}/.enable_kms" ]; then
	rm "${CHROOT_DIR}/.enable_kms"
	kms_string="radeon.modeset=1"
fi
sed -i "s/__KMS__/${kms_string}/g" "${isolinux_destination}"

sabayon_pkgs_file="${CHROOT_DIR}/etc/sabayon-pkglist"
if [ -f "${sabayon_pkgs_file}" ]; then
	cp "${sabayon_pkgs_file}" "${CDROOT_DIR}/pkglist"
        if [ -n "${ISO_PATH}" ]; then # molecule 0.9.6 required
                # copy pkglist over to ISO path + pkglist
                cp "${sabayon_pkgs_file}" "${ISO_PATH}".pkglist
        fi
fi
