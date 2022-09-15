#!/bin/sh

# Make executable with chmod +x <<filename.sh>>

# TODO NOTES
# 1. Remove Commit History                      - DONE
# 2. Manage to Hide Access Token Contents       - DONE
# 3. Include module to handle accesstoken.txt   - DONE

#------------------------------------New Module for accesstoken.txt------------------------------------#

CURRENTDIR=`pwd`
echo "Current Directory: "$CURRENTDIR

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
echo "Press \"b\" if you would you like to use \"General Project Template\""
echo "Press \"c\" if you would you like to use \"Golang Project Template\""
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
echo "What name do you want to give your remote repo?"
read REPO_NAME

echo "Enter a repo description: "
read DESCRIPTION

# step 2:  the local project folder path
echo "\n What is the absolute path to your local project directory? e.g '/Volumes/HDD/Projects'"
echo "\n Or For Windows: /d D:/'VS Code Projects'"
read PROJECT_PATH

echo"\n Entered Project PATH: $PROJECT_PATH"

echo"\n Is this correct? (Y/N)"
read CHOICE
if [$CHOICE=="Y"]; then
    break
else
    echo "\n Exiting.."
    sleep 3
    exit
fi

echo "What is your github username?"
read USER_NAME

# step 3 : go to path 
echo ""
cd "$PROJECT_PATH"
echo "Project Directory: "$PROJECT_PATH

echo ""
git clone ${TEMPLATE_LINK}
echo "Template Repo Cloned."

mv ${TEMPREPO} ${REPO_NAME}
echo ""
echo "Folder Renamed"
cd ${REPO_NAME}
echo ""
echo "Current Directory: `pwd`"
echo ""

echo "Template repo's origin: Removal in Process"
git remote remove origin
git init
echo "Template repo's origin: Removed"
echo ""

#------------------------------------New Module for Removing commit history------------------------------------#
echo "Template repo's Commit History: Removal in Process"
git checkout --orphan temp_branch
echo ""
git add .
echo ""
git commit -am "Initial Commit to Repository with Automation Script"
echo ""
git branch -D main
echo ""
git branch -m main
echo ""
git status
echo ""
git branch
echo ""
echo "Template repo's Commit History: Removed"
echo ""
#--------------------------------------------------------------------------------------------------------------#

# step 5 use github API to log the user in
echo "Generating Repository on Github..."
curl -u \"${USER_NAME}\":${PERSONAL_ACCESS_TOKEN} https://api.github.com/user/repos -d '{"name":"'"${REPO_NAME}"'","description":"'"${DESCRIPTION}"'","public":"true"}'
echo "New Repo created on Github"

#  step 6 add the remote github repo to local repo and push
echo "Setting Remote Origin..."
git remote add origin https://github.com/${USER_NAME}/${REPO_NAME}.git
git push -u -f origin main
echo "New Remote Origin set"

# step 7 change to your project's root directory.
cd ${PROJECT_PATH}/${REPO_NAME}
echo "Local Repository Directory: "`pwd`

echo "GITHUB REPOSITORY LINK: https://github.com/$USER_NAME/$REPO_NAME"
echo ""
echo " *** You're now in your project root. ***\n"