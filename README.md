# Unity Package Template

This template project allows to generate basic unity packages through a wizard.

## Usage

Clone this repository into your project and run `setup.sh` to start the wizard.

```
$ git clone --depth=1 https://github.com/yanicksenn/unity-package-template.git mypackage
$ cd mypackage
$ ./setup.sh
Name: com.mycompany.mypackage
Version: 1.0.0
Display Name: My Package
Description: This is the description to my package.
Author Name: John Doe
Author Email: info@johndoe.com
Assembly Name: MyPackage
Assembly Namespace: MyPackage.Core
```

Afterwards you should find files in the following structure:

```
mypackage
|
|--- Runtime
|  |--- MyPackage.asmdef
|
|--- Editor
|  |--- MyPackage.Editor.asmdef
|
|--- Tests
|  |--- Runtime
|  |  |--- MyPackage.Tests.asmdef
|  |
|  |--- Editor
|     |--- MyPackage.Editor.Tests.asmdef
|
|--- package.json
|--- README.md
```

## References

- [Unity Package Layout](https://docs.unity3d.com/Manual/cus-layout.html)
