#!/bin/bash

SCRIPT_NAME=$0
ISO=$1
DOCKER_IMAGE_NAME=$2

function log {
  echo "[$(date +%Y%m%d-%T)] $1"
}
function log_info {
  log "INFO: $1"
}
function log_warn {
  log "WARN: $1"
}
function log_error {
  log "ERROR $1"
}
function die() {
  log_error "$1"
  exit 1
}
function usage() {
  echo "$SCRIPT_NAME ISO-FILE DOCKER-IMAGE-NAME"
}

if [ "$#" -ne 2 ]
then
  usage
  die "Wrong number of parameters"
fi 

if [ ! -f $ISO ]
then
  usage
  die "$ISO does not exist"
fi


sudo -s || die "You must be root to run this script"
cd /tmp
mkdir rootfs || die "Couldn't create the temporary root filesystem"
mount -o loop $ISO rootfs || die "Failed to mount $ISO as a loop filesystem"
log_info "Startign the import to Docker ..."
tar -C rootfs -c . | docker import - $DOCKER_IMAGE_NAME
umount rootfs || die "Failed to unmount temporary root filesystem"
rmdir rootfs || die "Failed to remove temporary directory"

log_info "Done"
