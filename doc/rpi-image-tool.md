
# How to use rpi-image-tool

This tool can:

* Create a new and empty `.img` file of controlled size
* Mount the two prtitions in a new `.img` file
* Mount the two partitions in an existing Raspberry Pi `.img` file
* Mount the two partitions in an SD card plugged into the machine

## Dependencies

You will need `intltool` as the script is internationalized.

You will also need `kpartx`. In Debian and Ubuntu `kpartx` is in the repositories as `kpartx`, in Arch Linux it is in `multipath-tools`, which, I think, is in the AUR.

## General Notes

It is *very* important to remember that the script assumes that we are dealing with Raspberry Pi images that have the typical two partitions:

1. Boot, a FAT32 partitions
2. Root, a Linux partition of type ext4 (type not important)

There is *very little* or no paranoia checking to see if this true before the script starts.

It is also *very* impoartant to note that the script uses the `dd` command to write a `.img` file, so you need to be very sure when you run it that you are pointing it at the right place.

## Creating a New Empty `.img` File

```
sudo rpi-image-tool -N <img name> -c <block count> -s <split> -w <work dir> -z <block size>

### Parameter Descriptions

The `-N` parameter (capital N) instructs `rpi-image-tool` to create a new empty `.img` file.

The `-c` parameter is an integer count of the number of blocks to write to the new `.img` file.

The `-s` parameter is the split, or the point in the `.img` file at which the boot partition will end and the root partition begin.

So, if the value of the split is given as 64 (the default), then the boot partition occupies the first 64 blocks, and after that the remaining blocks are in the root partition.

The `-w` parameter is the working directory, in which `rpi-image-tool` will create two mount-points for the new `.img` file partitions.

The `-z` parameter is the block size. The default is `1M`.


### Example `-N` Run

```
rpi-image-tool -N clone.img -c 2000 -s 64 -w ./work -z 1M
```

The above sample run creates:

* A new and empty `.img` file of name 'clone.img'
* With a block count of 2000 1M blocks
* The boot partition ends after block 64 and the rest if root partitions
* A working directory of `./work` which will contain `boot` and `root` directories
* Other files used when `rpi-image-tool` cleans up

The `boot` and `root` directories in the working directory now have the two partitions mounted on them.

## Mounting an Existing `.img` File

```
rpi-image-tool -M <img name> -w <work dir>
```

Will mount the two partitions in the existing `.img` file <img name> in the `boot` and `root` sub-directories of the <work dir> directory.

## Mounting a Device

```
rpi-image-tool -D /dev/sdx -w <work dir>
```

Will mount the two partitions in /dev/sdx (assumed to be an SD card) with it's two partitions mounted on the `boot` and `root` sub-directories in the directory given in <work dir>


## Cleaning Up

Whether `rpi-image-tool` has been used to create and mount partitions in a new `.img` file, mount an existing file, or mount a device:

```
rpi-image-tool -C <work dir>
```

Will:

* Un-mount the partitions
* Remove working files

Of course it does not remove `.img` files either old or new. So it will not remove the working directory, as this may be part of the path given in `-w` when the new file was created, or an existing file was mounted, or a device was mounted.

## General Notes

### Assumptions

As stated above, the script assumes any `.img` file, or any SD card, contains two, and only two, partitions:

1. Boot partition of FAT32 type
2. Root partition of Linux type

Actually the types are not important, but the order *is* important.

The script will fail in an unpredictiable way if the partitions in the existing `.img` file or on the SD card diffeer.

### Dangers

The script uses `dd` two write new `.img` files.  You should be careful what you give as the working directory path, as `dd` is unforgiving and silent.

### Split Counts

I have found 64 blocks to be sufficient for distributions of Raspbian up to the current day, and Arch Linux needs a bit more, 96 seems enough.

Block count, 2000 is usually enough for an example of Raspbian which has little installed from new.





