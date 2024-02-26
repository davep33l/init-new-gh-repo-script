# Global variables
$global:repo_name = ""
$global:visibility = ""

# Ask for a repo name
# TODO: Add some error checking for spaces
$repo_name = Read-Host "Enter a repo name (no-spaces): "

# Ask for a visibility type
Write-Host "Select visibility:"
Write-Host "1. Private"
Write-Host "2. Public"
$privacyOption = Read-Host "Enter the number of your choice"

# Process user input for visibility
switch ($privacyOption) {
    "1" {
        Write-Host "You chose to create a new private repo"
        $visibility = "--private"
    }
    "2" {
        Write-Host "You chose to create a new public repo"
        $visibility = "--public"
    }
    default {
        Write-Host "Invalid option"
        exit 1 # Exit the script
    }
}

# Run the gh repo create command and capture the output (the 2>&1 means, redirect the standard error ("2") to the standard output ("&1"))
$createOutput = gh repo create $repo_name $visibility 2>&1
Write-Output "Github output: $createOutput"

# Check if the repo was successfully created
if ($createOutput -like "*already exists*") {
    Write-Host "Error: The repository name '$repo_name' is already taken."
    exit 1  # Exit the script
}

# Extract the repo URL from the output
$repoUrl = ($createOutput -split "`n" | Where-Object { $_ -like "http*" }).Trim()

# Extract username and repo name from the repo URL
$username = $repoUrl -replace 'https://github.com/([^/]+)/([^/]+).*', '$1'
$repository = $repoUrl -replace 'https://github.com/([^/]+)/([^/]+).*', '$2'

# Create the Git remote URL
$gitRemoteUrl = "https://github.com/$username/$repository.git"

# Print the repo URL
Write-Output "Repository URL: $repoUrl"

# Create local directory and move into it
New-Item -ItemType Directory -Name "$repo_name" # same as mkdir $repo_name or md $repo_name but wanted to keep to PWSH native commands
Set-Location -Path $repo_name # same as cd $repo_name but wanted to keep to PWSH native commands

# Create a README.md and add the repo name as the h1 markdown tag and ensures utf8 which is what github uses
Write-Output "# $repo_name" | Out-File -Encoding utf8 -Append README.md

# Initialises the repo
git init

# Adds the README.md file to the staging
git add README.md

# Commits the README.md as the Initial Commit
git commit -m "Initial Commit"

# Sets the branch as main
git branch -M main

# Sets the remote branch url
git remote add origin $gitRemoteUrl

# Pushes the changes
git push -u origin main