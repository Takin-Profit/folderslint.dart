# folderslint.dart

# FoldersLint <img src="https://ph-files.imgix.net/ca08c2f9-856e-4995-b500-85935be555e7.png" alt="FoldersLint logo" width="90" height="90" align="right" />

Directory structure linter for Front-End projects

<img src="https://thumbnails.visme.co/c0/e6/f2/83/08271a1cdafd2c288d7f2ec677dda7b7.png" alt="FoldersLint in action" title="FoldersLint in action" height="390" style="margin-left: -200px;">

✅ &nbsp;&nbsp;Easily configured with simple rules in a single file

✅ &nbsp;&nbsp;Incredibly fast

✅ &nbsp;&nbsp;Support for Windows, MacOS and Linux

✅ &nbsp;&nbsp;Can be used with [lint-staged](https://github.com/okonet/lint-staged)

## Why

*Make your project structure pretty by linting it* 🗂

Directory structure rules are an important part of any project.
These rules help to raise clarity of the project and reduce its complexity.
Having a clearly defined structure make developers always know where to put files and where to find them.
If the project is big enough, it is necessary to avoid chaos in it.

`folderslint` let you configure directory structure rules and check if existed or new files fit these rules.

## Quick Overview

Install `folderslint` globally:

```sh
pub global activate folderslint
```

or install it as a dev dependency
```sh
pub add dev:folderslint 
```
Setup a config file `.folderslintrc` in the root of the project.

Run `folderslint` to check the whole project or a directory (i.e. `/components`):

(if installed globally)
```sh
folderslint components
```

if installed as a dev dependency

```sh
dart run folderslint components
```

## Configuration
`folderslint` needs configuration file named `.folderslintrc` in the root of the project.

The example of the config:

```json
{
  "root": "src", // optional
  "rules": [
    "components/*",
    "pages/components/*/utils",
    "hooks",
    "legacy/**"
   ]
}
```

`root` is the directory the structure of which should be checked.

`rules` is an array of rules which define permitted directory paths.

### Root directory

You have to specify `root` if you want to check structure in a specific directory. Directories which are out of the `root` will not be checked.
If you want all the directories of the project to be checked, you don't need to specify `root`.

### Rules syntax

There are 3 ways to specify a rule:
- the exact path of a directory,
- `*` instead of a directory name if any directory accepted on that level,
- `**` **at the end of a rule** instead of a directory name if any directory accepted on any lower level. 

⚠️ `**` **can be used only at the end of a rule** because it doesn't make sense to use it at the middle of a rule.
It would make any number of nested directories in the middle of a path accepted
which gives too much flexibility for the idea of clearly defined directory structure rules.

For example:

| Rule                     | Meaning                                                                                                                                                                                                                                                                                                                                                                         |
|--------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `hooks`                  | ✅&nbsp;&nbsp;The directory `hooks` (and files in it) is accepted.<br/> ❌&nbsp;&nbsp;Any nested directory is not accepted.                                                                                                                                                                                                                                                       |
| `components/*`           | ✅&nbsp;&nbsp;The directory `components` is accepted.<br/> ✅&nbsp;&nbsp;Any *first level* nested directory is accepted.<br/> ❌&nbsp;&nbsp;Any *second level* nested directory is not accepted.                                                                                                                                                                                   |
| `components/*/utils`     | ✅&nbsp;&nbsp;The directory `components` is accepted.<br/> ✅&nbsp;&nbsp;Any *first level* nested directory is accepted.<br/> ✅&nbsp;&nbsp;The *second level* nested directory `utils` is accepted.<br/> ❌&nbsp;&nbsp;Any other *second level* nested directory is not accepted.                                                                                                  |
| `legacy/**`              | ✅&nbsp;&nbsp;The directory `legacy` is accepted.<br/> ✅&nbsp;&nbsp;Any nested directory on *any level* is accepted.                                                                                                                                                                                                                                                             |
| `components/*/legacy/**` | ✅&nbsp;&nbsp;The directory `components` is accepted.<br/> ✅&nbsp;&nbsp;Any *first level* nested directory is accepted.<br/> ✅&nbsp;&nbsp;The *second level* nested directory `legacy` is accepted.<br/> ❌&nbsp;&nbsp;Any other *second level* nested directory is not accepted.<br/> ✅&nbsp;&nbsp;Any nested directory on *any level* inside of *legacy* directory is accepted. |

⚠️ A rule like `components/*/utils` automatically make the `components` and `components/*` rules work. So, no need to specify a rule for every level directory. You need to specify the deepest path.

⚠️ It's not recommended to overuse `**` pattern. It lets absence of structure to sprout in your project. Still it could be useful for some directories which have messy structure by its nature - i.e. `node_modules`, not maintained legacy directories.
