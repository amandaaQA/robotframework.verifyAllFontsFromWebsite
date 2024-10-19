Introduction
------------

This routine was created to verify if there is a specific prohibited font begin used in the website

How to use
----------------
You can run routine in two ways:
1. If the website is in production and there is a sitemap:
    - Set the variables:
        - GET_URL_AUTOMATICALLY with True
        - BASE_URL with the homepage URL;
        - Lista_fontes_proibidas with the prohibited fonts that you want verify if are begin used in the website;
    - Run the test case and the bot will find all the urls related to the homepage automatically and test if one of the prohibited fonts are begin used in the website;
    - Verify the report 'report_verificacao' or the logs for more information about the results;

2. If the website still don't have a sitemap, you can configure the urls manually:
    [Manual execution](example/manual-process.gif.gif)
    - Set the variables:
        - GET_URL_AUTOMATICALLY with False
        - LISTA_URLS with all urls you want to verify;
        - Lista_fontes_proibidas with the prohibited fonts that you want verify if are begin used in the website;
    - Run the test case and the bot will test if the prohibited fonts are begin used in the urls configured previously;
    - Verify the report 'report_verificacao' or the logs for more information about the results;

PS:
    - If your site/url requires authentication, you can use the variables COOKIE_NAME and COOKIE_VALUE to configure the session;

INSTALATION
----------------
1. pip install -U -r requirements.txt
2. install chrome driver
    1. You need chromeDriver not Chrome to run the automation. Start by downloading the chrome driver: https://sites.google.com/a/chromium.org/chromedriver/downloads ;
    2. Choose the driver with same version that you've already installed on your computer (in chorme, go to the session "about" and verify the chrome version);
    3. Unzip and Install the webdriver: copy chromedriver.exe to C: folder;
3. install RobotFramework extension "RobotCode - Robot Framework Support" on VScode;
4. Run and test your code;
