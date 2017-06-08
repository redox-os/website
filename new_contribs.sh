#!/bin/sh

#
# Small hacky utility to get new contributors in a project-wise fashion.
# So we know when somebody is really new to Redox across all the sub-repos.
#
# I usually run it like:
# ./path/to-redox-website/new_contribs.sh 2017-02-01
#
# From the Redox main repo.
#
# Adapted from the Rust one.

# Create the temp files
touch names_old.txt
touch names_all.txt

#
# Gets the list of commiters for a give git repo. Only runs if the dir is a git repo.
# $1 holds the initial date from where we are gonna start counting.
#
get_new_commiters() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        INITIAL_COMMIT=`git log --reverse --pretty=format:%H|head -n1`
        START_COMMIT=`git log --before="$1" --pretty=format:%H|head -n1`
        ALL_NAMES=`git log $INITIAL_COMMIT.. --pretty=format:%an|sort|uniq`
        OLD_NAMES=`git log $INITIAL_COMMIT..$START_COMMIT --pretty=format:%an|sort|uniq`
        echo "$OLD_NAMES">>names_old.txt
        echo "$ALL_NAMES">>names_all.txt
    fi
}

export -f get_new_commiters

# Running the function recursively (defaulting to 1 level deep)
find . -maxdepth 1 -type d -exec bash -c "get_new_commiters $1" {} \;

# Subtracting the names from the initial commit to the start date - all names.
names=`diff names_old.txt names_all.txt`
names=`echo "$names" |grep \> | sed 's/^>//'|sort|uniq`
echo "$names"

# Clean files
rm names_old.txt names_all.txt
