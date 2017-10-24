node('nodejs_slave'){
    stage("Checkout"){
        checkout scm;
    }

    stage("Install"){
        dir('app'){
            sh 'npm install';

        }
    }

    stage("Unit Test"){
        dir('app'){
            sh 'npm run test:unit';
            sh 'npm run test:lint';
        }
    }


    stage("Sonar"){
        dir('app'){
            withSonarQubeEnv {
                def scannerHome = tool 'default-sonar';
                sh "${scannerHome}/bin/sonar-scanner";
            }
        }
    }

    //This happens nodeless, as in on Jenkins - build can move on
    timeout(time: 1, unit: 'MINUTES') { 
			def qg = waitForQualityGate() 
				if (qg.status != 'OK') {
					error  "echo 'Pipeline unstable due to quality gate failure: ${qg.status}'";
				}
    }//eo timeout



    stage("Package"){
        dir('app'){
            sh 'npm prune'
                sh 'npm version'
                sh 'pac'
                REPLACE_TOKEN_FILE_VAL=sh(returnStdout: true, script: 'npm pack').trim()

                REPLACE_TOKEN_VERSION_VAL=sh(returnStdout: true,
                        script: "cat package.json | grep 'version.*' | cut -d':' -f2  | sed s'/\"//g' | sed s'/,//'").trim()

                sshagent(['git']) {
                    sh 'git config  user.email "pipeline@p9e.io" && git config user.name "Build Pipeline"' //need to use withEnv
                        sh 'git push --tags'
                        sh 'git checkout -b releases/' + REPLACE_TOKEN_VERSION_VAL
                        sh 'git add package.json && git commit -am "Release"'
                        sh 'git push'
                }
            sh 'cp "${REPLACE_TOKEN_FILE_VAL}" "latest.tgz"'
                sh 'node scripts/deploy.js'
        }
    }

}//eo pl




