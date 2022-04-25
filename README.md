# Repository-Automation

1) I keep my scripts in my root/home folder, in a sub-folder called scripts.  I suggest you do the same or similar.  To get to the root/home folder, in your terminal type cd ~ because the tilda ( ~ )is the symbol for the home folder.  In your Mac Finder app it shows up as the one with a house icon.  So all my scripts are stored in ~/scripts

2) This matters because to run a shell script from any directory in the terminal, you have to type out the full path.  In my case I have to type out ~/scripts/script.sh to run the script.

3) Download the shell script file in the Repo.  The .sh is the extension for shell scripts.  Save the file in the directory you want to save it at - again I recommend ~/scripts as the folder to save your scripts in.

4) Navigate to that folder in your terminal. To be safe run ls in the terminal to check that you can see the script is there. If it's not you're in the wrong folder or step 3 didn't successfully complete.

5) Make the shell script executable.  To do that you type the following in the terminal: chmod +x <<the-correct-filename.sh>>.  This is the unix way to make a shell script "executable".

6) navigate to your projects folder and make a new folder that you intend to house your project.  Effectively, you've got to do this:
    - mkdir - create a project-of-some-name inside the folder where you keep all your projects.
    - cd into this folder and then type pwd to get the full path.
    - Copy that - you will need to paste it shortly.
    - It should look like my-computer/my-projects/project-of-some-name

7) open your terminal again, and then type ~/scripts/<<the-correct-filename.sh>>.  The script runs!  You will be guided through some input...   The main steps are:
 
  > what do you want to call your Github repo (don't use spaces- 'my-awesome-project' is good. Don't use 'my awesome project' as the repo name.

  > Enter a description that shows up in the Github repo's description. For this it's safe to use spaces.

 >  Enter the project path you got in step 6, the one that you get after typing pwd in the terminal and getting something like my-computer/my-projects/project-of-some-name

 > enter your Github username (not email address) and then your Github password.  Be careful as you type as these values don't show up on the screen.

 > ....that's it.  The script will set up your git repo locally inside my-computer/my-projects/project-of-some-name and then create a README.MD (blank) and then commit it locally, then set up a remote repo in Github (log you in via API) etc and then push everything up!

 > finally, you will see that the terminal you were interacting with has changed the currently active directory to your project folder. It will now be at my-computer/my-projects/project-of-some-name and you can type in ls and see the README.MD file. If you then type git status you will see your local repo's status (the state of your local project) and if you type in git remote it will show you the Github url for your project!
