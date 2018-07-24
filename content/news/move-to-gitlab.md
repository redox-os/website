+++
title = "Move to GitLab"
author = "jD91mZM2"
date = "2018-07-24T06:48:19+02:00"
+++

You may have noticed that all our GitHub repositories are now mirrors of
https://gitlab.redox-os.org/. Since the recent acquisition of GitHub by
Microsoft, a lot of people, including us, start to think about the
alternatives. We don't necessarily hate Microsoft, but what *would* happen if
GitHub went down? So for that curiosity we checked out the alternatives, and
saw all the nice features of GitLab. To mention a few, the self-hosted platform
is free and open source, it has some cool automatic mirroring features,
and an integrated CI. And since so many people started checking GitLab out, we
don't neccesarily have to be the odd ones out!

Signing up to https://gitlab.redox-os.org/ will require a separate account but
you can sign up with GitHub. We didn't enable the sign in with GitLab option
yet, ironically. Once in, it's very much what you'd expect of a self-hosted
GitLab: everybody has a separate account, and there is a redox-os organization
for all the official stuff. We plan on organizing the repositories in groups as
well, to clean things up. However, everything is top-level for now to make it
easier to update links to our GitLab.

```
s/github.com\(\/redox-os\/\)/gitlab.redox-os.org\1/g
```
