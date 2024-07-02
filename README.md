# Website

To build this site, you must install [Hugo](https://gohugo.io/) and run the `hugo.sh` file.

## Install Hugo

- Download the executable for your CPU architecture on [this](https://github.com/gohugoio/hugo/releases/latest) link
- Move the extracted `hugo` file to the `.local/bin` directory on your user folder
- If the `.local/bin` directory is not present on your `PATH` environment variable (run `echo $PATH to verify`), you must add it on the configuration file of your terminal shell

### Bash PATH

To add the `.local/bin` directory on the `PATH` of your GNU Bash, add the following text on the end of the `.bashrc` file at your user folder:

```
export PATH=$PATH:$HOME/.local/bin
```

## Preview

To preview the site, run the following command, wait it to finish and open the link http://localhost:1313

```sh
./hugo.sh serve
```

The `hugo.sh` is a script that enables content written for the English language webpage (in the `content/` directory) to be visible in pages of other languages.  

But this results in a quirk where _hugo_ does not watch for changes in the `content/` directory when you use `./hugo.sh serve` command.  

So, you can use the `hugo serve` command instead, which makes sure that `content/` directory is also watched (just for when you're writing the pages).
