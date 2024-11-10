Step 1: Create a folder and file in the root of our cloned repository
git clone https://github.com/DipanshuRawat/demo.git
mkdir ninja
echo "Trying fast forward merge" > ninja/README.md
Step 2: Create a branch ninja and move to it
git checkout -b ninja
Step 3: Check the current status and commit changes
git status
git add ninja/README.md
git commit -m "Added content to README.md in ninja folder"
Step 4: Merge ninja branch to main with a new commit
git checkout main
git merge ninja
git log --oneline
Step 5: Simulate changes in main and ninja to generate a merge conflict
echo "Changes in master branch" > ninja/README.md
git add ninja/README.md
git commit -m "Changes in master branch"
git checkout ninja
echo "Changes in ninja branch" > ninja/README.md
git add ninja/README.md
git commit -m "Changes in ninja branch"
Step 6: Merge ninja branch to main with a merge conflict
git checkout main
git merge ninja
For Resolve the conflict using the ours and theirs strategy:
we use "ours" to keep the changes from the main branch
git checkout --ours ninja/README.md
we use "theirs" to keep the changes from the ninja branch
git checkout --theirs ninja/README.md
After resolving the conflict, complete the merge by adding the resolved file and committing the merge.
git add ninja/README.md
git commit -m "Resolved merge conflict and merged ninja branch to main"
Rebase ninja onto main
git checkout main
git merge ninja
Verify the Merge
git log --oneline