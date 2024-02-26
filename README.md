# init-new-gh-repo-script

This repo contains a simple script you can run on your local Windows machine, using powershell to create a new repo, initialise it, whilst also creating a new directory on your system

## Dependancies

- Github CLI installed and configured (see Github documentation for this)
- Git installed and configured (see git documentation for this)

## How to use

1. Start by creating a new powershell script on your local machine in a location of your choice and give it a name of your choice
   1. I chose to create a folder in my home directory called `scripts` and named the file `init-new-gh-repo.ps1`
2. Copy and paste the code from this repo in there and save
3. To use, from the command line navigate to where you want your new directory for your repo to be created. (For example I use my `~\Onedrive\Desktop` folder). Using the command `cd ~\OneDrive\Desktop`
4. From the command line, navigate to the ps1 script and run it. So if it was saved in your home directory under `scripts` with a file name of `init-new-gh-repo.ps1` then you can type `~\scripts\init-new-gh-repo.ps1`

## Prompts

1. The user is prompted for a repo name (this must not contain spaces [error handling TODO]). It also cannot be an existing repo name.
2. This repo name is also used to create a new directory, so you cannot have a directory with that name also [error handling TODO]
3. The user is also prompted to select if they want a private or a public repo by pressing `1` for `private` or `2` for public

## What the script does

Based on the above:
- It will create a new repo
- Create a new directory in the Windows directory you are currently in
- It will initialise the basic minimum requirements for a repo generation based on the initialisation commands provided by github when creating a new repo

## Credits
The documentation from github for creating a new repo from the command line was used to create this script. Here is the specific code

```pwsh
echo "# test1" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/<user_name>/<repo_name>.git
git push -u origin main
```

## Reasons for creating

1. As a learning exercise to automate a menial task
2. To combine repo initialisation and local directory creation into a single process

## Future features

1. Improve the error handling
2. Improve the prompting
3. Giving instructions to set in PATH as a command
4. Have an install script, to a `scripts` directory or PATH option

## Colaboration

I am happy to receive any comments and advice on this. I understand it may not be a complete solution for everyone, but it is a solution for me and my current workflow and needs.