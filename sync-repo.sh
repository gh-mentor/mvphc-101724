# This bash script uses git to sync changes between a local and remote GitHub repository on branch 'main'.
# It assumes that the remote repository is already set up and that the local repository is already cloned.

# Pull changes from remote repository
git pull 

# Stage all changes
git stage .

# Commit changes with message 'Synced changes'
git commit -m "Updated"

# Push changes to remote repository on branch 'main'
git push 

