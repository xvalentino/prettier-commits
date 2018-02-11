#!/bin/bash
# escape if branch named 683adea0-51b1-460c-8156-c6d040d6c807
# PRETTIFY ALL CURRENT CHANGES
echo 'getting current branch'
currentBranch=$(git branch | awk '/\*/ { print $2; }')
echo "$currentBranch" 'set'

echo 'getting jsfiles'
jsfiles=$(git diff master --name-only --diff-filter=ACM "*.js" "*.jsx" | tr '\n' ' ')
echo "$jsfiles" 'set'

echo 'running prettier on current branch'
echo "$jsfiles" | xargs ./node_modules/.bin/prettier --write
echo 'ran prettier on current branch'

echo 'commiting changes'
echo "$jsfiles" | (xargs git add) && git commit --amend --no-edit
echo 'changes commited'

# git fetch && git checkout origin/master
git checkout master
git checkout -b 683adea0-51b1-460c-8156-c6d040d6c807
echo "$jsfiles" | xargs ./node_modules/.bin/prettier --write
echo "$jsfiles" | (xargs git add) && git commit -m 'prettier changes'
echo "$currentBranch" | xargs git checkout
git rebase -s=ours 683adea0-51b1-460c-8156-c6d040d6c807
git branch -D 683adea0-51b1-460c-8156-c6d040d6c807
