# QR Code Creation

This documentation will show how to produce qr codes containing simple text, vEvent, or vCard Contact information on a Linux based system using the qrencode program.

## Process Overview

The qrencode program will need to be installed and basic terminal skills are necessary like changing directories. Otherwise, qrencode's manual page is helpful when in doubt.

### Encode Simple Text

This is a pretty straight forward example use; the default output format is PNG unless otherwise specified also there are other default options which may give undesired behaviors:

```bash
qrencode -o output.{format} -t {format} "hello world"
```

### Encode Data Using File Input

This is certainly more convenient when producing vCard or vEvent images for more information of what data may be encoded view [rfc6350](https://datatracker.ietf.org/doc/html/rfc6350):

```bash
qrencode -r input.txt -o output.png 
```