
# `rpi-image-tool`

A tool for:

* Creating new and empty `.img` files with two partitions.
* Mounting created or existing `.img` files.
* Un-mounting the same.

All `.img` files are created with two partitions of the types required for a
Raspberry Pi:

1. A FAT32 bootable partition, partition number 1.
2. An ext4 root filesystem partition, partition number 2.

## The Usage

Here is the usage message from the script:

Usage: rpi-image-tool {options ...}

Options:

     -C <work_dir>

     Clean-up a previous run, unmounting partitions, removing
     working files (not the image file or the working directory.

     -D <device>

     Mount the partitions on the SD card or other device.

     -M <image_file>

     Mount the partitions of an existing image file.

     -N <image_file>

     Create, partition and mount a new (empty) image file.

     Only one of the above uppercase options is permitted in any single run.

     -h

     Display this help text and exit.

     -c <integer_block_count>

     The number of blocks to write to a new image file. See -z below.
     Only relevant when using the -N option to generate a new image.

     -s <integer_split>

     The size of the FAT16) boot partition in blocks. See -z below for block size.
     Only relevant when using the -N option to create a new image.
     Default = 64

     -w <working_directory>

     The working directory which will contain the mount-point and other working files
     (not including the .img file unless the working directory is prefixed in the -N option.

     -z <block_size>

     The block size.
     Only relevant when using the -N option to create a new image.
     Permitted values are '1M' or '1MB'
     Default = 1M

Notes:

The script assumes that:

     1. The first partition is the boot partition.
     2. The second partition is the root partition.

If the supplied working directory is 'work', the mounts will be as follows:

     work/root         (where the root partition is mounted)
     work/root/boot    (where the boot partition is mounted)

**IMPORTANT**

There is *NO* paranoia checking to check the 2 partition rule is obeyed in any
image file or device being created or mounted.

Be very careful when specifying the device name to a -N run of this script.
It uses 'dd' to generate the .img file and
'dd' is silent and deadly if you pick the wrong device, for example your main
hard-disk.

You have been warned!


