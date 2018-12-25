# Cyber-dashboard

If you would like to use one of this options, perform the following:
1. In whatever repo you want this turned on in, navigate to .git/hooks in the terminal.
2. Run `mv pre-commit.sample pre-commit` to rename the sample file and activate it.
3. Paste one of the following into that file and save.
4. Feel free to edit anything you would like in your own hook! They aren't commited, so you're welcome to have a custom configuration.

All of these assume that `rubocop` is installed in the Gemfile and that a `rubocop.yml` file exists in the directory. At a minimum, `rubocop` must be installed. If you don't have a `rubocop.yml` file, the default configuration will be used.

### Useful for command line interfaces as it stops to ask the user if they want to run with autocorrect on before committing. Does not work with SourceTree or RubyMine.

```
#!/bin/sh
#
# An example hook script to verify what is about to be committed.
# Called by "git commit" with no arguments.  The hook should
# exit with non-zero status after issuing an appropriate message if
# it wants to stop the commit.
#
# To enable this hook, rename this file to "pre-commit".
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
cyan='\033[0;36m'
white='\033[1;37m'
NC='\033[0m'

if git rev-parse --verify HEAD >/dev/null 2>&1
then
	against=HEAD
else
	# Initial commit: diff against an empty tree object
	against=cc79c00a6302a0b54840b6dee0a583a43f9c5427
fi

# Allows us to read user input below, assigns stdin to keyboard
exec < /dev/tty

# Get only the staged files
FILES="$(git diff --cached --name-only --diff-filter=AMC | grep "\.rb$" | tr '\n' ' ')"

echo "${green}[Ruby Style][Info]: Checking Ruby Style for all files staged for this commit!${NC}"
echo "${cyan}[Ruby Style][Info]: If you would like to skip this check while committing, add --no-verify or -n to the git commit command${NC}"
echo "${yellow}[Ruby Style][Warning]: Style violations will prevent you from commiting. If you choose not to fix them, you will need the --no-verify flag${NC}"
echo ""
echo "${white}Before we get started, would you like to turn on autocorrect to correct simple style violations automatically [y/n]?${NC}"
read autocorrect

if [ -n "$FILES" ]
then
	echo "${green}[Ruby Style][Info]: Checking the following staged files:${NC}"
	echo "${green}[Ruby Style][Info]: ${FILES}${NC}"

	# Run rubocop on the staged files
	if [ "$autocorrect" = "" ]; then
    autocorrect='n'
  fi
  case $autocorrect in
      [Yy] )
			    echo "${green}[Ruby Style][Info]: Running rubocop with autocorrect!${NC}"
					bin/bundle exec rubocop -a ${FILES}
					;;
      [Nn] )
					echo "${green}[Ruby Style][Info]: Running rubocop without autocorrect!${NC}"
			    bin/bundle exec rubocop ${FILES}
					;;
  esac

	if [ $? -ne 0 ]; then
	  echo "${red}[Ruby Style][Error]: Please fix the issues and try to commit again, or commit with --no-verify if you do not think they need to be fixed${NC}"
	  exit 1
	fi
else
	echo "${green}[Ruby Style][Info]: No files to check${NC}"
fi

# If there are whitespace errors, print the offending file names and fail.
exec git diff-index --check --cached $against --

exit 0
```
