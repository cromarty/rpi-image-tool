
# How to User `clone-running-pi`

## Fast Example

```
sudo clone-running-pi -b <boot partition clone path> -r <root partition clone path>
```

The above clones the `boot` partition files into the path given in the `-b` parameter, and the `root` partition files into the path given in the `-r` parameter.

While these paths *can* be on the running Pi, there is little point if you are attempting to properly clone or back-up your files.

## Cloning to Directories in a Mounted Drive

You could use a USB thumb drive with a single partition and two directories:

* boot
* root

Mount the drive:

```
sudo mount /dev/sdx1 /mnt
```

The above will give:

```
/mnt/boot
/mnt/root
```

Giving these paths to the script:

```
clone-running-pi -b /mnt/boot -r /mnt/root

Will write the contents of the two partitions to the directories on the thumb drive.

## Creating a New (bootable) `.img` File

By using `rpi-image-tool` it is possible to create anew and empty `.img` file which can then be used to clone the existing file systems of your Pi into.

See `rpi-image-tool.md` in this repository.

### Example of Clone Using `rpi-image-tool`

1. Either use an existing thumb drive, or prepare one for use.

2. Mount it:

```
sudo mount /dev/sda1 /mnt
```

The above assumes the device name of the thumb drive is `/dev/sda`.

3. Use `rpi-image-tool` to create a new `.img` file:

```
sudo rpi-image-tool -N clone.img -c 2000 -s 64 -w /mnt -z 1m
```

The number of blocks given in `-c` needes to be enough to hold all your root file-system files.

You may have to increase it if you have installed loads of stuff since it was a fresh install.

You will also have to increase the `split` size, given in the `-s` parameter, to 96 for Arch Linux.

The above will have created a file:

```
/mnt/clone.img
```

And mounted it's two file systems in:

```
/mnt/boot
/mnt/root
```

4. Now running `clone-running-pi` like this:

```
sudo clone-running-pi -b /mnt/boot -r /mnt/root
```

Will backup your files into the new `.img` file `/mnt/clone.iimg`.

It will take a long time, because the write-speed of some SD cards is not very fast.

5. Clean-up

```
sudo rpi-image-tool -C /mnt
```

Here the value given in the `-C` parameter is the same as the value given to `-w` when `rpi-image-tool` was run to create the `.img` file.

Will un-mount the two partitions in the `clone.img` file.

## Notes

If you did not provide a high enough block-count creating a `.img` file with `rpi-image-tool`, or a big enough split to hold all the files in the boot partition, the script will fail.

It is a good idea to give enough blocks to fill the card you intend to use to house the new `.img` file.







