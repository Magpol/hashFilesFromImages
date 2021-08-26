# hashFilesFromImages
Small script for hashing files in forensic images using tools from The Sleuth kit!

```
~/Desktop/Work$ ./hashFilesFromImages.sh test/
Processing test/dfr-15-xfat.dd
test/dfr-15-xfat.dd is done! Total files processed: 15
Processing test/dfr-16-fat.dd
test/dfr-16-fat.dd is done! Total files processed: 1026
Processing test/dfr-17-ntfs.dd
test/dfr-17-ntfs.dd is done! Total files processed: 69

~/Desktop/Work$ head -10 test/dfr-15-xfat.dd.txt 
/$ALLOC_BITMAP;0707ff22a3d11cf26069a529d5cf8710a52d5cec36fab17b04e969f9f171a371
/$UPCASE_TABLE;8344f27a410a16df14ad98decde32b48c4db0b8e7fa8b9dc4394b58ced972f11
/._.Trashes;fee488f9f3f6824b126a9a5c4b63a8208cb9b64ea28f2150f27b6976018834df
/.fseventsd/fseventsd-uuid;a0006acc96a9eca87250e1fb20dabbc9fdaffa3b9bcc548a797117c40d4c232d
/.fseventsd/0000000000ae3ac9;2d49d44b876eb70193a6032c985bae0b492369a3ab029439ce4ba88403c75f73
/Adhara-file-XFAT.txt;d917d64901ceca16bd5e938b22f1896a1d6b0d01505baaf8fbee3a0e1d3566d7
/Adhara-shortcut-XFAT.lnk;e5c0a2f25e92069e317563c9edb6545edc9cbb63378100f34332fd25acdc83ce


```

Imagetypes supported depends on what flagsd TSK are compiled with. Check with fls or some other TSK tool:

```
~/Desktop/Work$ fls -i list
Supported image format types:
	raw (Single or split raw file (dd))
```
