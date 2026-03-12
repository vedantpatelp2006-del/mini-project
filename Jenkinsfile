pipeline {
    agent any

    environment {
        PHP_PATH       = 'C:\\Users\\MB540WS\\.config\\herd-lite\\bin\\php.exe'
        COMPOSER_PATH  = 'C:\\Users\\MB540WS\\.config\\herd-lite\\bin\\composer.bat'
		MYSQL_PATH     = 'C:\\Program Files\\MySQl\\MySQL Server 8.0\\bin\\mysql.exe' 
		MYSQL_PASSWORD = 'admin'
    }

    stages {
	
	  stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-vedant',
                    url: 'https://github.com/vedantpatelp2006-del/mini-project'
            }
        }

        stage('Dependencies') {
            steps {
                // Verify composer.json exists in workspace
                bat 'dir composer.json'         
                
                // Install PHP dependencies -> creates vendor/autoload.php
                bat "%COMPOSER_PATH% install --no-progress --no-interaction"
				
            }
        }
	
	  stage('Environment') {
		steps {
			bat """
			copy /Y .env.example .env
			"%PHP_PATH%" artisan key:generate --force
			"""
		}
	  }
        
      stage('Test DB') {
            steps {
				bat """
				"%MYSQL_PATH%" -h localhost -u root -p%MYSQL_PASSWORD% -e "DROP DATABASE IF EXISTS laravel;"
				"%MYSQL_PATH%" -h localhost -u root -p%MYSQL_PASSWORD% -e "CREATE DATABASE laravel CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
				"%PHP_PATH%" artisan migrate:fresh --seed
				"""

            }
        }	
    }


}
