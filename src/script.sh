#!/bin/sh

# Make executable with chmod +x <<filename.sh>>

# TODO NOTES
# 1. Remove Commit History                      - DONE
# 2. Manage to Hide Access Token Contents       - DONE
# 3. Include module to handle accesstoken.txt   - DONE

#------------------------------------New Module for accesstoken.txt------------------------------------#

CURRENTDIR=`pwd`
echo "\nCurrent Directory: "$CURRENTDIR

FILE=./accesstoken.txt
if [ -f "$FILE" ]; then
    echo "Access Token already exists."
    break
else 
    echo "Access Token does not exist."
    echo "Creating Access Token File."
    touch accesstoken.txt
    echo "Enter Your Github Personal Access Token: "
    read KEY_INPUT

    if [ -f "$FILE" ]; then 
        echo -n "$KEY_INPUT" >> "$FILE"
    fi
fi

PERSONAL_ACCESS_TOKEN=`cat accesstoken.txt`
CHARACTERS=`wc -c < accesstoken.txt`
echo "Your Access Token is: "$PERSONAL_ACCESS_TOKEN
echo "Length of Access Token: "$CHARACTERS
#------------------------------------------------------------------------------------------------------#

#--------------------------------New Module: Ask for Custom Template-----------------------------------#
clear
echo "\nPress \"a\" if you would you like to use your own public template repo"
echo "\nPress \"b\" if you would you like to use \"General Project Template\""
echo "\nPress \"c\" if you would you like to use \"Golang Project Template\""
echo "\nWrong inputs will exit the script."

GIT_LINK="https://www.github.com/"

echo "\nEnter a/b/c:"
read NUMBER_CHOICE

case $NUMBER_CHOICE in
    a)
        echo "> Enter GitHub Repo Owner UserName: "
        read GITUSER
        TEMPLATE_LINK="$GIT_LINK$GITUSER"
        TEMPLATE_LINK="$TEMPLATE_LINK/"
        echo "> Enter ${GITUSER}'s Template RepoName: "
        read TEMPREPO
        TEMPLATE_LINK="$TEMPLATE_LINK$TEMPREPO"
        echo $TEMPLATE_LINK
        ;;
    b)
        echo "> General Project Template Chosen"
        TEMPREPO="general-project-template"
        TEMPLATE_LINK="https://github.com/hassanaftab93/general-project-template"
        echo $TEMPLATE_LINK
        ;;
    c)  
        echo "> Golang Project Template Chosen"
        TEMPREPO="go-project-template"
        TEMPLATE_LINK="https://github.com/hassanaftab93/go-project-template"
        echo $TEMPLATE_LINK
        ;;
    *)
        printf 'No match for "%s"\n' "$NUMBER_CHOICE"
        exit
esac

#------------------------------------------------------------------------------------------------------#

# step 1: name of the remote repo. Enter a SINGLE WORD ..or...separate with hyphens
echo "\nWhat name do you want to give your remote repo?"
read REPO_NAME

echo "\nEnter a repo description: "
read DESCRIPTION

# step 2:  the local project folder path
echo "\n What is the absolute path to your local project directory? e.g '/Volumes/HDD/Projects'"
echo "\n Or For Windows: D:/VS Code Projects"
read PROJECT_PATH

echo "\n Entered Project PATH: $PROJECT_PATH"

echo "\nWhat is your github username?"
read USER_NAME

# step 3 : go to path
cd "$PROJECT_PATH"
echo "\nProject Directory: "$PROJECT_PATH

git clone ${TEMPLATE_LINK}
echo "\nTemplate Repo Cloned."

mv ${TEMPREPO} ${REPO_NAME}
echo "\nFolder Renamed"
cd ${REPO_NAME}
echo "\nCurrent Directory: `pwd`"

echo "\nTemplate repo's origin: Removal in Process"
git remote remove origin
git init
echo "\nTemplate repo's origin: Removed\n"

#------------------------------------New Module for Removing commit history------------------------------------#
echo "Template repo's Commit History: Removal in Process"
git checkout --orphan temp_branch
git add .
git commit -am "Initial Commit to Repository with Automation Script"
git branch -D main
git branch -m main
git status
git branch
echo "\nTemplate repo's Commit History: Removed\n"
#--------------------------------------------------------------------------------------------------------------#

# step 5 use github API to log the user in
echo "\nGenerating Repository on Github..."
curl -u \"${USER_NAME}\":${PERSONAL_ACCESS_TOKEN} https://api.github.com/user/repos -d '{"name":"'"${REPO_NAME}"'","description":"'"${DESCRIPTION}"'","public":"true"}'
echo "\nNew Repo created on Github"

#  step 6 add the remote github repo to local repo and push
echo "\nSetting Remote Origin..."
git remote add origin https://github.com/${USER_NAME}/${REPO_NAME}.git
git push -u -f origin main
echo "\nNew Remote Origin set"

# step 7 change to your project's root directory.
cd ${PROJECT_PATH}/${REPO_NAME}
echo "\nLocal Repository Directory: "`pwd`

echo "\nGITHUB REPOSITORY LINK: https://github.com/$USER_NAME/$REPO_NAME"
echo "\n *** You're now in your project root. ***\n"