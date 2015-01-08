# Setup Instructions

* Mac and Linux
    * Install NodeJS and NPM - [Download](http://nodejs.org/download/)
    * Install NVM
        * `curl https://raw.github.com/creationix/nvm/master/install.sh | sh`
    * Install/Update NPM Packages
        * `npm install`
    * Install/Update Bower Packages
        * `bower install`
* Windows
    * Install NodeJS and NPM - [Download](http://nodejs.org/download/)
    * Ensure the following is in your PATH
        * Run `echo %PATH%` or go to System Settings - Environment Variables
        * The following items should be in your PATH:
            * C:\Program Files (x86)\Git\cmd
            * .\node_modules\.bin
        * If you make changes, you will need to restart your machine
    * Load the 'Node.js Command Prompt' or Git Bash shell
    * Install/Update NPM Packages
        * `npm install`
    * Install\Update Bower Packages
        * `bower install`

# Building the Project

##### DEVELOPMENT

* Run `grunt` from the shell
* Open a web browser and navigation to [http://localhost:4000](http://localhost:4000)

# Build Process

The project is using grunt to handle CoffeeScript and SASS compilations. Each time you run grunt, the following [grunt plugins](http://gruntjs.com/plugins) are executed:

* Coffeelint
    * Ensures all CoffeeScript files in the /src directories are free of errors
* Clean
    * Remove all contents from the /public directory
* Copy
    * Copies the Config, HTML and Vendor files to the /public directory
* CoffeeScript
    * Compiles all CoffeeScript (.coffee) files in the /src directory to JavaScript (.js) files in the /public directory
* SASS
    * Compiles SASS (.scss) files in the /src directory to CSS (.css) files in the /public directory
* Connect
    * Starts a local static development server at [http://localhost:4000](http://localhost:4000)
* Watch
    * Starts a watcher process that runs various parts of the build process as changes are made.
        * CoffeeScript files are linted and compiled
        * SASS files are compiled
        * HTML files are moved to the /public directory