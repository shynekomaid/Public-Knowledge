# Git Ninja Commit

## Table of Contents

- [Git Ninja Commit](#git-ninja-commit)
  - [Table of Contents](#table-of-contents)
  - [Preamble](#preamble)
  - [Steps to reproduce](#steps-to-reproduce)

## Preamble

Not many people know, but git allows you to change your old commit in a way that is as unnoticeable as possible. I call it ninja-commit.

Make sure that the last commit in the selected branch belongs to you, yes, you can change other people's commits, but it will be difficult in github when policies are configured, also it is more likely to be noticed - for example a person came to github, saw his commit last, and made a push without a pull, in case you changed his commit, he will get a conflict.

## Steps to reproduce

So, if you want to quietly change your last commit and not get caught, you need to do the following steps:

1. Actually make changes to the project.
2. Open a NEW terminal (we will change the environment parameters, and it is desirable to make future commits without this).
3. Do `git add .` to tell git about the changes.
4. Execute this complex and tricky command to do the commit and swap the date:
`GIT_COMMITTER_DATE="$(git log -1 --format="%aD")" git commit --amend --no-edit --date "$(git log -1 --format="%aD")"`.
5. Do `git push -f`.
6. Close terminal.

Done!

> Note: From Windows need to use `git bash` terminal (packed with git scm installer).

Tags: #git, #hack
