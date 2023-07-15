# website

To build this site, you must install [Hugo](https://gohugo.io/) and run the `hugo.sh` file.

To preview the site, run `./hugo.sh serve` and then open [http://localhost:1313](http://localhost:1313)

> `./hugo.sh` is a script that enables content written for the English language webpage (in the `content/` directory) to be visible in pages of other languages.  
> But this results in a quirk where _hugo_ does not watch for changes in the `content/` directory when you use `./hugo.sh serve` command.  
> So, you can use the `hugo serve` command instead, which makes sure that `content/` directory is also watched (just for when you're writing the pages).
